PWD := $(shell pwd)
tex_files := $(shell find -type f -name '*.tex' -or -name '*.bib')

all: build run clean

db.pdf: $(tex_files)
	latexmk -pdf db.tex

build: db.pdf

run: build
	evince db.pdf &

clean:
	rm -f *.aux *.fdb_latexmk *.fls *.log *.out *.synctex.gz *.toc *.bbl *bcf *.blg *.xml *.snm *.nav

docker_clean:
	docker rmi latex_img

docker_build:
	docker build -f Dockerfile -t latex_img .

docker: docker_build
	docker run --volume $(PWD):/data --rm --name latex_doc latex_img
