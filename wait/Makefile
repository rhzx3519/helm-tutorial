dockerRepoName := rhzx3519/wait

all: build push

push: build
	docker push ${dockerRepoName}

build:
	docker build -t ${dockerRepoName} .

