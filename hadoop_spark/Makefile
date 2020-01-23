current_branch := latest # $(shell git rev-parse --abbrev-ref HEAD)
build:
	docker build -t hadoop-base:$(current_branch) ./base
	docker build -t hadoop-master:$(current_branch) ./master
	docker build -t hadoop-worker:$(current_branch) ./worker
	docker build -t hadoop-edge:$(current_branch) ./edge
