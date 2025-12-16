#!/bin/bash
set -e

FLAG_FILE="/opt/keycloak/data/.bootstrap_done"

echo "⏳ Esperando base de datos en ${KC_DB_URL_HOST}:5432 ..."
until (echo > /dev/tcp/${KC_DB_URL_HOST}/5432) >/dev/null 2>&1; do
  echo "⏳ Esperando base de datos..."
  sleep 3
done
echo "✅ Base de datos disponible."

START_CMD=(
  /opt/keycloak/bin/kc.sh start
  --http-relative-path="${KC_HTTP_RELATIVE_PATH:-/}"
  --http-management-relative-path="${KC_HTTP_RELATIVE_PATH:-/}"
)

if [ -f "$FLAG_FILE" ]; then
  echo "✅ Admin ya inicializado previamente, arrancando Keycloak normalmente..."
  exec "${START_CMD[@]}"
fi

echo "🚀 Inicializando admin por primera vez..."
export KC_BOOTSTRAP_ADMIN_USERNAME=${KC_BOOTSTRAP_ADMIN_USERNAME:-kadmin}
export KC_BOOTSTRAP_ADMIN_PASSWORD=${KC_BOOTSTRAP_ADMIN_PASSWORD:-kadmin}

touch "$FLAG_FILE"

exec "${START_CMD[@]}"
