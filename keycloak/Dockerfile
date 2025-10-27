FROM quay.io/keycloak/keycloak:26.4.0
USER root

# Definir variables de entorno mínimas para Keycloak
ARG KC_DB=postgres
ARG KC_HTTP_RELATIVE_PATH=/iam
ARG KC_HTTP_MANAGEMENT_RELATIVE_PATH=/mngt
ENV KC_DB=${KC_DB}
ENV KC_HTTP_RELATIVE_PATH=${KC_HTTP_RELATIVE_PATH}
ENV KC_HTTP_MANAGEMENT_RELATIVE_PATH=${KC_HTTP_MANAGEMENT_RELATIVE_PATH}

# Copiar el themes personalizado al directorio de temas
COPY themes/sigic /opt/keycloak/themes/sigic
COPY providers/keycloak-orcid.jar /opt/keycloak/providers/

# Copiar entrypoint
COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

# Realizar el build de Keycloak con las variables correctamente en entorno
RUN /opt/keycloak/bin/kc.sh build --http-relative-path=${KC_HTTP_RELATIVE_PATH} --http-management-relative-path=${KC_HTTP_MANAGEMENT_RELATIVE_PATH}


# Volver al usuario keycloak para ejecutar el contenedor
USER keycloak
ENTRYPOINT ["/opt/entrypoint.sh"]