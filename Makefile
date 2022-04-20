NAME = inception

all: $(NAME)

$(NAME): create build

create:
	docker-machine create --driver=virtualbox default
	eval "$(docker-machine env default)"

add:
	@sudo chmod 644 /etc/hosts
	@sudo echo "$(shell docker-machine ip)cdrennan.21.ru" >> /etc/hosts
	@echo "$(shell docker-machine ip) cdrennan.21.ru - added to /etc/hosts"

remove:
	@sudo head -n -1 /etc/hosts > temp.txt ; sudo mv temp.txt /etc/hosts
	@echo "Last host removed from /etc/hosts"

delete: prune remove
	docker-machine rm -f default

build:
	docker-compose -f srcs/docker-compose.yml up --build

stop:
	docker-compose -f srcs/docker-compose.yml down

prune: stop
	docker system prune -f --all


re: delete all

.PHONY: create add remove delete build stop prune