

CreateVocabTables <- function(connectionDetails,
                            cdmSchema,
                            syntheaSchema,
                            cdmVersion,
                            syntheaVersion = "2.7.0",
                            cdmSourceName = "Synthea synthetic health database",
                            cdmSourceAbbreviation = "Synthea",
                            cdmHolder = "OHDSI",
                            cdmSourceDescription = "SyntheaTM is a Synthetic Patient Population Simulator. The goal is to output synthetic, realistic (but not real), patient data and associated health records in a variety of formats.",
                            sqlOnly = FALSE)
{
  # Determine which sql scripts to run based on the given version.
  # The path is relative to inst/sql/sql_server.
  if (cdmVersion == "5.3") {
    sqlFilePath <- "cdm_version/v531"
  } else if (cdmVersion == "5.4") {
    sqlFilePath <- "cdm_version/v540"
  } else {
    stop("Unsupported CDM specified. Supported CDM versions are \"5.3\" and \"5.4\".")
  }
  
  supportedSyntheaVersions <- c("2.7.0", "3.0.0")
  
  if (!(syntheaVersion %in% supportedSyntheaVersions))
    stop("Invalid Synthea version specified. Currently \"2.7.0\" and \"3.0.0\" are supported.")
  
  # Create Vocabulary mapping tables
  CreateVocabMapTables(connectionDetails, cdmSchema, cdmVersion, sqlOnly)
  
  # Perform visit rollup logic and create auxiliary tables
  CreateVisitRollupTables(connectionDetails,
                          cdmSchema,
                          syntheaSchema,
                          cdmVersion,
                          sqlOnly)
  
}


