# Creating an application for Nebius AI

This guide provides comprehensive instructions on how to create a [Nebius AI](https://nebius.com) application. It covers everything from setting up the necessary files, to detailing their contents, to finally submitting your application for review and publication. By the end of this guide, you will have learned everything you need to know to add your application to the Nebius AI catalog so that users can deploy it on their [Managed Service for Kubernetes®](https://nebius.com/services/managed-kubernetes) clusters and [Compute](https://nebius.com/services/compute) virtual machines.

## Preparing an application

In this section, you will learn how to create and prepare an application for publication on Nebius AI. This guide will take you through each of the required files and provide detailed explanations and practical examples of how to create them. By the end of this section, you will have a fully structured application ready for submission.

An example of a working application can be found [here](.).

### File structure

A Nebius AI application follows a defined file and directory structure, which is detailed below:

```text
product-name/
  ├── chart/             # Helm chart
  ├── icon.svg           # Icon
  ├── manifest.yaml      # Metadata
  ├── README.md          # Documentation
  ├── values.form.json   # Configuration of the web console installation form
  └── values.k3s.yaml    # Helm value overrides for installation on VMs using K3s
```

- `chart/`: This directory contains the [Helm](https://helm.sh/) chart for your application.
- `icon.svg`: The SVG icon that represents your application in Nebius AI.
- `manifest.yaml`: A YAML manifest that contains the application metadata. For details, see [Manifest](#manifest).
- `README.md`: A Markdown file that contains the documentation for your application, including its description, usage instructions, support information, and links. For details, see [README](#readme).
- `values.form.json`: A JSON file that defines the application installation form in the Nebius AI web console. This form allows users to enter parameters that are passed to the Helm chart to set up the application. For details, see [UI installation form](#ui-installation-form-valuesformjson).
- `values.k3s.yaml`: A YAML file containing Helm value overrides for deploying the application to Compute virtual machines using [K3s](https://k3s.io/). For details, see [K3s overrides for installation on VMs](#k3s-overrides-for-installation-on-vms-valuesk3syaml).

### Manifest

`manifest.yaml` is a YAML file that must contain the following keys:

- `slug`: A unique product identifier. This value will be part of the application's URL, but will not be directly visible to users.
- `publisherName`: The name of your company.
- `ownerName`: The name of the product owner’s company.
- `categories`: A list of categories that best describe your application. For supported categories, see [Application categories](#application-categories) section.
- `tariff_type`: The value of this field must be `free`. Currently, Nebius AI only supports free applications. As soon as paid applications are supported, this tutorial will be updated accordingly.
- `images`: List of references to locations in `chart/values.yaml` where Docker images are defined. For details, see [List of images](#list-of-images).

#### List of images

The `images` field in `manifest.yaml` contains a list of references to Docker images defined in the `chart/values.yaml` file. It must contain references to **all** images used in the application, which means that **all images** should be defined in `chart/values.yaml`, including those in sub-charts if your application chart has them.

Each item in the `images` list must follow one of the three specific formats, depending on how the Docker image is
defined in `values.yaml`:

- **Repository URL, image name and tag**

  Use this format if the Docker image is declared using separate fields for the repository, image and version/tag.

  > Example:
  >
  > - `values.yaml`:
  >
  >   ```yaml
  >   imageWithRepository:
  >     repository: cr-testing.eu-north1.nebius.cloud/e0txwed46999g5htgx/nebius
  >     image: nginx
  >     version: "1.27.1"
  >   ```
  >
  > - `images` entry:
  >
  >   ```yaml
  >   - registry: imageWithRepository.repository
  >     tag: imageWithRepository.version
  >     nameWithoutRegistry: imageWithRepository.image
  >   ```

- **Image URL and tag**

  Use this format if the repository and tag are defined as separate fields in `values.yaml`.

  > Example:
  >
  > - `values.yaml`:
  >
  >   ```yaml
  >   image:
  >     repository: cr-testing.eu-north1.nebius.cloud/e0txwed46999g5htgx/nebius/nginx
  >     tag: "1.27.1"
  >   ```
  >
  > - `images` entry:
  >
  >   ```yaml
  >   - nameWithRegistry: image.repository
  >     tag: image.tag
  >   ```

- **Full image URL**

  Use this format if `values.yaml` contains a single value with the full URL of the Docker image, including repository, image and tag.

  > Example:
  >
  > - `values.yaml`:
  >
  >   ```yaml
  >   fullImage: cr-testing.eu-north1.nebius.cloud/e0txwed46999g5htgx/nebius/nginx:1.27.1
  >   ```
  >
  > - `images` entry:
  >
  >   ```yaml
  >   - full: fullImage
  >   ```

#### Application categories

You can use these values in the `categories` list in `manifest.yaml`:

- `ml-ai`
- `dev-tools`
- `dataset-preparation`
- `databases`
- `vector-databases`
- `inference`
- `training`
- `recommended`
- `llm-apps-framework`
- `navigation-infrastructure-network`
- `network`
- `new-products`
- `test-products`
- `k3s-navigation-infrastructure-network`
- `k3s-inference`
- `k3s-vector-databases`
- `k3s-network`
- `k3s-dataset-preparation`
- `k3s-dev-tools`
- `k3s-llm-apps-framework`
- `k3s-training`
- `k3s-databases`

### README

`README.md` is a Markdown file that serves as the primary source of information about your application. It must contain the following sections:

1. `## Description`

   A detailed introduction and description of the application. It will be displayed to users on the application page in the Nebius AI web console.

1. `## Short description`

   A brief summary of your application. It will appear on the application card in the list of all applications.

1. `## Tutorial`

   Installation instructions, including prerequisites. They will be displayed to users on the application installation page. Their aim is to give users all the information they need to get the application up and running. This section can include links (`[text](URL)`) and special blocks to make the tutorial easier to follow and understand.

   > Examples of special blocks:
   >
   > ```yaml
   > {% note warning %}
   > 
   > Custom configuration warning.
   > 
   > {% endnote %}
   >
   > {% list tabs %}
   > 
   > - Tab 1
   > 
   >   1. Step 1 for Tab 1
   >   2. Step 2 for Tab 1
   >
   > - Tab 2
   >
   >   1. Step 1 for Tab 2
   >   2. Step 2 for Tab 2
   > 
   > {% endlist %}
   > ```

1. `## Usage`

   Instructions on how to get started with the application, e.g. connect to it and use it for the first time. They will be displayed on the page of an installed application. You can use links and special blocks in this section as well.

1. `## Use cases`

   This section should outline the main use cases for your application. These use cases will be displayed just below the application description on its page in the web console.

1. `## Links`

   Use this section to include useful links such as documentation, tutorials, source code, or any other relevant resources related to your application.

   > Example:
   >
   > ```yaml
   > ## Links
   > 
   > [Documentation](https://nginx.org/en/docs/index.html)
   > [Source code](https://github.com/nginx/nginx)
   > ```

1. `## Legal`

   This section must include details about any relevant third party terms of service.

   > Example:
   >
   > ```yaml
   > ## Legal
   >
   > By using the application, you agree to their terms and conditions: [the helm-chart](https://github.com/nebius/nebius-k8s-applications/blob/main/LICENSE) and [Nginx](https://nginx.org/LICENSE).
   > ```

### UI installation form (`values.form.json`)

`values.form.json` defines a [Gravity UI Dynamic Form](https://preview.gravity-ui.com/dynamic-forms/?path=/story/array-base--base) that allows users to configure the application in the Nebius AI web console during installation. Each field name should match a valid path in `chart/values.yaml`, ensuring that the form value is passed to the corresponding value in the Helm chart.

In addition to the fields defined in the `values.form.json` file, the form also includes `name` and `namespace` fields by default, which are passed directly to Helm during chart installation.

For a detailed example and the list of all supported field types, see [values.form.json](values.form.json).

> Example:
>
> - `values.form.json`:
>
>   ```yaml
>   "gradioExampleValues.simpleString": {
>     "type": "string",
>     "viewSpec": {
>       "layoutTitle": "String input",
>       "layout": "row",
>       "type": "base",
>       "disabled": false
>     },
>     "required": true
>   }
>   ```
>
> - `chart/values.yaml` value:
>
>   ```yaml
>   gradioExampleValues:
>     simpleString: ""
>   ```

### K3s overrides for installation on VMs (`values.k3s.yaml`)

`values.k3s.yaml` is a YAML file that specifies the Helm value overrides required to deploy the application on a Compute virtual machine using [K3s](https://k3s.io), instead of a Managed Service for Kubernetes cluster. For example, the file can override resource- and environment-specific settings. Include this file if you want to make your application available for Compute VMs.

`values.k3s.yaml` should only contain the necessary value overrides required for K3s deployment, not the full set of values.

## Publishing your product

This section provides an overview of the publishing process, detailing each of the steps required to publish an application in Nebius AI.

### Step 1: Pull request

Submit a pull request with your application to [this repository](https://github.com/nebius/nebius-k8s-applications). Make sure that all relevant files are included and that the documentation follows the specified format.

### Step 2: Validation and testing

The repository maintainers will test your application for functionality and compliance. Be prepared to address any feedback or requested changes to ensure that your application meets the required quality standards.

### Step 3: Publication

Once the PR is merged, your application becomes available to Nebius AI users.
