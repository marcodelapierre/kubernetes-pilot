#!/bin/bash

# create temporary pod (shell 1)
nextflow kuberun login -v nxf-vol-claim:/data

# upload input files (shell 2)
podname=<NAME ASSIGNED IN STEP ABOVE>
 
kubectl cp small.fastq $podname:/data/
for f in tinydb.fasta* ; do
  kubectl cp $f $podname:/data/
done





# execute pipeline (shell 1)
# see also snippet_nextflow.config
nextflow run marcodelapierre/nanopore-nf \
  -profile k8s \
  --basecalled='/data/small.fastq' \
  --seqid='X55033.1,NC_037830.1,MG882489.1' \
  --blast_db="/data/tinydb.fasta" \
  --min_len_contig='0'




# download output files (shell 2)
kubectl cp $podname:/data/results_small.fastq ./results_small.fastq

# exit (shell 1)
exit
