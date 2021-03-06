#!/bin/bash

# The Docker repo
REPO="terrier"
TAG="latest"

# Collection details
COLLECTION_NAME="robust04"
COLLECTION_PATH=/tmp/disk45_salt
COLLECTION_FORMAT="trectext"

TOPIC="topics/topics.robust04.txt"
QRELS="qrels/qrels.robust04.txt"

mkdir -p output/terrier/$COLLECTION_NAME

python run.py prepare --repo $REPO --tag $TAG --collections $COLLECTION_NAME=$COLLECTION_PATH=$COLLECTION_FORMAT

rm -f output/terrier/$COLLECTION_NAME/*
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/terrier/$COLLECTION_NAME --opts config=bm25
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/terrier/$COLLECTION_NAME --opts config=bm25_qe
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/terrier/$COLLECTION_NAME --opts config=pl2
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/terrier/$COLLECTION_NAME --opts config=pl2_qe
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/terrier/$COLLECTION_NAME --opts config=dph
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/terrier/$COLLECTION_NAME --opts config=dph_qe
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/terrier/$COLLECTION_NAME --opts config=ql
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/terrier/$COLLECTION_NAME --opts config=ql_qe

#re-index for prox
python run.py prepare --repo $REPO --tag $TAG --collections $COLLECTION_NAME=$COLLECTION_PATH=$COLLECTION_FORMAT --opts block.indexing=true
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/terrier/$COLLECTION_NAME --opts config=bm25_prox
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/terrier/$COLLECTION_NAME --opts config=bm25_prox_qe
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/terrier/$COLLECTION_NAME --opts config=dph_prox
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/terrier/$COLLECTION_NAME --opts config=dph_prox_qe
