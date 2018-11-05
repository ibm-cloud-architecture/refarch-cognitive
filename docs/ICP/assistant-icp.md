# Deploy Watson Assistant on ICP

Update 11/05/2018

The product installation instructions are [here](https://console.bluemix.net/docs/services/assistant-icp/install.html#install).

What we have to adapt:
* Download the Watson Assistant product from Passport Advantage (Linux 64bit code CNX12EN) on a NFS server.
* We already have an ICP 2.1.0.3
* For production environment the ICP needs to have 3 master nodes, 3 proxies and more than 4 worker nodes. Watson Assistant is deployed only on worker nodes.
* We install only English language  

### New Deployment Diagram In Hybrid Cloud
