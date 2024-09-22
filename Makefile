init:
	@echo ">>>>> Iniciando Docker"
	@docker-compose up -d

install:
	@echo ">>>>> Copy Env example"
	@cp .env.example .env
	@echo ">>>>> Iniciando Docker"
	@docker-compose up -d db app
	@echo ">>>>> Composer install"
	@docker-compose exec app composer install
	@echo ">>>>> Generate key"
	@docker-compose exec app php artisan key:generate
	@echo ">>>>> Migrate and seed"
	@docker-compose exec app php artisan migrate
	@docker-compose exec app php artisan db:seed
	@echo ">>>>> Iniciando Worker"
	@docker-compose up -d worker
	@echo "Installed project"
	@echo "Access http://localhost:8080"
