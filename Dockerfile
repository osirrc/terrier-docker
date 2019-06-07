FROM openjdk:8-alpine

RUN apk add python3
RUN apk add git
RUN apk add maven

#needed for psutil
RUN apk add musl-dev
RUN apk add linux-headers
RUN apk add gcc
RUN apk add python3-dev

#Terrier assumes bash rather than sh
RUN apk add bash

#jtreceval needs gcompat libraries for treceval
RUN apk add gcompat

COPY init init
COPY index index
COPY search search
COPY train train
RUN ["chmod", "+x", "/index" , "/init", "/search", "/train"]

RUN ["pip3", "install", "psutil"]

WORKDIR /work
