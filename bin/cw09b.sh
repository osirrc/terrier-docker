#!/bin/bash

# The Docker repo
REPO="terrier"
TAG="latest"

# Collection details
COLLECTION_NAME="cw09b""
COLLECTION_PATH="/local/tr.clueweb09/ClueWeb09_English_1"
COLLECTION_FORMAT="trecweb"

TOPIC="topics/topics.core18.txt"
QRELS="qrels/qrels.web.1-50.txt"

mkdir -p output/terrier/$COLLECTION_NAME

python run.py prepare --repo $REPO --tag $TAG --collections $COLLECTION_NAME=$COLLECTION_PATH=$COLLECTION_FORMAT

python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/terrier/$COLLECTION_NAME --opts config=bm25
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/terrier/$COLLECTION_NAME --opts config=bm25_qe
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/terrier/$COLLECTION_NAME --opts config=pl2
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/terrier/$COLLECTION_NAME --opts condif=pl2_qe

python run.py prepare --repo $REPO --tag $TAG --collections $COLLECTION_NAME=$COLLECTION_PATH=$COLLECTION_FORMAT --opts block.indexing=true
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/terrier/$COLLECTION_NAME --opts condif=DFRD
python run.py search --repo $REPO --tag $TAG --collection $COLLECTION_NAME --topic $TOPIC --qrels $QRELS --output output/terrier/$COLLECTION_NAME --opts condif=DFRD_qe
