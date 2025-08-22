FROM quay.io/keycloak/keycloak:26.3.3

USER root

# Definir variables de entorno mínimas para Keycloak
ENV KC_DB=postgres
ENV KC_HOSTNAME_STRICT=true
ENV JAVA_OPTS=-Xmx2G

# Copiar el themes personalizado al directorio de temas
COPY themes/sigic /opt/keycloak/themes/sigic
COPY providers/keycloak-orcid.jar /opt/keycloak/providers/

# Realizar el build de Keycloak con las variables correctamente en entorno
RUN KC_DB=$KC_DB KC_HOSTNAME_STRICT=$KC_HOSTNAME_STRICT JAVA_OPTS=$JAVA_OPTS /opt/keycloak/bin/kc.sh build


USER keycloak
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
