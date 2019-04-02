FROM openjdk:8-alpine

COPY init init
COPY index index
COPY search search
RUN ["chmod", "+x", "/index"] 
RUN ["chmod", "+x", "/init"] 

#install bash and cURL
RUN apk add --update bash && rm -rf /var/cache/apk/*
RUN apk add curl

WORKDIR /work
