###
### init
###

include .env

dockerUser = $(DOCKER_USER)
dockerToken = $(DOCKER_TOKEN)
dockerRepo = $(DOCKER_REPO)
dockerTag = $(DOCKER_TAG)

imageName = $(dockerUser)/$(dockerRepo)

VERSION_REGEX := ^[0-9]+(\.[0-9]+){1,2}$$

.PHONY: help dev release

###
### help
###

help:
	@echo
	@echo "make dev ....... build local dev image"
	@echo "make release ... tag dev image to latest and release version then push" 
	@echo

###
### build
###

dev:
	docker buildx build \
		--no-cache \
		--progress plain \
		--platform linux/amd64,linux/arm64 \
		--file Dockerfile \
		--tag $(imageName):dev \
		.

release: test-tag
	@docker tag $(imageName):dev $(imageName):latest && \
	docker push $(imageName):latest
	@docker tag $(imageName):dev $(imageName):$(dockerTag) && \
	docker push $(imageName):$(dockerTag)

###
### helper
###

test-tag:
	@echo "dockerTag=$(dockerTag)"
	@echo "$(dockerTag)" | grep -Eq '$(VERSION_REGEX)' || \
		( echo "ERROR: dockerTag must be a version number like 0.1, 1.2 or 1.2.3"; exit 1 )
