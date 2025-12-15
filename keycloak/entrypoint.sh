#!/bin/bash
set -e

FLAG_FILE="/opt/keycloak/data/.bootstrap_done"

# Esperar a la base de datos (sin nc)
echo "⏳ Esperando base de datos en ${KC_DB_URL_HOST}:5432 ..."
until (echo > /dev/tcp/${KC_DB_URL_HOST}/5432) >/dev/null 2>&1; do
  echo "⏳ Esperando base de datos..."
  sleep 3
done
echo "✅ Base de datos disponible."

# Verificar si ya se inicializó
if [ -f "$FLAG_FILE" ]; then
  echo "✅ Admin ya inicializado previamente, arrancando Keycloak normalmente..."
  exec /opt/keycloak/bin/kc.sh start \
  --http-relative-path="${KC_HTTP_RELATIVE_PATH:-/}" \
  --http-management-relative-path="${KC_HTTP_RELATIVE_PATH:-/}"
fi

# Primera ejecución: crear admin
echo "🚀 Inicializando admin por primera vez..."
export KC_BOOTSTRAP_ADMIN_USERNAME=${KC_BOOTSTRAP_ADMIN_USERNAME:-admin}
export KC_BOOTSTRAP_ADMIN_PASSWORD=${KC_BOOTSTRAP_ADMIN_PASSWORD:-admin}

# Crear el flag antes de salir para marcar que ya se hizo
touch "$FLAG_FILE"

exec /opt/keycloak/bin/kc.sh start --optimized