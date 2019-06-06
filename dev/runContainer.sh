#!/bin/bash

#useful script to give you a script on the container. any changes would not be persisted when the container ends

savetag=$1
exec docker run -it terrier:$savetag /bin/bash
