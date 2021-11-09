# Environnement
#
ELASTICSEARCH_IMAGE=docker.elastic.co/elasticsearch/elasticsearch:7.15.1
KIBANA_IMAGE=docker.elastic.co/kibana/kibana:7.15.1
MINIO_IMAGE=quay.io/minio/minio:RELEASE.2021-11-05T09-16-26Z
RABBITMQ_IMAGE=rabbitmq:3-management-alpine
MONGODB_IMAGE=mongo:latest
NGINX_IMAGE=nginx:1.19.2-alpine
MYSQL_IMAGE=mysql:5.7.36
POSTGRESQL_IMAGE=postgres:14
PGWEB_IMAGE=sosedoff/pgweb:0.11.9
REDIS_IMAGE=redis:6.2.6
OPENLDAP_IMAGE=osixia/openldap:1.5.0

run:
		@echo ""
		@echo "Syntaxe : make SERVICE"
		@echo ""
		@echo "SERVICE = elasticsearch (version : ${ELASTICSEARCH_IMAGE})"
		@echo "SERVICE = minio (version : ${MINIO_IMAGE})"
		@echo "SERVICE = rabbitmq (version : ${RABBITMQ_IMAGE})"
		@echo "SERVICE = mongodb (version : ${MONGODB_IMAGE})"
		@echo "SERVICE = mysql (version : ${MYSQL_IMAGE})"
		@echo "SERVICE = postgresql (version : ${POSTGRESQL_IMAGE})"
		@echo "SERVICE = redis (version : ${REDIS_IMAGE})"
		@echo "SERVICE = openldap (version : ${OPENLDAP_IMAGE})"
		@echo ""
		@echo "Autres parametres :"
		@echo "SERVICE = sipf (Lance les services les plus courrament utilisés au SIPF)"
		@echo "SERVICE = sitle (Lance les services les plus courrament utilisés par sitle)"
		@echo "SERVICE = download (Précharge l'ensemble des images)"
		@echo "SERVICE = stop (Arrête tout les services)"
		@echo "SERVICE = clean (Supprime la totalité des volumes non utilisés)"

# On précharge l'ensemble des services
download: download-elasticsearch download-minio download-rabbitmq download-mongodb download-mysql download-postgresql download-openldap

# Lancement les services les plus communément utilisés par sitle
sitle: start-elasticsearch start-minio start-rabbitmq start-mongodb
		@echo "Elasticsearch (server) : http://localhost:9200"
		@echo "Kibana (management) : http://localhost:5601"
		@echo "Minio (management) : http://localhost:9001 (admin/password)"
		@echo "Rabbitmq (management): http://localhost:15672 (admin/password)"
		@echo "Rabbitmq (server): amqp://admin:password@localhost:5672/"
		@echo "Mongodb (server): mongodb://dev:password@localhost:27017/dev"
		
# Lancement des services les plus communément utilisés au SIPF
sipf: start-postgresql start-minio
		@echo "http://localhost:9001 (admin/password)"
		@echo "postgresql://user:password@localhost:5432/dev"

## ELASTICSEARCH
start-elasticsearch:
		@docker compose -f elasticsearch/docker-compose.yml up -d

download-elasticsearch:
		@docker pull ${ELASTICSEARCH_IMAGE}
		@docker pull ${KIBANA_IMAGE}

elasticsearch: download-elasticsearch start-elasticsearch

## MINIO
start-minio:
		@docker compose -f minio/docker-compose.yml up -d

download-minio:
		@docker pull ${MINIO_IMAGE}
		@docker pull ${NGINX_IMAGE}

minio: download-minio start-minio

## RABBITMQ
start-rabbitmq:
		@docker compose -f rabbitmq/docker-compose.yml up -d

download-rabbitmq:
		@docker pull ${RABBITMQ_IMAGE}

rabbitmq: download-rabbitmq start-rabbitmq

## MONGODB
start-mongodb:
		@docker compose -f mongodb/docker-compose.yml up -d

download-mongodb:
		@docker pull ${MONGODB_IMAGE}

mongodb: download-mongodb start-mongodb

## MYSQL
start-mysql:
		@docker compose -f mysql/docker-compose.yml up -d

download-mysql:
		@docker pull ${MYSQL_IMAGE}

mysql: download-mysql start-mysql

## POSTGRESQL
start-postgresql:
		@docker compose -f postgresql/docker-compose.yml up -d

download-postgresql:
		@docker pull ${POSTGRESQL_IMAGE}
		@docker pull ${PGWEB_IMAGE}

postgresql: download-postgresql start-postgresql

## REDIS
start-redis:
		@docker compose -f redis/docker-compose.yml up -d

download-redis:
		@docker pull ${REDIS_IMAGE}

redis: download-redis start-redis

## OPENLDAP
start-openldap:
		@docker compose -f openldap/docker-compose.yml up -d

download-openldap:
		@docker pull ${OPENLDAP_IMAGE}

openldap: download-openldap start-openldap

# Arrête tout les services d'infrastructure
stop:
		@docker compose -f elasticsearch/docker-compose.yml down
		@docker compose -f minio/docker-compose.yml down
		@docker compose -f rabbitmq/docker-compose.yml down
		@docker compose -f mongodb/docker-compose.yml down
		@docker compose -f mysql/docker-compose.yml down
		@docker compose -f postgresql/docker-compose.yml down
		@docker compose -f redis/docker-compose.yml down
		@docker compose -f openldap/docker-compose.yml down

# Fais le grand ménage
clean: stop
		@echo "ATTENTION: CECI SUPPRIME TOUT LES VOLUMES NON UTILISES PAR AU MOINS UN CONTENEUR"
		@docker volume prune

# Test
test: download elasticsearch minio rabbitmq mongodb mysql postgresql redis openldap clean
