# Getting started

How to care for the data model and do important basic operations with the schematic CLI!

For quick and reproducible workflow, this guide is based on devcontainers, which:
- Should have the correct version of schematic installed with the schematic `config.yml` in the repository.
- Has all the creds you need.

In upper menu button, **Code > Create codespace on main**. 
You may need to wait a bit for the container to install tools and finish other setup.

## Update the data model jsonld

1. Modify a `.yaml` file in the `modules` directory.
2. In the devcontainer at the root of the repo, type `make`. Animation of what it should look like:

![make demonstration](docs/make.gif)

## Generate a template

This is the command-line equivalent of using the schematic API or using the DCA UI to generate a template.

1. For generating templates, you need creds. You only need to do this once when starting up a new codespace. Run this simple bash script at the codespace command line: `./scripts/setup_creds.sh`. You should see a `creds.json` and `.synapseConfig` file at the root of the repo, next to the `.jsonld` file. Locally, we can keep these files around but .gitignore them so they are **not committed to the repo**. Also, for local use, you may want to set up `.synapseConfig` using your own credentials. Feel free to skim the bash script and creds files.

2. Generate a blank Excel template for e.g. scRNAseq-Level1: `./scripts/gen_template.sh ImagingLevel2`. This generates an Excel template by default. Try replacing with another template ID. Try also copy-pasting contents of the script to the command-line to run schematic command natively, replacing variables as needed.

TODO - adapt script to allow these steps @cconrad8

3. Generate a blank Google template.

4. Generate a *filled-in* Google or Excel template for existing files on Synapse. An example for where this would apply is the public ScRNA-seqLevel1 dataset `syn26560315`.

 
## Validate a manifest

Note: this does not require creds setup, so you do not need `creds.json file` present.

1. Make sure you have config.yml and your data model in the working directory. Basically this should work as long as you're at the root of this repo.
2. Make sure that the schematic version you have installed works with the config.
3. Run example: `schematic model --config ./config.yml validate -mp ./tests/validate/examples/my_cohort.csv -dt CohortCoreTemplate`

Exercise: Replace `./my_cohort.csv` with the path to another manifest file and 'CohortCoreTemplate' with the id to another template as needed.

## Submit a manifest



