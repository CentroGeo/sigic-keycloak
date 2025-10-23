#!/bin/bash
set -e

# Esperar a la BD
until nc -z "${KC_DB_URL_HOST}" 5432; do
  echo "⏳ Esperando base de datos..."
  sleep 3
done

# Revisar si ya existe el usuario admin
if PGPASSWORD=$KC_DB_PASSWORD psql -h "$KC_DB_URL_HOST" -U "$KC_DB_USERNAME" -d "$KC_DB_URL_DATABASE" -tAc "SELECT 1 FROM user_entity WHERE username='admin';" | grep -q 1; then
  echo "✅ Admin ya existe, arrancando Keycloak normalmente..."
  exec /opt/keycloak/bin/kc.sh start --optimized
else
  echo "🚀 Inicializando admin por primera vez..."
  export KC_BOOTSTRAP_ADMIN_USERNAME=${KC_BOOTSTRAP_ADMIN_USERNAME:-admin}
  export KC_BOOTSTRAP_ADMIN_PASSWORD=${KC_BOOTSTRAP_ADMIN_PASSWORD:-admin}
  exec /opt/keycloak/bin/kc.sh start --optimized
fi