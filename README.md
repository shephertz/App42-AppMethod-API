App42-AppMethod-API
===================

App42 APIs for AppMethod

1. Unzip the downloaded folder.
2. Open App42REST.groupproj in Rad Studio.
3. Compile and install the ___dclRESTBackendComponentsApp42200.bpl___.
4. Compile and install the ___dclRESTBackendComponentsApp42.bpl___.
5. Now the TApp42Provider component is installed in BAAS Client category in Tool Pallete.
6. Drag and Drop the TApp42Provider component in design view of App.
8. Set the Credentials in ___Object Inspector___.
7. Put the ApiVersion as ___1.0___ and register with [AppHQ] (http://apphq.shephertz.com/register/app42Login) for ___API_KEY___ and ___SECRET_KEY___.
8. Select the provider as ___App42Provider1___ for the backend service component(i.e TBackendUsers).


**ACL USAGE**

For using ACL, Just make a TJSONObject or Json String and pass the key value pairs as described below. 
```
{"PUBLIC":"R", "PUBLIC":"W"}  // for giving the Read and Write Permission to Public (PUBLIC must be in caps).

{"PUBLIC":"R", "elmo":"W", "elmo":"R"}  // for giving the Read Permission to Public and Read/Write for user elmo.

{"elmo":"W", "elmo":"R"}  // Private Document for user elmo.
```
