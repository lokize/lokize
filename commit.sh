#!/bin/bash
# filepath: /home/lokize/Developer/Lab51/lokize/commit.sh

# Ativa o modo de debug para visualizar os comandos executados
set -ex

# Muda para o diretório onde o script está localizado
cd "$(dirname "$0")" || exit 1

# Garante que o arquivo README.md exista
README_FILE="README.md"
[ -f "$README_FILE" ] || touch "$README_FILE"

# Função para modificar o README.md
modify_readme() {
    # Adiciona uma linha com a data atual ao README.md
    echo "" >>"$README_FILE"
}

# Modifica o README.md
modify_readme

# Verifica se há alterações para commitar
if [ -n "$(git status --porcelain)" ]; then
    # Adiciona todas as mudanças ao git
    git add .
    # Realiza o commit com uma mensagem que inclui a data
    git commit -m "Atualização em $(date)"
    echo "Commit realizado com sucesso!"

    # Atualiza a branch local com as mudanças do remoto antes de enviar (resolvendo conflito de fast-forward)
    git pull --rebase

    # Sincroniza com o repositório remoto
    git push
else
    echo "Nenhuma alteração a ser commitada."
fi
