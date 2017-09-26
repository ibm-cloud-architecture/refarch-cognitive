# Cognitive Reference Architecture
This project provides a reference implementation for building and running cloud based cognitive application using micro service architecture, Watson Cloud development APIs, and Cloud Service Management and Operations. This is the **cyan compute model** and aims to give best practices to develop hybrid cognitive application that accesses on-premise datasource, a set of Bluemix Watson Services.
## Table of Contents
* [Architecture](https://github.com/ibm-cloud-architecture/refarch-cognitive#architecture)  
* [Project Repositories](https://github.com/ibm-cloud-architecture/refarch-cognitive#project-repositories)
* [Pre requisites](https://github.com/ibm-cloud-architecture/refarch-cognitive#pre-requisites)
* [Skill Set](https://github.com/ibm-cloud-architecture/refarch-cognitive#expected-skill-set)
* [Run the reference application locally](https://github.com/ibm-cloud-architecture/refarch-cognitive#run-the-reference-application-locally)
* [Deployment](https://github.com/ibm-cloud-architecture/refarch-cognitive#deploy-the-solution-as-dockerized-applications-in-kubernetes-cluster)
* [Contribute](https://github.com/ibm-cloud-architecture/refarch-cognitive#contribute)

## Architecture
At the high level the set of code repositories defined in this compute model support the following diagram:
![](doc/cyan-compute.png)

For explanation of the components of this architecture see [Architecture Center - Cognitive Architecture](https://www.ibm.com/devops/method/content/architecture/cognitiveArchitecture#0_0)

The **cyan compute** implementation is aimed to support dedicated micro-services to front end Bluemix Watson Services such as Watson Conversation and Watson Discovery. This is a *broker* pattern where the microservices are responsible to do service orchestration to support some of the business requirements, and non functional requirements like resiliency, logging and other security.

As of now each broker code has a simple user interface to demonstrate the implemented logic, but they also offer REST api that can be consumed by other application. The integrated 'business' application that illustrates how those services are consumed is part of the Hybrid compute model presented in this repository: [brown compute](https://github.com/ibm-cloud-architecture/refarch-integration) and specially within the 8Case Inc* portal application.

## Project Repositories
This project leverages other projects by applying clear separation of concerns practice and micro service approach.
* [Cognitive Conversation Broker](https://github.com/ibm-cloud-architecture/refarch-cognitive-conversation-broker) presents the broker pattern to facade Watson Conversation to implement business oriented orchestration of services, to support resiliency, logging, failover, high availability, service management,... It also deliver a simple Angular 2 user interface to test two conversations: *IT support*, and *help in context* of a BPM process. The project includes a step by step tutorial to help you build the *IT support* chat bot.
* [Cognitive Discovery Broker](https://github.com/ibm-cloud-architecture/refarch-cognitive-discovery-broker) presents the same broker pattern but in front of Watson Discovery. The project includes a user interface in Angular 2 to present Discovery Results, and a tutorial to build a *hurricane* getting ready knowledge base.
* [Cognitive Extends](https://github.com/ibm-cloud-architecture/refarch-cognitive-extends)
* [Context driven dialog with ODM](https://github.com/ibm-cloud-architecture/context-driven-dialog) This project use Natural Language Classifier to understand a user's query and ODM rulesets to do support the dialog.
 * [Supplier On Boarding Business Process for IBM BPM on Cloud](https://github.com/ibm-cloud-architecture/refarch-cognitive-supplier-process) This business process deployable on IBM BPM, IBM BPM on Cloud demonstrates how to expose a process as a web service so it can be triggered by the Conversation broker and to ingrate Discovery broker inside the process flow so the process can use the curated **News Collection** in Watson Discovery. Finally the process integrate the *help in context* conversation.
* [ODM data model to integrate with Watson Conversation](https://github.com/ibm-cloud-architecture/refarch-cognitive-odm-model): This project defines the rule business object model to support assessment, questionnaire and questions so the dialog flow can also be enhanced with ODM, and ODM used as best action decision automation from derived facts coming from NLU, Classifiers and event Watson Conversation response.

## Pre Requisites
* You need your own [github.com](http://github.com) account
* You need a git client code. For example for [Windows](https://git-scm.com/download/win) and for [Mac](https://git-scm.com/download/mac)
* Install [npm](https://www.npmjs.com/get-npm) and [nodejs](). Normally getting nodejs last stable version will bring npm too.
* You need to have a [Bluemix](http://bluemix.net) account, and know how to use cloud foundry command line interface to push to bluemix, the web application used to demonstrate the solution.
* Create a New Space in Bluemix
To better isolate your work, apps and services
1. Click on the Bluemix account menu on the top right corner of the web interface.
2. Click Create a new space.
3. Enter "cognitive-dev" for the space name and complete the wizard.

* Install the Bluemix CLI: As IBM Bluemix application, many commands will require the Bluemix CLI toolkit to be installed on your local environment. To install it, follow [these instructions](https://console.ng.bluemix.net/docs/cli/index.html#cli)

## Expected skill set
This compute mode is for developer, technical sellers, and architect. As the code and how tos are based on nodejs, javascript and REST api, the following tutorial can be used for skill ramp up:
* npm for node and javascript installation: [What is npm](https://docs.npmjs.com/getting-started/what-is-npm)
* nodejs with a simple tutorial at [w3school](https://www.w3schools.com/nodejs/)
* expressjs [tutorial](https://www.tutorialspoint.com/nodejs/nodejs_express_framework.htm)
* angular 4 is used for the user interface of each component, you can use the excellent official [tutorial](https://angular.io/docs/ts/latest/tutorial/) to get good skill set and the code explanation in each project.

You can learn from the **Cyan compute** work:
* how to create a Watson Conversation with this [hands-on tutorial](https://github.com/ibm-cloud-architecture/refarch-cognitive-conversation-broker/blob/master/doc/tutorial/README.md) and how to integrate with BPM
* how to create document collection in Watson Discovery, how to do advance query, how to integrate with public API, how to leverage Knowledge Studio in this [deep dive tutorial](https://github.com/ibm-cloud-architecture/refarch-cognitive-discovery-broker/blob/master/doc/tutorial/wds-lab.md)

## Run the reference application locally
### Get cyan compute source code

Clone the base repository: ``` git clone https://github.com/ibm-cloud-architecture/refarch-cognitive```

Clone the peer repositories: ```./clonePeers.sh```  

### Build and run locally each application.
* If not already done, install the different CLI needed: bluemix, cf, and kubernetes, we deliver for you a script for that see `./install_cli.sh`
* See instruction and tutorial in each project.

## Deploy the solution as dockerized applications in Kubernetes Cluster
Each **Cyan compute** app has its own dockerfile and [helm](https://github.com/kubernetes/helm) chart to support Kubernetes and IBM Cloud Private deployment. To support high availability, monitoring, service management,... the docker containers are deployed on Bluemix Kubernetes Service. [This section](doc/cyancluster.md) describes some basic knowledge about docker and **cyan cluster** kubernetes settings.
Each project explains how to deploy itself in IBM Cloud Private **cyan cluster** for example for:
* the Watson Conversation Broker [IT support on ICP](https://github.com/ibm-cloud-architecture/refarch-cognitive-discovery-broker/blob/master/doc/icp-deploy.md)
* the Watson Discovery Broker microservice see [the note](https://github.com/ibm-cloud-architecture/refarch-cognitive-discovery-broker/blob/master/doc/wds-broker-kube.md)

## Contribute
We welcome your contribution. There are multiple ways to contribute: report bugs and improvement suggestion, improve documentation and contribute code.
We really value contributions and to maximize the impact of code contributions we request that any contributions follow these guidelines
* Please ensure you follow the coding standard and code formatting used throughout the existing code base
* All new features must be accompanied by associated tests
* Make sure all tests pass locally before submitting a pull request
* New pull requests should be created against the integration branch of the repository. This ensures new code is included in full stack integration tests before being merged into the master branch.
* One feature / bug fix / documentation update per pull request
* Include tests with every feature enhancement, improve tests with every bug fix
* One commit per pull request (squash your commits)
* Always pull the latest changes from upstream and rebase before creating pull request.

If you want to contribute, start by using git fork on this repository and then clone your own repository to your local workstation for development purpose. Add the up-stream repository to keep synchronized with the master.
