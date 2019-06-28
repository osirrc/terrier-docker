FROM openjdk:8-alpine

RUN apk add python3
RUN apk add git
RUN apk add maven
RUN ["pip3", "install", "requests"]

#needed for psutil
RUN apk add musl-dev
RUN apk add linux-headers
RUN apk add gcc
RUN apk add python3-dev
RUN ["pip3", "install", "psutil"]

#Terrier assumes bash rather than sh
RUN apk add bash

#jtreceval needs gcompat libraries for treceval
RUN apk add gcompat

COPY init init
COPY index index
COPY search search
COPY train train
RUN ["chmod", "+x", "/index" , "/init", "/search", "/train"]

RUN apk add libzmq
RUN apk add g++
RUN apk add build-base

RUN wget http://www.mirrorservice.org/sites/ftp.apache.org/spark/spark-2.4.3/spark-2.4.3-bin-hadoop2.7.tgz
RUN tar -xvf spark-2.4.3-bin-hadoop2.7.tgz
RUN rm spark-2.4.3-bin-hadoop2.7.tgz

RUN pip3 install --upgrade toree
RUN pip3 install notebook

RUN jupyter toree install --spark_home=/spark-2.4.3-bin-hadoop2.7/

RUN git clone https://github.com/terrier-org/terrier-spark.git
RUN cd terrier-spark && mvn -DskipTests install
RUN rm -rf /terrier-spark

RUN mkdir /notebooks
EXPOSE 1980/tcp
EXPOSE 1981/tcp
EXPOSE 1982/tcp
COPY simpleRun.ipynb /notebooks/simpleRun.ipynb
COPY interact interact
RUN chmod +x interact
WORKDIR /work
