#!/bin/sh

php bin/magento setup:install \
--base-url=http://localhost \
--db-host=mysql \
--db-name=magento \
--db-user=root \
--db-password=hardpass \
--page-cache-redis-server=redis \
--admin-firstname=admin \
--admin-lastname=admin \
--admin-email=gustavonovaes.dev@gmail.com \
--admin-user=admin \
--admin-password=admin123 \
--language=pt_BR \
--currency=BRL \
--timezone=America/Recife \
--use-rewrites=1 \
--search-engine=elasticsearch7 \
--elasticsearch-host=es \
--disable-modules=Magento_TwoFactorAuth

php bin/magento indexer:set-mode schedule

php bin/magento indexer:reindex