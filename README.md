# ToDo Application with a FastAPI with sqlite3 and HTMX on Azure App Service (Terraform)

[![Pylint](https://github.com/atrakic/fastapi-htmx-azd-template/actions/workflows/pylint.yml/badge.svg)](https://github.com/atrakic/fastapi-htmx-azd-template/actions/workflows/pylint.yml)

A ToDo template that includes everything you need to build, deploy, and monitor an Azure solution.
Uses the Azure Developer CLI (azd) to get you up and running on Azure quickly using Terraform as the IaC provider, Htmx for the Web application, Python (FastAPI) for the API, and Azure Monitor for monitoring and logging.
It includes application code, tools, and pipelines that serve as a foundation from which you can build upon and customize when creating your own solutions.

### Prerequisites

The following prerequisites are required to use this application. Please ensure that you have them all installed locally.

- [Azure Developer CLI](https://aka.ms/azd-install)
- [Python (3.8+)](https://www.python.org/downloads/) - for the API backend
- [Terraform CLI](https://aka.ms/azure-dev/terraform-install)
- [Azure secrets](https://aka.ms/create-secrets-for-GitHub-workflows)

### Quickstart

The fastest way for you to get this application up and running on Azure is to use the `azd up` command. This single command will create and configure all necessary Azure resources - including access policies and roles for your account and service-to-service communication with Managed Identities.

1. Open a terminal, create a new empty folder, and change into it.
1. Create a new [Python virtual environment](https://docs.python.org/3/library/venv.html).
1. Run the following command to initialize the project, provision Azure resources, and deploy the application code.

```bash
azd up --template atrakic/fastapi-htmx-azd-template
```

You will be prompted for the following information:

- `Environment Name`: This will be used as a prefix for the resource group that will be created to hold all Azure resources.
This name should be unique within your Azure subscription.
- `Azure Location`: The Azure location where your resources will be deployed.
- `Azure Subscription`: The Azure Subscription where your resources will be deployed.

> NOTE: This may take a while to complete as it executes three commands: `azd init` (initializes environment), `azd provision` (provisions Azure resources), and `azd deploy` (deploys application code). You will see a progress indicator as it provisions and deploys your application.

When `azd up` is complete it will output the following URLs:

- Azure Portal link to view resources
- ToDo API application

Click the web application URL to launch the ToDo app. Create a new collection and add some items. This will create monitoring activity in the application that you will be able to see later when you run `azd monitor`.

> NOTE:
>
> - The `azd up` command will create Azure resources that will incur costs to your Azure subscription. You can clean up those resources manually via the Azure portal or with the `azd down` command.
> - You can call `azd up` as many times as you like to both provision and deploy your solution, but you only need to provide the `--template` parameter the first time you call it to get the code locally. Subsequent `azd up` calls do not require the template parameter. If you do provide the parameter, all your local source code will be overwritten if you agree to overwrite when prompted.
> - You can always create a new environment with `azd env new`.

### Application Architecture

This application utilizes the following Azure resources:

- [**Azure App Services**](https://docs.microsoft.com/azure/app-service/) to host the Web app

### Application Code

The repo is structured to follow the [Azure Developer CLI](https://aka.ms/azure-dev/overview) conventions including:

- **Source Code**: All application source code is located in the `src` folder.
- **Infrastructure as Code**: All application "infrastructure as code" files are located in the `infra` folder.
- **Azure Developer Configuration**: An `azure.yaml` file located in the root that ties the application source code to the Azure services defined in your "infrastructure as code" files.
- **GitHub Actions**: A sample GitHub action file is located in the `.github/workflows` folder.

### Azure Subscription

This template will create infrastructure and deploy code to Azure. If you don't have an Azure Subscription, you can sign up for a [free account here](https://azure.microsoft.com/free/). Make sure you have contributor role to the Azure subscription.

### Azure Developer CLI - VS Code Extension

The Azure Developer experience includes an Azure Developer CLI VS Code Extension that mirrors all of the Azure Developer CLI commands into the `azure.yaml` context menu and command palette options. If you are a VS Code user, then we highly recommend installing this extension for the best experience.

Here's how to install it:

#### VS Code

1. Click on the "Extensions" tab in VS Code
1. Search for "Azure Developer CLI" - authored by Microsoft
1. Click "Install"

#### Marketplace

1. Go to the [Azure Developer CLI - VS Code Extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.azure-dev) page
1. Click "Install"

Once the extension is installed, you can press `F1`, and type "Azure Developer CLI" to see all of your available options. You can also right click on your project's `azure.yaml` file for a list of commands.

### Next Steps

At this point, you have a complete application deployed on Azure. But there is much more that the Azure Developer CLI can do. These next steps will introduce you to additional commands that will make creating applications on Azure much easier. Using the Azure Developer CLI, you can setup your pipelines, monitor your application, test and debug locally.

#### Set up a pipeline using `azd pipeline`

This template includes a GitHub Actions pipeline configuration file that will deploy your application whenever code is pushed to the main branch. You can find that pipeline file here: `.github/workflows`.

Setting up this pipeline requires you to give GitHub permission to deploy to Azure on your behalf, which is done via a Service Principal stored in a GitHub secret named `AZURE_CREDENTIALS`. The `azd pipeline config` command will automatically create a service principal for you. The command also helps to create a private GitHub repository and pushes code to the newly created repo.

Before you call the `azd pipeline config` command, you'll need to install the following:

- [GitHub CLI (2.3+)](https://github.com/cli/cli)

Run the following command to set up a GitHub Action:

```bash
azd pipeline config
```

#### Monitor the application using `azd monitor`

To help with monitoring applications, the Azure Dev CLI provides a `monitor` command to help you get to the various Application Insights dashboards.

- Run the following command to open the "Overview" dashboard:

  ```bash
  azd monitor --overview
  ```

- Live Metrics Dashboard

  Run the following command to open the "Live Metrics" dashboard:

  ```bash
  azd monitor --live
  ```

- Logs Dashboard

  Run the following command to open the "Logs" dashboard:

  ```bash
  azd monitor --logs
  ```

#### Clean up resources

When you are done, you can delete all the Azure resources created with this template by running the following command:

```bash
azd down
```
