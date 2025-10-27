FROM quay.io/keycloak/keycloak:26.4.0

USER root
SHELL ["/bin/bash", "-c"]
WORKDIR /opt/keycloak

COPY themes/sigic /opt/keycloak/themes/sigic
COPY providers/*.jar /opt/keycloak/providers/
COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh && \
    chown -R keycloak:keycloak .

USER keycloak
ENTRYPOINT ["/opt/entrypoint.sh"]