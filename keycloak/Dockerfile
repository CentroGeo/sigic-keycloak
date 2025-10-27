FROM quay.io/keycloak/keycloak:26.4.0
USER root

# Copiar el themes personalizado al directorio de temas
COPY themes/sigic /opt/keycloak/themes/sigic
COPY providers/keycloak-orcid.jar /opt/keycloak/providers/

# Copiar entrypoint
COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

# Realizar el build de Keycloak con las variables correctamente en entorno
RUN /opt/keycloak/bin/kc.sh build

# Volver al usuario keycloak para ejecutar el contenedor
USER keycloak
ENTRYPOINT ["/opt/entrypoint.sh"]