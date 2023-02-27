## Test documentation

This describes the testing framework for the data model. 
The different types of tests are organized by the subdirectory and are explained below.

### Test generation of templates

This means means checking expectations that:
1. Production templates can be generated at all with the version of `schematic` used. 
2. Production templates look as expected when created (e.g. all the attributes are there).

Issues in case #1 could mean using an old version of version of `schematic` that doesn't support new rules, there is a problem with the data model such as a missing key error, etc. 
Issues in case #2 could mean changes in template definitions inadvertently led to a different set of attributes than intended for the template.

#### Test fixtures

The fixtures needed are, of course, the data model, as well as the configuration to run, defined in `generate_config.json`.

### Test validation of manifests against their templates

This means checking expectations that:
1. Manifest data that should pass are indeed passed by `schematic`.
2. Manifest data that should fail are indeed caught by `schematic`. 

Issues in case #1 lead to a poor experience for data contributors, who wouldn't appreciate spurious validation errors. Issues in case #2 lead to bad data.  

#### Test fixtures

In addition to the data model, some representative `.csv` manifests are needed. 
The file `validate_config.json` defines the matrix of which manifests should be tested with their respective templates.

### Test submission of manifests (TO DO)

> Note : This will be more complicated than the other two test suites combined.

This means checking that:
1. Valid manifests can be submitted at all. There have been cases where valid manifests have been unable to be submitted. 
2. Manifest data are transferred correctly to Synapse (e.g. no weird conversions of types or truncation of data). This requires querying the test data that has been transferred to Synapse.

#### Test fixtures

This uses the same fixtures above plus a definition of what data should look like in Synapse. 



