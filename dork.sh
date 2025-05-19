#!/bin/bash

# Definindo cabeçalhos HTTP mais completos para parecer um usuário legítimo
USER_AGENTS=("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
             "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
             "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36")

# Aumentar o intervalo entre as requisições
DELAY=3  # Atraso em segundos entre as requisições

# Dorks a serem usados
declare -a DORKS=(
    "site:$TARGET ext:php intitle:index.of"
    "site:$TARGET inurl:admin"
    "site:$TARGET inurl:login"
    "site:$TARGET inurl:signup"
    "site:$TARGET ext:sql | ext:db | ext:bak"
)

# Função para realizar a pesquisa e extrair os resultados
run_dork() {
    local dork="$1"
    local encoded_dork
    encoded_dork=$(python3 -c "import urllib.parse; print(urllib.parse.quote('''$dork'''))")

    local search_url="https://www.google.com/search?q=$encoded_dork"
    local random_ua=${USER_AGENTS[$RANDOM % ${#USER_AGENTS[@]}]}  # Escolher um User-Agent aleatório

    echo "[*] Dorking: $dork" | tee -a "$LOG_FILE"

    # Usar curl com cabeçalhos e proxies
    proxychains curl -s -A "$random_ua" "$search_url" \
        | grep -Eo 'https?://[^&"]+' \
        | grep "$TARGET" \
        | sort -u >> "$LOG_FILE"

    # Atraso entre as requisições
    sleep $DELAY
}

# Executando o script
TARGET=$1
OUTPUT_DIR="dork_results"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$OUTPUT_DIR/dork_log_$TIMESTAMP.txt"
mkdir -p "$OUTPUT_DIR"

echo "[*] Iniciando Google Dork Scan para: $TARGET"
echo "[*] Resultados serão salvos em: $LOG_FILE"
echo "--------------------------------------------"

# Executando os Dorks
for dork in "${DORKS[@]}"; do
    run_dork "$dork"
done

echo -e "\n[✓] Scan finalizado. Verifique os resultados em: $LOG_FILE"
