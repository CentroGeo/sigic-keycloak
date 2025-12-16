FROM quay.io/keycloak/keycloak:26.4.7
USER root

# Definir variables de entorno mínimas para Keycloak
ARG KC_DB=postgres
ENV KC_DB=${KC_DB}

# Copiar el themes personalizado al directorio de temas
COPY themes/sigic /opt/keycloak/themes/sigic
COPY providers/keycloak-orcid.jar /opt/keycloak/providers/

# Copiar entrypoint
COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

# Volver al usuario keycloak para ejecutar el contenedor
USER keycloak
ENTRYPOINT ["/opt/entrypoint.sh"]
