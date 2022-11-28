#!/bin/bash

# create persistent volume claim
kubectl create -f claim.yaml
 
# create pod to upload/download data to/from the cluster
kubectl create -f busy.yaml
 
# upload inputs
kubectl cp P04156.fasta busybox:/data
kubectl cp zebrafish.1.protein.faa busybox:/data
 
# run BLAST example
kubectl create -f makedb.yaml
kubectl create -f blast.yaml
 
# download outputs
kubectl cp busybox:/data/results.txt results.txt
 
# clear pods
kubectl delete pod busybox makedb blast
