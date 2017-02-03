all: build start

build: build-wordpress

build-php:
	docker build -t docker-php -f Docker/php/Dockerfile .

build-wordpress:
	docker build -t docker-wordpress -f Docker/wordpress/Dockerfile .

rsync:
	rsync -e "docker exec -i" --blocking-io -avz --delete --exclude=".git" . docker-wordpress:/var/www/html/wp-content/plugins/

start: stop
	docker run --name wpmysql -e MYSQL_ROOT_PASSWORD=secret -d mysql:latest
	docker run --name docker-wordpress --link wpmysql:mysql -p 8080:80 -d docker-wordpress

stop:
	@docker rm -vf wpmysql docker-wordpress||:

exec:
	docker exec -it docker-wordpress bash

.PHONY: clean run-mysql run-wp start stop rsync build all exec
