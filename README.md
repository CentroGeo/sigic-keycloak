# sigic-keycloak


# Variables de entorno

Se necesita crear un archivo .env con las siguientes variables de entorno, con los
valores adecuados de conexión a la base de datos, las opciones de java son opcionales.

HTTPS_METHOD=noredirect es necesario descomentarlo para ejecutar solo la primera vez 
para poder generar el primer certificado ssl de letsencrypt. 

Las variables KC_BOOTSTRAP_ADMIN_USERNAME y KC_BOOTSTRAP_ADMIN_PASSWORD solo deben definirse 
solo en el primer inicio y son necesarias para generar el usuario y password inicial

```bash
KC_HOSTNAME=iam.nombre.de.dominio
JAVA_OPTS=-Xms512m -Xmx1024m
KC_DB_USERNAME=x[username]x
KC_DB_PASSWORD=x[password]x
KC_DB=postgres
KC_DB_URL_HOST=x[postgreshost]x
KC_DB_URL_DATABASE=x[databasename]x
# KC_BOOTSTRAP_ADMIN_USERNAME=admin
# KC_BOOTSTRAP_ADMIN_PASSWORD=admin123
```

Si se genero el usuario usando las variables de entorno KC_BOOTSTRAP_ADMIN_USERNAME y KC_BOOTSTRAP_ADMIN_PASSWORD
el usuario queda marcado como "temporary", esto no se puede cambiar en la interfaz de usuario, por lo que se debe 
ejecutar la siguiente consulta para cambiar el valor a null, directo en la base de datos:

```sql
UPDATE user_attribute SET value = false WHERE name = 'is_temporary_admin';
```

docker exec -it sigic-keycloak-keycloak-1 /bin/bash

/opt/keycloak/bin/kcadm.sh config credentials \
  --server http://localhost:8080 \
  --realm master \
  --user admin \
  --password TU_CONTRASEÑA

/opt/keycloak/bin/kcadm.sh add-roles \
  --realm master \
  --uusername nuevoadmin \
  --rolename admin


/opt/keycloak/bin/kcadm.sh add-roles \
  --realm master \
  --uusername kadmin \
  --rolename admin

## Extensiones

Hay algunas extensiones incluidas, seleccionadas para cubrir algunas necesidades, éstas se enlistan a continuación:

### keycloak-orcid

[keycloak-orcid](https://github.com/eosc-kc/keycloak-orcid) permite la autenticación de usuarios mediante ORCID, para 
ello se debe crear una aplicación en el portal de ORCID y obtener el client_id y client_secret. 
Esta extensión es necesaria debido a que orcid no es del todo estándar y no es suficiente con la configuración de un 
cliente OIDC, ya que no se puede obtener el userinfo mediante url ni mediante JWT.
