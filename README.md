# Gray Foundation Data Model

This repository hosts the data model used for the Gray Foundation project. 
The data model defines metadata that we collect for patients and data files, as templates that are created and validated the Data Curator App (see related section [Updating DCA configuration](#Updating-DCA-configuration)).

## Development

We use a branching model for development of the source. 
Create a branch starting with `dm/**` to make changes in one of the files in `modules`, then submit a pull request.
This will run some automated checks and "compile" the full model files (`.csv` and `.jsonld`).

### Using the LinkML framework

For now, please reference [the docs in our sister DCC repo](https://github.com/nf-osi/nf-metadata-dictionary/#data-model-framework) to understand the LinkML framework and files.

### Updating DCA configuration

The `dca-template-config.json` defines which templates in the data model can be generated through the Data Curator App. 
If you've cooked up a new template that's ready for production, you will need to add it to the menu through updating this file. 
This will make sure that:
- It shows up in the DCA menu. 
- Continuous integration tests are run for this template; if a change breaks a user-facing template, it show up in the test for the pull request.

## External comments, questions, contributions

For questions and suggestions please submit an issue. 





