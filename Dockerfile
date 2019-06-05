FROM openjdk:8-alpine

RUN apk add python3
RUN apk add git
RUN apk add maven
RUN ["pip3", "install", "requests"]

#Terrier assumes bash rather than sh
RUN apk add bash

#jtreceval needs gcompat libraries for treceval
RUN apk add gcompat

COPY init init
COPY index index
COPY search search
RUN ["chmod", "+x", "/index"]
RUN ["chmod", "+x", "/init"]
RUN ["chmod", "+x", "/search"]

WORKDIR /work
