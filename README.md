Quand j'ai besoin de développer quelques choses et que j'ai besoin de service d'infrastructure, je passe mon tempps à regarder sur internet comment les instancier. Avec ce projet, je clone et je lance une seule commande.

## Usage

```
Syntaxe : make SERVICE

SERVICE = elasticsearch (version : docker.elastic.co/elasticsearch/elasticsearch:7.15.1)
SERVICE = minio (version : quay.io/minio/minio:RELEASE.2021-11-05T09-16-26Z)
SERVICE = rabbitmq (version : rabbitmq:3-management-alpine)
SERVICE = mongodb (version : mongo:latest)
SERVICE = mysql (version : mysql:5.7.36)
SERVICE = postgresql (version : postgres:14)
SERVICE = redis (version : redis:6.2.6)
SERVICE = openldap (version : osixia/openldap:1.5.0)

Autres parametres :
SERVICE = sipf (Lance les services les plus courrament utilisés au SIPF)
SERVICE = sitle (Lance les services les plus courrament utilisés par sitle)
SERVICE = download (Précharge l'ensemble des images)
SERVICE = stop (Arrête tout les services)
SERVICE = clean (Supprime la totalité des volumes non utilisés)
```

## Comptes d'accès

- Elasticsearch : http://localhost:9200
- Kibana : http://localhost:5601
- Minio : http://localhost:9001 (admin/password)
- Rabbitmq :
  - Management : http://localhost:15672 (admin/password)
  - Server : amqp://admin:password@localhost:5672/
- Mongodb : mongodb://dev:password@localhost:27017/dev
- Mysql : mysql://user:password@localhost:3306/dev
- Postgresql : postgresql://user:password@localhost:5432/dev
- Redis : redis://user:password@localhost:6379/0
- Openldap :
  - uri="ldap://localhost:389", base="dc=citizen,dc=pf", login="cn=admin,dc=citizen,dc=pf", password="password"
  - uri="ldap://localhost:389", base="cn=config", login="cn=admin,cn=config", password="password"

