FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    biber                       \
    latexmk                     \
    make                        \
    texlive                     \
    texlive-base                \
    texlive-bibtex-extra        \
    texlive-binaries            \
    texlive-lang-cyrillic       \
    texlive-latex-extra         \
    texlive-latex-recommended   \
    texlive-plain-generic

WORKDIR /data

COPY Makefile Makefile
COPY db.tex db.tex
COPY preamble.tex preamble.tex
COPY bibliography.bib bibliography.bib
ADD part ./part
ADD assets ./assets

CMD make build
