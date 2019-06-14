#!/bin/bash

# The Docker repo
REPO="terrier"
TAG="latest"

# Collection details
COLLECTION_NAME="core18"
COLLECTION_PATH="/local/terrier/Collections/TREC/WAPO/WashingtonPost.v2/data/"
COLLECTION_FORMAT="trectext"

TOPIC="topics/topics.core18.txt"
QRELS="qrels/qrels.core18.txt"

mkdir -p output/terrier/$COLLECTION_NAME

python run.py prepare --repo $REPO --tag $TAG --collections $COLLECTION_NAME=$COLLECTION_PATH=$COLLECTION_FORMAT

python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/terrier/$COLLECTION_NAME --opts config=bm25
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/terrier/$COLLECTION_NAME --opts config=bm25_qe
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/terrier/$COLLECTION_NAME --opts config=pl2
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/terrier/$COLLECTION_NAME --opts config=pl2_qe

python run.py prepare --repo $REPO --tag $TAG --collections $COLLECTION_NAME=$COLLECTION_PATH=$COLLECTION_FORMAT --opts block.indexing=true
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/terrier/$COLLECTION_NAME --opts config=DFRD
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/terrier/$COLLECTION_NAME --opts config=DFRD_qe
