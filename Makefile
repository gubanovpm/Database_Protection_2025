PWD := $(shell pwd)

all: build run

build:
	latexmk -pdf db.tex
run:
	evince db.pdf &

clean:
	rm -f *.aux *.fdb_latexmk *.fls *.log *.out *.synctex.gz *.toc *.bbl *bcf *.blg *.xml *.snm *.nav

docker_clean:
	docker rmi latex_img

docker_build:
	docker build -f Dockerfile -t latex_img .

docker: docker_build
	docker run --volume $(PWD):/data --rm --name latex_doc latex_img

docker_test: docker_build
	docker run --volume $(PWD):/data --rm --interactive --name latex_doc latex_img /bin/bash
