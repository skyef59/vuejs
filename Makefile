# DOCKER TASKS
# Build the container
run: ## Build the container
	docker run -it -p 8080:8080 --rm --name dockerize-vuejs-app-1 vue-project-my-app 