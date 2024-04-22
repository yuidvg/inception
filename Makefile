ENV_FILE = srcs/.env
DOMAIN_NAME = ynishimu.42.fr

all:
	echo "127.0.0.1 ${DOMAIN_NAME}" >> /etc/hosts
	docker compose --env-file ${ENV_FILE} -f srcs/compose.yaml up --build

clean:
	docker compose --env-file ${ENV_FILE} -f srcs/compose.yaml down --volumes

fclean: clean
	docker volume rm wp_db
	docker volume rm wp_files

re: fclean all

.PHONY: all clean fclean re
