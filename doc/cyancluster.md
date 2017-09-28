# Cognitive Compute Deployed in Kubernetes Cluster

This article presents how the **Cyan compute** components are deployed into Kubernetes Cluster. Each broker and web app components have a dockerfile to containerize them.

[Back to cognitive root project](../README.md)

# Value propositions
## Value proposition for container
Just to recall the value of using container for the cognitive application are the following:
* Docker ensures consistent environments from development to production. Docker containers are configured to maintain all configurations and dependencies internally.
* Docker containers allows you to commit changes to your Docker images and version control them. It is very easy to rollback to a previous version of your Docker image. This whole process can be tested in a few minutes.
* Docker is fast, allowing you to quickly make replications and achieve redundancy.
* Isolation: Docker makes sure each container has its own resources that are isolated from other containers
* Removing an app/ container is easy and won’t leave any temporary or configuration files on your host OS.
* Docker ensures that applications that are running on containers are completely segregated and isolated from each other, granting you complete control over traffic flow and management

## Value proposition for Kubernetes
Kubernetes is an open source system for automating the deployment, scaling, and management of containerized apps.
* high availability 24/7
* Deploy new version multiple times a day
* Standard use of container for apps and business services
* Allocates  resources and tools when applications need them to work
* Single-tenant Kubernetes clusters with compute, network and storage infrastructure isolation
* Automatic scaling of apps
* Use the cluster dashboard to quickly see and manage the health of your cluster, worker nodes, and container deployments.
* Automatic re-creation of containers in case of failures

## Value proposition for IBM Cloud Private
The goal is to match the power of public cloud platform with the security and control of your firewall. Based on Kubernetes it offers the same benefits of kubernetes and adds more services and integration with on-premise data sources and services. Most of IBM leading middleware products can run on ICP. ICP helps developers and operations team to optimize legacy application with cloud-enabled middleware, open the data center to work with cloud services using hybrid integration, and create new cloud-native applications using devops tools and polyglot programming languages.



# Container based deployment
We propose two deployment environments:
* [IBM Cloud Private]()
* [IBM Bluemix Container Service]()

The following diagram illustrates those concept in ICP:  
![](cyan-icp.png)  

## IBM Cloud Private

## Bluemix Container Service deployment

### Pre-requisites
You need a set of tools before using Kubernetes cluster on Bluemix: the  run `./install_cli.sh` (for windows use the `install_cli.bat`). This script should install for you bluemix command line interface, bluemix container service plugin, Bluemix Container Registry Service, Kubernetes CLI (kubectl), Helm CLI (helm) and yaml.


## Cluster Configuration

There are multiple models for Kubernetes cluster, for demonstration purpose the lite model is used, but for production the paid model is mandatory as it brings a lot of useful features for high availability, hostname, load balancing...

Clusters are specific to an account and an organization, but are independent from a Bluemix space.
Using Bluemix service and CLI we can create cluster. The following steps were done to create environment:
* bx cs cluster-create --name cyancomputecluster
* bx cs workers cyancomputecluster


Nodes or Worker nodes are virtual or physical servers, managed by the Kubernetes master, and hosting containerized applications. An app in production runs replicas of the app across multiple worker nodes to provide higher availability. A node has a public IP address.
Every containerized app is deployed, run, and managed by a pod.


### Some useful commands

```
$ bx login -a api.ng.bluemix.net
# Review the locations that are available.
$ bx cs locations
# Choose a location and review the machine type
$ bx cs machine-types dal10
# Assess if a public and private VLAN already exists in the Bluemix Infrastructure  NEED a paid account
$ bx cs vlans dal10
# When the provisioning of your cluster is completed, the status of your cluster changes to deployed
$ bx cs clusters
# Check the status of the worker nodes
$ bx cs workers cyancomputecluster
```

When a container is deployed the following kubeclt commands are used:
```
$ kubectl get pods

$ kubectl describe pods

$ export POD_NAME=$(kubectl get pods -o go-template='{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}’)

$ kubectl exec $POD_NAME env

$ kubectl logs $POD_NAME

# run an alpine shell connected to the container
$ kubectl exec -ti $POD_NAME /bin/ash
> ls

$ kubectl get services

$ export NODE_PORT=$(kubectl get services/casewdsbroker -o go-template='{{(index .spec.ports 0).nodePort}}')

$ kubectl describe deployment
```


## Kubernetes Compendium
* [Official site](https://kubernetes.io)
* [Very good tutorial from kubernetes web site](https://kubernetes.io/docs/tutorials/kubernetes-basics/scale-intro/)
* [Garage method tutorial on Kubernetes](https://cloudcontent.mybluemix.net/devops/method/tutorials/kubernetes)

## IBM Cloud Private Compendium
* [IBM technical community](https://www.ibm.com/developerworks/community/wikis/home?lang=en#!/wiki/W1559b1be149d_43b0_881e_9783f38faaff)
* [ICP blog](https://www.ibm.com/developerworks/community/blogs/fe25b4ef-ea6a-4d86-a629-6f87ccf4649e?lang=en)
* [Common configuration for developer](https://github.com/ibm-cloud-architecture/refarch-integration/blob/master/docs/icp/icp-deploy.md#common-installation-tasks)
