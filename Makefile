DOMAIN_NAME = ynishimu.42.fr

all:
	echo "127.0.0.1 ${DOMAIN_NAME}" >> /etc/hosts
	docker compose 	-f srcs/compose.yaml up --build

clean:
	docker compose -f srcs/compose.yaml down

fclean: clean
	docker compose -f srcs/compose.yaml down --volumes

re: fclean all

.PHONY: all clean fclean re
