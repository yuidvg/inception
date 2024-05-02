DOMAIN_NAME = ynishimu.42.fr

all:
	mkdir -p /home/ynishimu/data/wp_db
	mkdir -p /home/ynishimu/data/wp_files
	echo "127.0.0.1 ${DOMAIN_NAME}" >> /etc/hosts
	docker compose 	-f srcs/docker-compose.yml up --build

clean:
	docker compose -f srcs/docker-compose.yml down

fclean: clean
	docker compose -f srcs/docker-compose.yml down --volumes

re: fclean all

.PHONY: all clean fclean re

