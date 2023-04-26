## Test documentation

This describes the testing framework for the data model. 
The different types of tests are organized by the subdirectory and are explained below.

### Test GENERATION of templates (:heavy_check_mark: IMPLEMENTED)

This means means checking expectations that:
1. Production templates can be generated at all with the version of `schematic` used. 
2. Production templates look as expected when created (e.g. all the attributes are there).

Failure to generate a template with a given version of `schematic` could mean:
- Version of `schematic` is too old and doesn't support whatever new validation rule/feature you just tried to incorporate in the model.
- Version of `schematic` is new and contains breaking changes that won't work with the current data model.
- There's a problem with the data model such as a missing key error, etc. 
- Some other part of the data model is incorrectly defined (e.g. dependent components) so the template now leads to a different set of attributes than intended.

#### Test fixtures

The fixtures needed are, of course, the data model, as well as the configuration to run, defined in `generate_config.json`.

### Test VALIDATION of manifests against their templates (:warning: TODO)

Question: Aren't the unit tests run by `schematic` sufficient to make sure that validation works as expected?
Answer: Not necessarily. It's very often that real-world manifest data look very strange and can break things unexpectedly, so try to increase coverage outside of the unit tests. 

This means checking expectations that:
1. Manifest data that should pass are indeed passed by `schematic`. Example issue: https://github.com/Sage-Bionetworks/schematic/issues/732
2. Manifest data that should fail are indeed caught by `schematic`. 

Issues in case #1 lead to a poor experience for data contributors, who wouldn't appreciate spurious validation errors. 
Issues in case #2 lead to letting bad data pass and are arguably worse.  

#### Test fixtures

In addition to the data model, some representative `.csv` manifests are needed. 
The file `validate_config.json` defines the matrix of which manifests should be tested with their respective templates.

### Test SUBMISSION of manifests (:warning: TODO)

> Note : This will be more complicated than the other two test suites combined.

This means checking that:
1. Valid manifests can be submitted at all. There have been cases where valid manifests have been unable to be submitted. 
2. Manifest data are transferred as expected to Synapse (e.g. no weird conversions of types or truncation of data). This requires querying the data that has been transferred to Synapse for comparison. Example issues: 
- Blank values in the manifest become "NA" -- https://github.com/Sage-Bionetworks/schematic/issues/733
- "NA" string value become `null` even though we may want to preserve "NA" -- https://github.com/Sage-Bionetworks/schematic/issues/821 + [internal thread](https://sagebionetworks.slack.com/archives/C01ANC02U59/p1681769606510569?thread_ts=1681769370.017039&cid=C01ANC02U59)


#### Test fixtures

This uses the same fixtures above plus a definition of what data should look like in Synapse. 



