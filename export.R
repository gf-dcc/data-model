# Write clinical attributes list
# model <- merge()
# attributeList(model, modules = readLines("clinical_modules"), filename = "clinical_attributes.csv")

#' Export attribute list
#' 
#' Get a flat list of attributes and their types by specific module(s).
#' This is currently used to get clinical module attributes
#' for downstream processing, e.g. matching of attributes in intake data
attributeList <- function(model,
                          modules = NULL, 
                          filename = NULL) {
  attributes <- model[Parent %in% modules, .(Attribute, `Valid Values`)]
  attributes <- attributes[, .(Attribute, Type = typeClass(Attribute, `Valid Values`))]
  attributes <- attributes[order(Attribute)]
  if(is.null(filename)) attributes else fwrite(attributes, filename)
}

#' `a` is attribute name while `v` is valid values
typeClass <- function(as, vs) {
  eachAttribute <- function(a, v) {
    v <- trimws(strsplit(v, ",")[[1]])
    if("Yes" %in% v || "true" %in% v) {
      "boolean"
    } else if(grepl("date|year", a, ignore.case = TRUE)) {
      "date"
    } else if(grepl("^age|number", a, ignore.case = TRUE)) {
      "numeric"
    } else {
      "character"
    }
  }
  Map(eachAttribute, as, vs)
}
