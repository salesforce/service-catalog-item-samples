# Service Catalog Recipes

A collection of easy-to-digest Service Catalog Item examples that can be used as a baseline for your Service Catalog implementation. These examples demonstrate different capabilities of the Service Catalog.

## Table of Contents

-   [Install the Catalog Using an Unlocked Package](#install-the-catalog-using-an-unlocked-package-recommended): **RECOMMENDED**. This option allows admins without development knowledge to experience the sample catalog without installing a local development environment.

-   [Deploy the Example to an Org](#deploy-the-example-to-an-org): This option is for developers or advanced admins who wants to experience the catalog item as a baseline for advanced building.

## Install the Catalog Using an Unlocked Package (RECOMMENDED)

Follow this set of instructions if you want to deploy the catalog to a sandbox. We suggest that you avoid installing this package in production, but that you use this as a baseline for building your own catalog.

**Prerequisite:** Follow the documentation (Link to be added) to assign the necessary permissions to your users.

1. Log in to your org

1. Click [this link](https://login.salesforce.com/packaging/installPackage.apexp?p0=04t4W0000038VvfQAE) to install the recipes from the unlocked package into your org.

1. Select **Install for All Users**.

1. From Setup in your org, search for `Service Catalog` and click **Get Started**.

1. Explore the examples.

## Deploy the Example to an Org

This option is for developers or advanced admins who wants to experience the catalog item as a baseline for advanced building.

<a href="https://githubsfdeploy.herokuapp.com?owner=CovidBackToWork&repo=service-catalog-recipes">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>

1. From the upper right corner, click **Login to Salesforce**.

1. Enter your org credentials.

1. If asked, allow the **Deploy to Salesforce** tool to perform the requested actions.

1. When you're redirected back to the Salesforce page, from the upper right corner, click **Deploy**.

## (Draft) Scratch Org

1. If you haven't already done so, authorize your hub org and provide it with an alias (**myhuborg** in the command below):

    ```
    sfdx auth:web:login -d -a myhuborg
    ```

1. Clone the service catalog recipes repository:

    ```
    git clone https://github.com/CovidBackToWork/service-catalog-recipes
    cd service-catalog-recipes
    ```

1. Create a scratch org and provide it with an alias (**service-catalog-recipes** in the command below):

    ```
    sfdx force:org:create -s -f config/project-scratch-def.json -a service-catalog-recipes
    ```

1. Assign the ServiceCatalogBuilder permission set to the scratch org user:

    ```
    sfdx force:user:permset:assign -n ServiceCatalogBuilder
    ```

1. Assign the EmployeeExperience permission set license to the scratch org user:

    ```
    echo "insert new PermissionSetLicenseAssign(AssigneeId = UserInfo.getUserId(), PermissionSetLicenseId = [SELECT Id FROM PermissionSetLicense WHERE DeveloperName='EmployeeExperiencePsl']?.Id);" | sfdx force:apex:execute
    ```

1. Create the permission set to access Employee objects:

    ```
    sfdx force:source:deploy -p force-app/unpackaged/permissionsets
    ```

1. Assign the employee permission set to the scratch org user:

    ```
    sfdx force:user:permset:assign -n EmployeeObjectsAccess
    ```

1. Push the app to your scratch org:

    ```
    sfdx force:source:push -f
    ```

1. Assign the permission set for the dev recipes use cases to the scratch org user:

    ```
    sfdx force:user:permset:assign -n ServiceCatalogRecipesAccess
    ```

1. Open the scratch org:

    ```
    sfdx force:org:open
    ```
