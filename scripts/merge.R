# These scripts should be run in /data-model root

#' Merge imports and main
#' 
merge <- function(imports = "imports/",
                  main = "main/",
                  config = "merge.yml",
                  out_file = "GF.csv") {
  imports <- compileFiles(imports)
  main <- compileFiles(main)
  model <- rbind(imports, main)
  model <- processMerge(model, config)
  fwrite(model, out_file)
  invisible(model)
}

compileFiles <- function(dir) {
  data <- lapply(list.files(dir, full.names = T), fread)
  data <- rbindlist(data)
  return(data)
}

processMerge <- function(model, config) {
  config <- yaml::read_yaml(config)
  for(i in seq_along(config$Merge)) {
    model <- mergeEach(model,
                       config$Merge[[i]]$from,
                       config$Merge[[i]]$to)
  }
  return(model)
}

# 
mergeEach <- function(model, mod_from, mod_to) {
  terms_from <- paste0(model[Parent == mod_from, Attribute], collapse = ",")
  terms_to <- model[Attribute == mod_to, DependsOn]
  terms_merged <- paste0(terms_to, terms_from, collapse = ",")
  model[Attribute == mod_to, DependsOn := terms_merged]
  return(model)
}

