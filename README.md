# CDW K8's demo lab 

### Welcome to the new and improved K8's/Ansible/PSO/PSO Explorer demo lab.

### In this Current version I have replace all the inner workings of the previous lab.
### I have moved to a vagrant deployment model using virtual box running on Ubuntu 20.04
### to enable the deployment of a Master and 3 worker node K8's cluster
### that also has access to the Pure CSI driver (PSO) to enable persistant storage (PVC)  as well as the Pure PSO explorer web app which gives the user a much easier way to understand all the storage/pods they have running in the wild.

### for those interested in the inner workings of Vagrant. I have listed below what the Vagrantfile actually does :

### The vagrant file will do the following:
### 1.  Provision all local VMs using VirtualBox
### 2.  Patch the OS
### 3.  Install Docker
### 4.  Install k8s control plane
### 5.  Initialize cluster with Flannel CIDR block & install Flannel
### 6.  Join the nodes to the master
### 7.  Create and copy the SSH key to all machines so you can SSH to any node from the Master.  Add names & IPs to the local hosts file on each master and node.  Create alias in vagrant home for kubectl...just use k
### 8.  Make required Ubuntu OS mods for the cluster to function properly using an install.sh script

### Since this lab is designed to be portable, it can be run on an Ubuntu 20.04 installation (including ones that are running under a local Hypervisor (Fusion/Workstation/VBirtualbox, etc))
### I have listed the steps below that need to be preinstalled before you can download this repo and run it locally

Remember that while it will run anywhere, it will not have access to any Persistant Storage containers without access to a Pure array   

When you want to use this demo find the Vhd1purevm1 machine in the pure folder in VCenter
Right click on the machine and choose manage snapshots

From the snap shot menu, you can from three states
BASE Ubuntu image  - you follow all the steps below  starting at 43 - longest setup
cdw_lab demo ready  - you can skip to line 51 - long setup
cluster running - skip to line 78 - short setup



## Dependencies

You should install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [Vagrant](https://www.vagrantup.com/downloads.html) before you start.

Open a shell and install the vagrant disksize plugin:
```bash
$ vagrant plugin install vagrant-disksize
```

## Make sure git is installed

Install [git](https://git-scm.com/downloads) if you don't already have it.

## Open a shell and clone

```bash
$ git clone https://github.com/brucmod/cdw
$ cd cdw
```
## There are several tools that your Ubuntu Machine should have running##
## you can download run the install_K8.sh script from this repo or create your own script from its contents##
```bash
$ ./install.sh
```

## once thats completed you should be able move on ##

## Starting the cluster

You can create the cluster with:

```bash
$ vagrant up
```

## Clean up

You can delete the cluster with:

```bash
$ vagrant destroy -f
```

## SSH and other Commands

SSH to Master and other Nodes:

```bash
$ vagrant ssh master
```

Get the status of the Nodes:

```bash
$ k get nodes -o wide
NAME     STATUS   ROLES    AGE     VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION      CONTAINER-RUNTIME
master   Ready    master   16m     v1.17.4   10.0.0.10     <none>        Ubuntu 18.04.4 LTS   4.15.0-88-generic   docker://19.3.6
node1    Ready    <none>   11m     v1.17.4   10.0.0.11     <none>        Ubuntu 18.04.4 LTS   4.15.0-88-generic   docker://19.3.6
node2    Ready    <none>   6m31s   v1.17.4   10.0.0.12     <none>        Ubuntu 18.04.4 LTS   4.15.0-88-generic   docker://19.3.6
node3    Ready    <none>   102s    v1.17.4   10.0.0.13     <none>        Ubuntu 18.04.4 LTS   4.15.0-88-generic   docker://19.3.6
```

SSH to other Nodes in the cluster from the Master:

```bash
$ ssh node1
$ ssh node2
$ ssh node3
```
### once all the nodes are up and running, from within the master node, you will now download another git repo to clone the yaml demo files/ansible demo files/PSO and PSO explorer files ###
```bash
git clone https://github.com/cdw_post
cd cdw_post
./master.sh
```

### once the master sctipt has finished running you should be redy to roll ###



###### PSO & EXPLORER Demos

```
kubectl get svc --namespace psoexpl -w pso-explorer
```

### Jot down the 5 digit port forwrding number ###
### From the web browser running on the top level Ubuntu node go to 10.0.0.1:5 digit port number ###
### this will bring up the PSO Explore web gui ###

### The demo scripts are located in the kubernetes directory. They are designed to be run in order as there may be dependencies.###

### as you run them in order, they will create a 14gb PVC on the local Pure FA, then start up a container/pod running minio and start the pod service ###

### You can now log in to minio using the service port. Find the port with ###
 ```
 kubectl get svc
 ``` 

 
 ### (should always be 9000). Joint down the 5 digit port forwarding number  and then from the same web browser as before  http://10.0.0.10: 5 digit number.  you should then see the minio S3 NAS gui and you could log in with these credentials .Username/password: minio:minio123 ###