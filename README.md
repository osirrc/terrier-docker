# Terrier Jig

This Docker sets up Terrier 5.2.


## Basic Runs

### Indexing:

	python run.py prepare     --repo terrier   --collections robust04=/tmp/disk45/=trectext

''Note'': You should remove any README files that come with the corpus, as they include example documents that cause duplicates.

### Retrieval:

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

# Supported Configurations

For indexing, the corpus name defines the indexing configuration. The following values are supported:
 - `robust04` - TREC Disks 4&5. You should remove the READMEs from the corpus directories. The configuration uses an external library to support z compressed files.
 - `gov2` - the TREC GOV2 corpus. Could also be used for GOV, WT2G, WT10G.
 - `cw09b` - the TREC ClueWeb09 corpus.
 - `cw12b` - the TREC ClueWeb12 corpus.
 - `core18` - the TREC Washington Post (WAPO) corpus. The configuration uses an extra Terrier plugin to support the WAPO format.

# Credits

 - Arthur Barbosa Câmara, University of Delft
 - Craig Macdonald, University of Glasgow
