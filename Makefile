all: build push
build:
	docker build --no-cache=true -t stud .
	docker tag -f stud docker.sunet.se/stud
update:
	docker build -t stud .
	docker tag -f stud docker.sunet.se/stud
push:
	docker push docker.sunet.se/stud
