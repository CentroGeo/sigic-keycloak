#!/bin/bash
set -euo pipefail

FLAG_FILE="/opt/keycloak/data/.bootstrap_done"

# --- Función de log ---
log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
}

# --- Esperar a la base de datos ---
log "⏳ Esperando base de datos en ${KC_DB_URL_HOST:-<no-definido>}:5432 ..."
MAX_RETRIES=60
COUNT=0

until (echo > /dev/tcp/${KC_DB_URL_HOST}/5432) >/dev/null 2>&1; do
  COUNT=$((COUNT+1))
  if [ "$COUNT" -ge "$MAX_RETRIES" ]; then
    log "❌ No se pudo conectar a la base de datos tras ${MAX_RETRIES} intentos."
    exit 1
  fi
  log "⏳ Intento ${COUNT}/${MAX_RETRIES} — esperando base de datos..."
  sleep 3
done
log "✅ Base de datos disponible."

# --- Detectar modo ---
START_CMD="/opt/keycloak/bin/kc.sh start --optimized"
if [[ "${KC_DEV_MODE:-false}" == "true" ]]; then
  START_CMD="/opt/keycloak/bin/kc.sh start-dev"
  log "🧩 Modo desarrollo detectado."
fi

# --- Inicialización bootstrap ---
if [[ -f "$FLAG_FILE" ]]; then
  log "✅ Admin ya inicializado previamente, arrancando Keycloak..."
  exec "$START_CMD"
fi

log "🚀 Inicializando admin por primera vez..."
export KC_BOOTSTRAP_ADMIN_USERNAME="${KC_BOOTSTRAP_ADMIN_USERNAME:-admin}"
export KC_BOOTSTRAP_ADMIN_PASSWORD="${KC_BOOTSTRAP_ADMIN_PASSWORD:-admin}"

# Arrancar Keycloak y esperar resultado
set +e
"$START_CMD" &
pid=$!
wait $pid
EXIT_CODE=$?
set -e

if [[ $EXIT_CODE -eq 0 ]]; then
  log "✅ Keycloak iniciado correctamente. Marcando bootstrap como completado."
  touch "$FLAG_FILE"
else
  log "❌ Error al iniciar Keycloak (código $EXIT_CODE). No se marcará bootstrap."
  exit $EXIT_CODE
fi
