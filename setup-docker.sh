#!/bin/bash

# Script para inicializar o ambiente Docker da aplicação SISGED

echo "🚀 Iniciando configuração do ambiente SISGED com Docker..."

# Criar diretórios necessários se não existirem
echo "📁 Criando diretórios necessários..."
mkdir -p uploads/{attachments,images,users,file_storage,onlyoffice,mail,templates}
mkdir -p backups/auto
mkdir -p tmp
mkdir -p cache
mkdir -p log
mkdir -p mysql-init

# Definir permissões
echo "🔧 Configurando permissões..."
chmod -R 755 uploads backups tmp cache log
chmod -R 777 uploads backups tmp cache log

# Backup da configuração original do banco
if [ -f "config/database.php" ] && [ ! -f "config/database.php.backup" ]; then
    echo "💾 Fazendo backup da configuração original do banco..."
    cp config/database.php config/database.php.backup
fi

# Usar configuração Docker para banco
echo "🐳 Configurando banco para Docker..."
cp config/database.docker.php config/database.php

echo "✅ Configuração concluída!"
echo ""
echo "Para iniciar a aplicação, execute:"
echo "  docker-compose up -d"
echo ""
echo "Acesse a aplicação em:"
echo "  - Web: http://localhost:8080"
echo "  - phpMyAdmin: http://localhost:8081"
echo ""
echo "Para parar a aplicação:"
echo "  docker-compose down"
echo ""
echo "Para visualizar logs:"
echo "  docker-compose logs -f web"
