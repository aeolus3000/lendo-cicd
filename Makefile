start:
	@echo "--> Create and start containers"
	mkdir -p pgdata
	mkdir -p pgadmin
	mkdir -p ./pgadmin/lib
	touch ./pgadmin/servers.json
	mkdir -p rabbitmq
	rm -rf ./lendo-service
	rm -rf ./lendo-polling-service
	git clone https://github.com/aeolus3000/lendo-polling-service.git
	git clone https://github.com/aeolus3000/lendo-service	
	cd lendo-polling-service && GOOS=linux GOARCH=386 go build -o ./lendo-polling-service ./main.go
	docker-compose up -d
	rm -rf ./lendo-polling-service/lendo-polling-service
	@echo "Waiting for the services"
	sleep 45s
	@echo "Done"

stop:
	@echo "--> Stop containers"
	docker-compose down
	@echo ""
