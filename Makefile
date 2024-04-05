all:
	docker compose --env-file srcs/.env -f srcs/compose.yaml up --build

clean:
	docker compose --env-file srcs/.env -f srcs/compose.yaml down

fclean: clean
	docker volume rm wp_db
	docker volume rm wp_files

re: fclean all

.PHONY: all clean fclean re
