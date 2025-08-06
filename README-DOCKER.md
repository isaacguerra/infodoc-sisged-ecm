# Sistema SISGED - Configuração Docker

Este repositório contém a configuração Docker para executar o Sistema SISGED com PHP 8, Apache e MySQL.

## 📋 Pré-requisitos

- Docker
- Docker Compose

## 🚀 Início Rápido

1. **Execute o script de configuração:**
   ```bash
   ./setup-docker.sh
   ```

2. **Inicie os containers:**
   ```bash
   docker-compose up -d
   ```

3. **Acesse a aplicação:**
   - **Web**: http://localhost:8080
   - **phpMyAdmin**: http://localhost:8081

## 🐳 Serviços Docker

### Web (Apache + PHP 8)
- **Porta**: 8080
- **Volumes**:
  - `./uploads` → `/var/www/html/uploads` (arquivos enviados)
  - `./backups` → `/var/www/html/backups` (backups do sistema)
  - `./tmp` → `/var/www/html/tmp` (arquivos temporários)
  - `./cache` → `/var/www/html/cache` (cache do sistema)
  - `./log` → `/var/www/html/log` (logs da aplicação)

### MySQL 8.0
- **Porta**: 3306
- **Banco**: `sisged`
- **Usuário**: `sisged_user`
- **Senha**: `sisged_pass`
- **Root**: `root123`
- **Volume**: `sisged_mysql_data` (dados persistentes)

### phpMyAdmin
- **Porta**: 8081
- **Usuário**: `root`
- **Senha**: `root123`

## 📁 Estrutura de Volumes

```
projeto/
├── uploads/           # Arquivos enviados (persistente)
├── backups/           # Backups do sistema (persistente)
├── tmp/               # Arquivos temporários (persistente)
├── cache/             # Cache do sistema (persistente)
├── log/               # Logs da aplicação (persistente)
└── mysql-init/        # Scripts de inicialização do MySQL
```

## 🔧 Comandos Úteis

### Gerenciar containers
```bash
# Iniciar serviços
docker-compose up -d

# Parar serviços
docker-compose down

# Reiniciar serviços
docker-compose restart

# Ver logs
docker-compose logs -f web
docker-compose logs -f db
```

### Backup e Restore
```bash
# Backup do banco
docker-compose exec db mysqldump -u root -proot123 sisged > backup_$(date +%Y%m%d_%H%M%S).sql

# Restore do banco
docker-compose exec -T db mysql -u root -proot123 sisged < backup.sql
```

### Acesso ao container
```bash
# Acessar container web
docker-compose exec web bash

# Acessar container MySQL
docker-compose exec db mysql -u root -proot123
```

## ⚙️ Configurações

### PHP
- **Upload máximo**: 50MB
- **Memory limit**: 512MB
- **Execution time**: 300s
- **Timezone**: America/Sao_Paulo

### MySQL
- **Modo SQL**: Desabilitado (compatibilidade)
- **Autenticação**: mysql_native_password

## 🔒 Segurança

**IMPORTANTE**: Para ambiente de produção, altere as senhas padrão nos arquivos:
- `docker-compose.yml`
- `config/database.docker.php`

## 🐛 Solução de Problemas

### Erro de permissão em arquivos
```bash
sudo chown -R $USER:$USER uploads backups tmp cache
chmod -R 755 uploads backups tmp cache
```

### Reset completo
```bash
docker-compose down -v
docker system prune -f
./setup-docker.sh
docker-compose up -d
```

### Verificar logs de erro
```bash
docker-compose logs web | grep -i error
```

## 📝 Notas

1. A configuração original do banco (`config/database.php`) é preservada como backup
2. Os volumes garantem persistência dos dados mesmo após recriação dos containers
3. O phpMyAdmin facilita a administração do banco de dados
4. Logs do Apache são acessíveis via `docker-compose logs web`
