# Terrier OSIRRC Docker Image

[![Build Status](https://travis-ci.com/osirrc/terrier-docker.svg?branch=master)](https://travis-ci.com/osirrc/terrier-docker)
[![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/osirrc2019/terrier.svg)](https://hub.docker.com/r/osirrc2019/terrier)
[![DOI](https://zenodo.org/badge/177832180.svg)](https://zenodo.org/badge/latestdoi/177832180)


[**Arthur Câmara**](https://github.com/ArthurCamara) and [**Craig Macdonald**](https://github.com/cmacdonald)

This is dthe docker image for the [Terrier](http://terrier.org/) toolikt (v5.2) conforming to the [OSIRRC jig](https://github.com/osirrc/jig/) for the [Open-Source IR Replicability Challenge (OSIRRC) at SIGIR 2019](https://osirrc.github.io/osirrc2019/).
This image is available on [Docker Hub](https://hub.docker.com/r/osirrc2019/terrier)

+ Supported test collections: `robust04`, `gov2`, `cw09b`, `cw12b` (web), `core18` (WAPO)
+ Supported hooks: `init`, `index`, `train`, `search`

## Quick Start

The following `jig` command can be used to index TREC disks 4/5 for `robust04`:

```
python run.py prepare --repo terrier --collections robust04=/tmp/disk45/=trectext
```
*Note*: You should remove any README files that come with the corpus, as they include example documents that cause duplicates.

The following `jig` command can be usef to perform a retrieval run on the collection with the `robust04` test collection, using BM25 as ranker:

```
python run.py search  \
	--repo osirrc2019/terrier\ 
	--collection robust04 \
	--topic topics/topics.robust04.txt \
	--qrels qrels/qrels.robust04.txt\ 
	--output /tmp/runs 
```


## Retrieval Methods:

(BM25)

	python run.py search  --repo terrier --collection robust04  --topic topics/topics.robust04.txt --qrels qrels/qrels.robust04.txt   --output /tmp/runs 

(BM25 + query expansion)

	python run.py search  --repo terrier --collection robust04  --topic topics/topics.robust04.txt --qrels qrels/qrels.robust04.txt   --output /tmp/runs --opts config=bm25_qe

(PL2)

	python run.py search  --repo terrier --collection robust04  --topic topics/topics.robust04.txt --qrels qrels/qrels.robust04.txt   --output /tmp/runs --opts config=pl2

(PL2 + query expansion)

	python run.py search  --repo terrier --collection robust04  --topic topics/topics.robust04.txt --qrels qrels/qrels.robust04.txt   --output /tmp/runs --opts config=pl2_qe

## Learning to Rank Runs

Learning-to-rank will typically require that the index has more information, e.g. fields or blocks.

### Indexing:

	python run.py prepare     --repo terrier   --collections robust04=/tmp/disk45/=trectext --opts "FieldTags.process=HEADLINE"

### Training:

You need to specify the features to be used by Terrier - see http://terrier.org/docs/v5.1/learning.html for more information about Terrier feature definitions.

	python run.py train  --repo terrier --collection robust04  --topic topics/topics.robust04.txt --qrels qrels/qrels.robust04.txt    --test_split $PWD/sample_training_validation_query_ids/robust04_test.txt  --validation_split $PWD/sample_training_validation_query_ids/robust04_validation.txt --model_folder /tmp/runs --opts features="SAMPLE;WMODEL:SingleFieldModel(BM25,0);QI:SingleFieldModel(Dl,0)"

### Retrieval:

You will need to specify the `bm25_ltr_jforest` configuration.

	python run.py search  --repo terrier --collection robust04  --topic topics/topics.robust04.txt --qrels qrels/qrels.robust04.txt   --output /tmp/runs --opts config=bm25_ltr_jforest
	
## Expected Results

### robust04
MAP                                     | BM25      | +QE  | PL2   | +QE   
:---------------------------------------|-----------|-----------|-----------|-----------|
[TREC 2004 Robust Track Topics](http://trec.nist.gov/data/robust/04.testset.gz)| 0.2363    | 0.2762    | 0.2241    | 0.2538

### core18

MAP                                     | BM25      | +QE  | PL2   | +QE   
:---------------------------------------|-----------|-----------|-----------|-----------|
[TREC 2018 Common Core Track Topics](https://trec.nist.gov/data/core/topics2018.txt)| 0.2326    | 0.2975    | 0.2225    | 0.2728


