## Nextflow pilot

### Assumed platform

* A deployed Kubernetes cluster  
  * During the training I've tested:  
    * Local Microk8s  
    * LXD Charmed Kubernetes on Nimbus  
* A Kubernetes "persistent volume claim", named **nxf-vol-claim** in this example  
  * Find YAML example below, under "Setup - Persistent Volume Claim"  


### Resources

* Nextflow doc page on Kubernetes: https://www.nextflow.io/docs/latest/kubernetes.html  
* Nextflow Github issues on Kubernetes resource management:  
  * https://github.com/nextflow-io/nextflow/issues/773  
  * https://github.com/nextflow-io/nextflow/issues/785  


### Setup

#### Nextflow

Just a note here, in my tests specific Java versions were required:
* Java <= 8 work
* Java >= 12 work
* Java 9-11 DO NOT work

#### Kubernetes

Nextflow assumes there's a config file for the Kubernetes cluster available at **~/.kube/config**.  
Here's how I prepared it during the training:
```bash
microk8s.config >kubeconfig
sudo mkdir -p ~/.kube
sudo mv kubeconfig ~/.kube/config
sudo chmod go+X ~/.kube
sudo chmod go+r ~/.kube/config
```


### Persistent Volume Claim

1. `microk8s`
    ```bash
    # create PVC
    kubectl create -f pvc_microk8s.yaml
    ```

2. `charmed`
    ```bash
    # create storage class
    kubectl apply -f storage-class_charmed.yaml
    # create PVC
    kubectl create -f pvc_charmed.yaml
    ```
    Note: Storage Class YAML taken from https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml.


