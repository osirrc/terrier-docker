#!/bin/bash

#useful script to update an existing docker image with revised scripts

savetag=$1

containerid=`docker run -d -t terrier:$savetag /bin/bash`
for file in init search train interact; do
	docker cp $file $containerid:/$file
done
docker commit $containerid terrier:$savetag
docker stop $containerid

