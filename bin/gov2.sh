#!/bin/bash

# The Docker repo
REPO="terrier"
TAG="latest"

# Collection details
COLLECTION_NAME="gov2"
COLLECTION_PATH="/local/terrier/Collections/TREC/DOTGOV2/gov2-corpus/"
COLLECTION_FORMAT="trecweb"

TOPIC="topics/topics.701-750.txt"
QRELS="qrels/qrels.701-750.txt"

mkdir -p output/terrier/$COLLECTION_NAME

python run.py prepare --repo $REPO --tag $TAG --collections $COLLECTION_NAME=$COLLECTION_PATH=$COLLECTION_FORMAT

python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/terrier/$COLLECTION_NAME --opts config=bm25
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/terrier/$COLLECTION_NAME --opts config=bm25_qe
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/terrier/$COLLECTION_NAME --opts config=pl2
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/terrier/$COLLECTION_NAME --opts config=pl2_qe
