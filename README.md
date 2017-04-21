# Cognitive Reference Architecture

# Architecture
This project provides a reference implementation for building cognitive application on the cloud using microservices architecture, Watson Cloud development APIs, and Cloud Service Management and Operations.
[Architecture Center - Cognitive Architecture](https://www.ibm.com/devops/method/content/architecture/cognitiveArchitecture#0_0)
# Project Repositories
This project leverages other projects by applying clear separation of concerns design and microservice approach.
* [Cognitive Conversation Broker](https://github.com/jbcodeforce/refarch-cognitive-conversation-broker)
* [Cognitive Discovery Broker](https://github.com/jbcodeforce/refarch-cognitive-discovery-broker)
* [Cognitive Extends]()

# Run the reference application locally and on IBM Bluemix
To run the sample application you will need to configure your Bluemix environment for the API and Microservices runtimes, configure Watson services...

## Step 1: Environment Setup
### Prerequisites

### Install the Bluemix CLI
As IBM Bluemix application, many commands will require the Bluemix CLI toolkit to be installed on your local environment. To install it, follow [these instructions](https://console.ng.bluemix.net/docs/cli/index.html#cli)

The following steps use the cf tool.

### Create a New Space in Bluemix

1. Click on the Bluemix account in the top right corner of the web interface.
2. Click Create a new space.
3. Enter "cloudnative-dev" for the space name and complete the wizard.

### Get application source code

Clone the base repository: ``` git clone https://github.com/jbcodeforce/refarch-cognitive```

Clone the peer repositories: ./clonePeers.sh
