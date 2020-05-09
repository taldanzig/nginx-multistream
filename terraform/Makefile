include common_vars

REMOTE=$(AWS_ACCOUNT_ID).dkr.ecr.$(AWS_REGION).amazonaws.com

create-ecs-service-linked-role:
	aws --profile $(AWS_PROFILE) iam create-service-linked-role --aws-service-name ecs.amazonaws.com

docker-login:
	aws ecr get-login-password | docker login --username AWS --password-stdin https://$(REMOTE)

docker-build:
	cd ../container && $(MAKE) docker-build

docker-push:
	set -uxe ;\
	docker tag nginx-multistream:latest $(REMOTE)/multiplexer:latest ;\
	docker push $(REMOTE)/multiplexer:latest
