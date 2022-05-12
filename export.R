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
  attributes <- model[Parent %in% modules, .(Attribute, Description, `Valid Values`, RequiredGF, Parent)]
  attributes <- attributes[, .(Attribute, 
                               Type = typeClass(Attribute, `Valid Values`),
                               Description = Description,
                               Values = `Valid Values`,
                               Required = RequiredGF,
                               Parent = Parent)]
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

#' Export required attributes only
#' 
getRequired <- function() {
  clin <- fread("clinical_attributes.csv")
  req <- clin[Required %in% c("Required", "Required_If_Available"), .SD, by = "Parent"]
  req[Required == "Required_If_Available", Required := "Required_If_Available_Applicable"]
  fwrite(req, file = "required_recommended.csv")
  #req
}
  
