# Google Dork Scanner

Ferramenta automatizada para execução de Google Dorks com foco em pentest e reconhecimento de ativos.

## 🔧 Funcionalidades

- Execução automatizada de múltiplos dorks simultaneamente
- Rotação de User-Agents para evitar bloqueios
- Suporte a proxychains para anonimização
- Gerenciamento inteligente de delays entre requisições
- Log estruturado com timestamp para auditoria
- Filtragem de resultados por domínio alvo

## 🛠️ Tecnologias

- Bash Scripting (controle de fluxo e lógica principal)
- cURL (requisições HTTP)
- proxychains (roteamento anônimo)
- Python3 (URL encoding)
- GNU grep (filtragem de resultados)

## 📌 Como Usar

```bash
chmod +x dork.sh
./dork.sh exemplo.com



Configuração
Edite as variáveis no script para customização:

USER_AGENTS: Lista de User-Agents para rotacionar

DELAY: Intervalo entre requisições (em segundos)

DORKS: Array com os dorks a serem executados

Estrutura de Arquivos
/google-dork-scanner/
├── dork.sh                # Script principal
├── README.md              # Esta documentação
├── config/                # Arquivos de configuração
│   └── proxies.conf       # Configuração de proxies
└── logs/                  # Logs históricos
    └── dork_log_*.txt     # Resultados das varreduras



