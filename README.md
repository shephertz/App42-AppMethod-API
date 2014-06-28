App42-AppMethod-API

# Register and Create App

Here are the following steps to get started with App42 platform

* [Register](https://apphq.shephertz.com/register) with App42 platform.

* Create an app once you are on Quick-start page after registration.

* If you are already registered, login to [AppHQ](https://apphq.shephertz.com/register/app42Login) console and create an    app from App Manager -> App Create.

* Give default ACL permission, for example PUBLIC/READ or PUBLIC/WRITE or PUBLIC/ALL.

* Once App is created, you will get an ApiKey/SecretKey along with AdminKey that you will use in your app for  initialization of SDK.

# Download and Set up SDK

* [Download](https://github.com/shephertz/App42-AppMethod-API/archive/master.zip) AppMethod SDK

* Unzip downloaded Zip file. 

* Go to Component -> Install Package in the [AppMethod IDE](http://docwiki.appmethod.com/appmethod/1.13/topics/en/Install_Component)

* Click the "Add.." button, now you have to navigate to the unzip folder where the Package Library file (App42_AppMethod_Component.bpl) are found and click the 'Open' button to add the component package to the IDE. 

* Now the TApp42Provider component is added in BaaS Client category in Tool Pallete.

* Drag and Drop the TApp42Provider component in design view of App. Click on App42Provider1, now you can see the     Properties and events  in Object Inspector.

* Make sure to copy *.dcu/dcp file available in the dist folder of downloaded zip to your Delphi Library Path [See here for details](http://docwiki.embarcadero.com/RADStudio/XE6/en/Installing_Component_Packages).

* Set the property ApiKey/SecretKey/AdminKey that you have received while creating the App(in AppHQ console) in Object Inspector.

* Put the ApiVersion as 1.0 in object Inspector

* Now you are ready to use App42 services in your project.

