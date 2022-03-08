# Sample Service Catalog Items

A collection of easy-to-digest sample Service Catalog items that can be used as a baseline for items in your service catalog. Sample items in this package include ordering a new laptop, relocating your work desk, resetting your password, and more.

## Table of Contents

-   [Assign Necessary Permissions](#assign-necessary-permissions): Before you install a catalog with the unlocked package or deploy the contents of a catalog to your org, you must first assign the necessary permissions.

-   [Install a Catalog with the Unlocked Package](#install-a-catalog-with-an-unlocked-package-recommended): **RECOMMENDED**. This option lets you customize a catalog in a sandbox before promoting it to your production org. Ideal for admins with zero development knowledge.

-   [Deploy the Sample Catalog Items to an Org](#deploy-the-sample-catalog-items-to-an-org): This option lets you deploy the contents of a catalog, including these sample items, into your production org. You can then retrieve and customize these sample items via the Metadata and Tooling APIs. Ideal for developers and advanced admins.

## Assign Necessary Permissions

Before you install a catalog with the unlocked package or deploy the contents of a catalog to your org, you must first assign the necessary permissions.

_Permission details coming soon._

## Install a Catalog with an Unlocked Package (RECOMMENDED)

These instructions deploy a catalog to a sandbox. You can then customize the catalog before promoting it to your production org.

1. Log in to your org.

1. Install the [Sample Service Catalog Items package](https://login.salesforce.com/packaging/installPackage.apexp?p0=04t4W0000038VvfQAE) into your org.

1. Select **Install for All Users**.

1. From Setup, in the Quick Find box, enter _Service Catalog_ and click **Get Started**.

1. In the Builder, explore the sample items available in the package. You can use these sample items as a reference for the items you create in your catalog.

## Deploy the Sample Catalog Items to an Org

These instructions deploy the contents of a catalog, including these sample items, into your production org. Once deployed, you can retrieve and customize the catalog and these sample items via the Metadata and Tooling APIs.

1. From the [GitHub Salesforce Deploy Tool](https://githubsfdeploy.herokuapp.com?owner=CovidBackToWork&repo=service-catalog-recipes), click **Login to Salesforce**.

1. If asked, click **Allow** to let the **Deploy to Salesforce** tool perform the requested actions.

1. Enter your org credentials.

1. When you're redirected back to the Salesforce page, click **Deploy**.

## (Draft) `sfdx` Environment

These instructions let you set up a local `sfdx` environment with a scratch org by cloning the repo and creating a catalog in a `sfdx` project.

1. If you haven't done so yet, authorize your hub org and provide it with an alias. (We use `myhuborg` in this example.)

    ```
    sfdx auth:web:login -d -a myhuborg
    ```

1. Clone the Sample Service Catalog Items repository.

    ```
    git clone https://github.com/CovidBackToWork/service-catalog-recipes
    cd service-catalog-recipes
    ```

1. Create a scratch org and provide it with an alias. (We use `service-catalog-recipes` in this example.)

    ```
    sfdx force:org:create -s -f config/project-scratch-def.json -a service-catalog-recipes
    ```

1. Assign the `ServiceCatalogBuilder` permission set to the scratch org user.

    ```
    sfdx force:user:permset:assign -n ServiceCatalogBuilder
    ```

1. Assign the `EmployeeExperience` permission set license to the scratch org user.

    ```
    echo "insert new PermissionSetLicenseAssign(AssigneeId = UserInfo.getUserId(), PermissionSetLicenseId = [SELECT Id FROM PermissionSetLicense WHERE DeveloperName='EmployeeExperiencePsl']?.Id);" | sfdx force:apex:execute
    ```

1. Deploy a permission set to access Employee objects.

    ```
    sfdx force:source:deploy -p force-app/unpackaged/permissionsets
    ```

1. Assign the `EmployeeObjectsAccess` permission set to the scratch org user.

    ```
    sfdx force:user:permset:assign -n EmployeeObjectsAccess
    ```

1. Push the app to your scratch org.

    ```
    sfdx force:source:push -f
    ```

1. Assign the `ServiceCatalogRecipesAccess` permission set for the dev recipes use cases to the scratch org user.

    ```
    sfdx force:user:permset:assign -n ServiceCatalogRecipesAccess
    ```

1. Open the scratch org.

    ```
    sfdx force:org:open
    ```
