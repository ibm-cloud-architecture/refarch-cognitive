# Install a development environment with IBM Cloud Private 2.1
This is a quick summary of what you may do to install a ICP 2.1 CE development host on a single VM with Ubuntu 64 bits 16.10.

The developer environment may look like the following diagram, for a developer on Mac and a VM ubuntu image (Windows will look similar)
![](dev-env.png)

A developer needs to have on his host the following components:
* [docker](https://github.com/ibm-cloud-architecture/refarch-cognitive/blob/master/doc/install-dev-icp21.md#install-docker)
* [kubectl](https://github.com/ibm-cloud-architecture/refarch-cognitive/blob/master/doc/install-dev-icp21.md#install-kubectl)
* [Helm](https://github.com/ibm-cloud-architecture/refarch-cognitive/blob/master/doc/install-dev-icp21.md#install-helm))
* VM player (or can use vagrant) to install and run ubuntu machine

If you need to assess the dockerhub IBM public image use [docker hub explorer](https://hub.docker.com/explore/)

# Preparing your laptop
## Install docker
If you do not have docker install on your development machine, we will not describe it again ;-). See [docker download](https://docs.docker.com/engine/installation/). You need it on the build server where you have Jenkins or other CI tool.

## Install Kubectl
You need to have kubectl on your development computer, on build server and on the ICP development server.
* Install kubectl from ibm image.

```
docker run -e LICENSE=accept --net=host -v /usr/local/bin:/data ibmcom/kubernetes:v1.7.3 cp /kubectl /data
```
the --net=host means to use the host network stack and not the one coming from the container.  -v is for mounting volume: the local /usr/local/bin is mounted to the /data in the container, so the command to cp /kubectl directory inside the container, to /data inside the container will in fact modify the host /usr/local/bin with kubectl CLI. (complex for a simple tar -xvf... but this is our new life...)

see [Docker volume notes](https://docs.docker.com/engine/admin/volumes/volumes/)

* Access the ICP kubernetes cluster information from the ICP Console.
From the Client configuration menu under your userid on the top right of the main console panel:

![](kube-cli-settings.png)

Copy and paste in a script or in a terminal to execute those commands. So now a command like:
```
kubectl cluster-info
```  
returns the cluster information within ICP.

## Install helm
You can install helm from the helm web site or using Helm packaged with ICP:
```
 docker run -t --entrypoint=/bin/cp -v /usr/local/bin:/data ibmcom/helm:v2.5.0  /helm /data/
```
Command very similar to the one to install kubectl. *--endpoint=* specifies the command to execute when the container starts. Same as *CMD*

Init the client side for helm
```
helm init --client-only
```

If you get the kubectl connected to ICP cluster (as presented in previous figure), then the following command should give you the version of the **Tiller** server running in ICP.
```
$ helm version
```
If you have configured kubeclt to connect to the ICP master server, the above command should return a client and server version.
```
Client: &version.Version{SemVer:"v2.5.0", GitCommit:"012cb0ac1a1b2f888144ef5a67b8dab6c2d45be6", GitTreeState:"clean"}
Server: &version.Version{SemVer:"v2.5.0", GitCommit:"012cb0ac1a1b2f888144ef5a67b8dab6c2d45be6", GitTreeState:"clean"}

```

For a full tutorial on how to install ICP with 5 hosts see [this note](https://github.com/ibm-cloud-architecture/refarch-privatecloud/blob/master/Installing_ICP_on_prem.md)

See [ICP 2.1 product documentation](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0/installing/install_containers_CE.html) to get other details.

## Ubuntu Specifics:
* The expected minimum resource are: CPUs: 1 Memory: 16GB Disk: 60GB (Thin Provisioned)
* Install ubuntu following the step by step wizard, create a user with admin privilege
The ICP installation need root access and ssh connection to the different host nodes that are part of the topology. In the case of one VM you still need to do some security settings and make the system be passwordless with security key.

* Login as the newly create user
* Change root user password
```
$ sudo su -
$ passwd
```
* Update the ubuntu OS with last references
```
apt-get update
```

* Install open ssh, and authorize remote access
```
sudo apt-get install openssh-server
systemctl restart ssh
```

* Create ssh keys for your user and authorize ssh
```
# create rsa keys with no passphrase
$ ssh-keygen -b 4096 -t rsa -P ''
```
be sure the following parameters are enabled
```
$ vi  /etc/ssh/sshd_config
PermitRootLogin yes
PubkeyAuthentication yes
PasswordAuthentication yes
```
The restart ssh daemon:
```
$ systemctl restart ssh
```
Copy the public key to the root.
```
$ ssh-copy-id -i .ssh/id_rsa root@ubuntu
```
Then you should be able to ssh root user to the guest machine.
* Install NTP to keep time sync
```
apt-get install -y ntp
sytemctl restart ntp
# test it
ntpq -p
```
* Install Linux image extra packages
```
apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual
```
* Install python
  ```
  $  apt-get install -y python-setuptools
  $ easy_install pip
  $ pip install docker-py
  ```
* Disable firewall if enabled
  ```
  $ ufw status
  $ sudo ufw disable
  ```
## Install docker on the ubuntu machine
If you do not have it on the linux machine
* Install docker repository
  ```
   $ apt-get install -y apt-transport-https ca-certificates curl software-properties-common
  ```

  * Get the GPG key
   ```
   $ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - apt-key fingerprint 0EBFCD88
   ```
  * Setup docker stable repository
  ```
  $ add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb\_release -cs) stable”
  $ apt-get update
  $ apt-get install -y docker-ce
  ```

* Validate it runs
 ```
   docker run hello-world
 ```
* Add user to docker group
  ```
   # Verify docker group is defined
   $ cat /etc/group
   # add user
   $ usermod -G docker -a usermod
   # re-login the user to get the group assignment at the session level
   ```

* Boot and log as root user

## IBM Cloud Private CE on the ubuntu machine
* Get the ICP  installer docker image using the following command
 ```
 $ sudo su -
 $ docker pull ibmcom/icp-inception:2.1.0-beta-2
 > Digest: sha256:f6513...
Status: Downloaded newer image for ibmcom/icp-inception:2.1.0-beta-2
 $
 $ mkdir /opt/ibm-cloud-private-ce-2.1.0
 $ cd /opt/ibm-cloud-private-ce-2.1.0
 ```
 The following command extracts configuration file under the *cluster* folder by mounting local folder to /data inside the container:
 ```
 $ docker run -e LICENSE=accept \
  -v "$(pwd)":/data ibmcom/icp-inception:2.1.0-beta-2 cp -r cluster /data
 ```
* In the cluster folder there are multiple files to modify: config.yaml, hosts, and ssh-keys
  * hosts: As we run in a single VM, the master, proxy and worker node will have the same ip address. So get the VM ip address using:
  ```
  $ ip address
  ```
   * Modify the hosts file
  ```
  [master]
   172.16.251.133
   [worker]
   172.16.251.133
   [proxy]
   172.16.251.133
  ```
  * Modify the config.yaml file (using administrator so sudo) by specifying a domain name and cluster name, but also the loopback dns flag so the server will run in single VM without error.
  ```
  loopback_dns: true
  cluster_name: mycluster
  cluster_domain: mycluster.domain
  ```
  * Copy security keys to the ssh_key file
  ```
  $ cp ~/.ssh/id_rsa ./ssh_key
  ```
  * Deploy the environment now
  ```
  # from the cluster folder
  $ sudo docker run -e LICENSE=accept --net=host --rm -t -v "$(pwd)":/installer/cluster ibmcom/icp-inception:2.1.0-beta-2 install
  ```
  * Verify access to ICP console using http://ipaddress:8443 admin/admin
  You should see the dashboard as in figure below:

  ![](icp-dashboard.png)

  # Some common issues:
  ### hostname not resolved
  ```
   fatal: [...] => Failed to connect to the host via ssh: ssh: Could not resolve hostname ...:
   Name or service not known
  ```
  * verify the hostname match the ip address in /etc/hosts
  * be sure to start the installation from the folder with the hosts file/ (cluster) or modify $(pwd) to $(pwd)/cluster

  ```
  fatal: [192.168.1.147] => Failed to connect to the host via ssh:
  Permission denied (publickey,password).
  ```
This is a problem of accessing root user during the installation. Be sure to authorize root login, (ssh_config file), that the ssh_key is in the root user home/.ssh. See [above](https://github.com/ibm-cloud-architecture/refarch-cognitive/blob/master/doc/install-dev-icp21.md#ubuntu-specifics)

While login from a developer's laptop.
```
$ docker login cluster.icp:8500
>
Error response from daemon: Get https://cluster.icp:8500/v2/: net/http:
request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)
```
Be sure the cluster.icp hostname is mapped to the host's IP address in the local /etc/hosts

```
$ docker login cluster.icp:8500
Error response from daemon: Get https://cluster.icp:8500/v2/: x509: certificate signed
by unknown authority
```


The local docker machine running on the developer's laptop needs to access certificate. The certificates are in the logged user **~/.docker** folder. This folder should have a **certs.d** folder and one folder per remote server, you need to access. So the cluster.icp:8500/ca.crt file needs to be copied there too.
