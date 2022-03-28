# These scripts should be run in /data-model root

#' Wrapper to refresh import assets
#' reImport()
reImport <- function(config = "imports.yml", 
                     model = "https://raw.githubusercontent.com/ncihtan/data-models/main/HTAN.model.csv") {
  config <- yaml::read_yaml(config)
  model <- importCsvModel(model, config, genericizeIds)
  # Write imports
  writeImports(model)
  invisible(model)
}

#' Imports a schematic-specified csv model based on config
#' 
#' @param model Path to a readable csv model file.
#' @param config A list config.
#' @param custom_fun Custom function to apply 
importCsvModel <- function(model, config, custom_fun = NULL) {
  model <- fread(model)
  # modules are assumed to be grouped
  model_out <- importModules(model, unlist(config$Imports))
  model_out <- pruneModel(model_out, config$SchemaIgnore)
  if(!is.null(custom_fun) && is.function(custom_fun)) {
    custom_fun(model_out)
  }
  model_out
}

#' Import modules by extracting from model
#' 
#' @param model A model as data.table.
#' @param modules Module names refer to "parent" in schematic specification
importModules <- function(model, modules) {
  imports <- model[Parent %in% modules]
  return(imports)
}

#' Explicitly prune modules terms
#' 
#' @inheritParams importModules
#' @param terms Term names to prune
pruneModel <- function(model, terms) model[!Attribute %in% terms]

#' Genericize ids by replacing the consortium-specific nomenclature
genericizeIds <- function(dt) {
  # Replace HTAN mentions with more generic Atlas term 
  dt[, Attribute := gsub("HTAN", "Atlas", Attribute)]
  dt[, DependsOn := gsub("HTAN", "Atlas", DependsOn)]
  dt[, Description := gsub("HTAN", "", Description)]
}

#' Write import files to the (default) imports/ directory
writeImports <- function(model, path = "imports/") {
  modules <- split(model, by = "Parent")
  for(i in names(modules)) {
    fwrite(modules[[i]], file = paste0(path, i, ".csv"))
  }
}
