FROM quay.io/keycloak/keycloak:26.4.0


USER root
SHELL ["/bin/bash", "-c"]
WORKDIR /opt/keycloak

COPY themes/sigic themes/sigic
COPY providers/*.jar providers/
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh && \
    ./bin/kc.sh build --verbose && \
    chown -R keycloak:keycloak .

USER keycloak
ENTRYPOINT ["entrypoint.sh"]