# Install a development environment with IBM Cloud Private 2.1
This is a quick summary of what you may do to install a ICP 2.1 CE development host on a single VM with Ubuntu 64 bits 16.10.

For a full tutorial on how to install ICP with 5 hosts see [this note](https://github.com/ibm-cloud-architecture/refarch-privatecloud/blob/master/Installing_ICP_on_prem.md)

See [ICP 2.1 product documentation](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0/installing/install_containers_CE.html) to get other details.

We still found some tricks to be consider so here are our steps:
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
Then you should be able to ssh via root too
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
## Install docker
If you do not have it.
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
   # relogin the user to get the group assignment at the session level
   ```

* Boot and log as root user

## IBM Cloud Private CE
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

  ## Some common issues:
  ### hostname not resolved
  ```
   fatal: [...] => Failed to connect to the host via ssh: ssh: Could not resolve hostname ...: Name or service not known
  ```
  * verify the hostname match the ip address in /etc/hosts
  * be sure to start the installation from the folder with the hosts file/ (cluster) or modify $(pwd) to $(pwd)/cluster

  ```
  fatal: [192.168.1.147] => Failed to connect to the host via ssh: Permission denied (publickey,password).
  ```
This is a problem of accessing root user during the installation. Be sure to authorize root login, (ssh_config file), that the ssh_key is in the root user home/.ssh. See [above](https://github.com/ibm-cloud-architecture/refarch-cognitive/blob/master/doc/install-dev-icp21.md#ubuntu-specifics)

```
FAILED - RETRYING: TASK: master : Ensuring that the Cloudant Database is ready (9 retries left).
```
