-- Arquivo de inicialização do MySQL para SISGED
-- Este arquivo é executado automaticamente na primeira inicialização do container MySQL

-- Configurações básicas do MySQL para compatibilidade
SET sql_mode = '';
SET GLOBAL sql_mode = '';

-- Configurações de charset
ALTER DATABASE sisged CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Se você tiver um dump SQL da aplicação, coloque o conteúdo aqui
-- Ou coloque arquivos .sql separados nesta pasta que serão executados automaticamente
