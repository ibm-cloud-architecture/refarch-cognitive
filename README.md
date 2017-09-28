# Cognitive Reference Architecture
This project provides a reference implementation for building and running cloud based cognitive application using micro service architecture, Watson Cloud development APIs, and Cloud Service Management and Operations. This is the **cyan compute model** and aims to give best practices to develop hybrid cognitive application that accesses on-premise datasource, a set of IBM Cloud Watson Services.
# Table of Contents
* [Architecture](https://github.com/ibm-cloud-architecture/refarch-cognitive#architecture)  
* [Project Repositories](https://github.com/ibm-cloud-architecture/refarch-cognitive#project-repositories)
* [Pre requisites](https://github.com/ibm-cloud-architecture/refarch-cognitive#pre-requisites)
* [Skill Set](https://github.com/ibm-cloud-architecture/refarch-cognitive#expected-skill-set)
* [Build and Run](https://github.com/ibm-cloud-architecture/refarch-cognitive#run-the-reference-application-locally)
* [Resiliency](doc/resilience.md)
* [Contribute](https://github.com/ibm-cloud-architecture/refarch-cognitive#contribute)

# Architecture
At the high level, the set of code repositories defined in this computing model supports the following diagram:
![](doc/cyan-compute.png)

For explanation of the components of this architecture see [Architecture Center - Cognitive Architecture](https://www.ibm.com/devops/method/content/architecture/cognitiveArchitecture#0_0)

The **cognitive computing solution** implementation is aimed to support dedicated micro-services to front end IBM Cloud Watson Services such as Watson Conversation and Watson Discovery in a context of business user cases. This is a *broker* pattern where the micro services are responsible to do service orchestration to support some of the business requirements, and  to address non functional requirements like resiliency, logging and security.

As of now each broker code has a simple user interface to demonstrate the implemented logic, but they also offer REST api that can be consumed by other applications. The integrated 'business' application that illustrates how those services are consumed is part of the Hybrid compute model presented in this repository: [hybrid integration solution](https://github.com/ibm-cloud-architecture/refarch-integration) and specially within the *Case Inc* portal application.

# Project Repositories
This root project is just here for common scripts and best practice articles, it also leverages other code repository to present specific use cases.

* [Cognitive Conversation Broker](https://github.com/ibm-cloud-architecture/refarch-cognitive-conversation-broker) presents the broker pattern to facade Watson Conversation to implement business oriented orchestration of services, to support resiliency, logging, failover, high availability, service management,... It also deliver a simple [Angular 4](https://angular.io) user interface to test two conversations: *IT support*, and *help in context* of a BPM process. The project includes a step by step tutorial to help you build the *IT support* chat bot.
* [Cognitive Discovery Broker](https://github.com/ibm-cloud-architecture/refarch-cognitive-discovery-broker) presents the same broker pattern applied to front end Watson Discovery Service. The project includes a user interface in Angular to present Discovery Results, and a tutorial to build a *hurricane getting ready* knowledge base.
* [Context driven dialog with ODM](https://github.com/ibm-cloud-architecture/context-driven-dialog) This project use Natural Language Classifier to understand a user's query and IBM Operational Decision Management rulesets to support the dialog implementation with richer data model.
 * [Supplier On Boarding Business Process for IBM BPM on Cloud](https://github.com/ibm-cloud-architecture/refarch-cognitive-supplier-process) This business process deployable on **IBM BPM Standard** or **IBM BPM on Cloud** demonstrates how to expose a process as a web service so it can be triggered by the Conversation broker and to integrate Discovery broker inside the process flow so the process can use the curated **News Collection** of the Watson Discovery. Finally the process integrate the *help in context* conversation that calls back the conversation broker.
* [ODM data model to integrate with Watson Conversation](https://github.com/ibm-cloud-architecture/refarch-cognitive-odm-model): This project defines the rule business object model to support assessment, questionnaire and questions so the dialog flow can also be enhanced with ODM, and ODM used as best action decision automation from derived facts coming from NLU, Classifiers and Watson Conversation context object.

# Pre Requisites
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

# Expected skill set
This project is for developers, technical sellers, and architects. As the code and how tos are based on nodejs, javascript and REST api, the following tutorials can be used for skill ramp up:
* npm for node and javascript installation: [What is npm](https://docs.npmjs.com/getting-started/what-is-npm)
* nodejs with a simple tutorial at [w3school](https://www.w3schools.com/nodejs/)
* expressjs [tutorial](https://www.tutorialspoint.com/nodejs/nodejs_express_framework.htm)
* angular 4 is used for the user interface of each component, you can use the excellent official [tutorial](https://angular.io/docs/ts/latest/tutorial/) to get good skill set and the code explanation in each project.

You can learn from the **Cognitive compute** work:
* how to create a Watson Conversation with this [hands-on tutorial](https://github.com/ibm-cloud-architecture/refarch-cognitive-conversation-broker/blob/master/doc/tutorial/README.md) and how to integrate with BPM
* how to create document collection in Watson Discovery, how to do advance query, how to integrate with public API, how to leverage Knowledge Studio in this [deep dive tutorial](https://github.com/ibm-cloud-architecture/refarch-cognitive-discovery-broker/blob/master/doc/tutorial/wds-lab.md)

# Build and Run
## Get source code

Clone the base repository: ``` git clone https://github.com/ibm-cloud-architecture/refarch-cognitive```

Clone the peer repositories: ```./clonePeers.sh```  

## Build and run locally each application.
* If not already done, install the different CLI needed: bluemix, cf, and kubernetes, we deliver for you a script to install all the dependant CLI tools: see `./install_cli.sh`
* See instruction and tutorial in each project for how to deploy and run each use case.

## Deploy the solution as dockerized applications in Kubernetes Cluster like IBM Cloud Private
Each **Cyan compute** app has its own dockerfile and [helm](https://github.com/kubernetes/helm) chart to support Kubernetes and IBM Cloud Private deployment. [This section](doc/cyancluster.md) describes some basic knowledge about docker and **cyan cluster** kubernetes settings.

Each project explains how to deploy itself in IBM Cloud Private:
* the Watson Conversation Broker [IT support on ICP](https://github.com/ibm-cloud-architecture/refarch-cognitive-discovery-broker/blob/master/doc/icp-deploy.md)
* the Watson Discovery Broker micro-service see [the note](https://github.com/ibm-cloud-architecture/refarch-cognitive-discovery-broker/blob/master/doc/wds-broker-kube.md)

# Compendium
* [Watson Cloud platform documentation](https://www.ibm.com/watson/developercloud/doc/index.html)
* [Cognitive @ Architecture center](https://www.ibm.com/devops/method/content/architecture/cognitiveArchitecture/0_0)
* [Cognitive concept 101](https://www.ibm.com/devops/method/content/code/practice-cognitive-101/)
* [IBM Jounrney samples](https://developer.ibm.com/code/journey/category/artificial-intelligence/)

# Contribute
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
