#!/bin/bash

# Define o nome do projeto como o parâmetro de entrada ou como "ProjectTemplate" se não houver parâmetro
PROJECT_NAME="${1:-ProjectTemplate}"

# Define a variável de ambiente para ser usada no xcodegen
export PROJECT_NAME

# Remove alguns arquivos
rm -r "*.xcodeproj"

mv PROJECT_FILES $PROJECT_NAME

# Gera o projeto de exemplo
xcodegen