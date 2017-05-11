# Cognitive Reference Architecture

# Architecture
This project provides a reference implementation for building cognitive application on the cloud using micro service architecture, Watson Cloud development APIs, and Cloud Service Management and Operations.
[Architecture Center - Cognitive Architecture](https://www.ibm.com/devops/method/content/architecture/cognitiveArchitecture#0_0)
# Project Repositories
This project leverages other projects by applying clear separation of concerns design and micro service approach.
* [Cognitive Conversation Broker](https://github.com/ibm-cloud-architecture/refarch-cognitive-conversation-broker)
* [Cognitive Discovery Broker](https://github.com/ibm-cloud-architecture/refarch-cognitive-discovery-broker)
* [Cognitive Extends](https://github.com/ibm-cloud-architecture/refarch-cognitive-extends)

# Run the reference application locally and on IBM Bluemix
To run the sample application you will need to configure your Bluemix environment by adding web application (nodejs sdk) and some of the Watson services... See each specific project for instructions.

## Step 1: Environment Setup
### Prerequisites

### Install the Bluemix CLI
As IBM Bluemix application, many commands will require the Bluemix CLI toolkit to be installed on your local environment. To install it, follow [these instructions](https://console.ng.bluemix.net/docs/cli/index.html#cli)

### Create a New Space in Bluemix

1. Click on the Bluemix account in the top right corner of the web interface.
2. Click Create a new space.
3. Enter "cognitive-dev" for the space name and complete the wizard.

## Step 2: Get application source code

Clone the base repository: ``` git clone https://github.com/ibm-cloud-architecture/refarch-cognitive```

Clone the peer repositories: ./clonePeers.sh

## Step 3: Build and run locally each application.
See instructions in each project.
