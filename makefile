# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rihoy <rihoy@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/01/01 22:17:41 by rihoy             #+#    #+#              #
#    Updated: 2025/01/05 20:41:14 by rihoy            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all :	make_directory
		sudo docker compose --file ./srcs/docker-compose.yml up --detach

down :
		sudo docker compose --file ./srcs/docker-compose.yml down

fclean :clean_directory
		sudo docker compose --file ./srcs/docker-compose.yml down
		sudo docker system prune -a --force

re : fclean all

make_directory :
	mkdir -p /home/rihoy/data/mariadb
	mkdir -p /home/rihoy/data/wordpress
	

clean_directory :
	sudo rm -fr /home/rihoy/data/*
	