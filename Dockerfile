FROM openjdk:8-alpine

COPY init init
COPY index index
COPY search search
RUN ["chmod", "+x", "/index"] 
RUN ["chmod", "+x", "/init"] 
RUN ["chmod", "+x", "/search"] 

#install bash, cURL and Python
RUN apk add --update bash && rm -rf /var/cache/apk/*
RUN apk add curl
RUN apk add python3

WORKDIR /work
