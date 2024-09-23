###############################################################
###
### SGP analysis script
###
###############################################################

### Load packages
require(SGP)

### Load data
load("Data/Delaware_Data_LONG.Rdata")

### Parameters
parallel.config <- list(BACKEND="PARALLEL", WORKERS=list(TAUS=4, SIMEX=4, PROJECTIONS=4, PERCENTILES_BASELINE=4, LAGGED_PROJECTIONS=4, SGP_SCALE_SCORE_TARGETS=4))

### Configurations
source("SGP_CONFIG/2019/ELA.R")
source("SGP_CONFIG/2019/MATHEMATICS.R")
source("SGP_CONFIG/2023/ELA.R")
source("SGP_CONFIG/2023/MATHEMATICS.R")

DE_Config <- c(ELA_2019.config, MATHEMATICS_2019.config, ELA_2023.config, MATHEMATICS_2023.config)

### abcSGP
Delaware_SGP <- abcSGP(
                    sgp_object=Delaware_Data_LONG,
                    steps=c("prepareSGP", "analyzeSGP", "combineSGP", "summarizeSGP", "visualizeSGP", "outputSGP"),
                    years=c("2023"),
                    sgp.percentiles=TRUE,
                    sgp.projections=TRUE,
                    sgp.projections.lagged=TRUE,
                    sgp.percentiles.baseline=FALSE,
                    sgp.projections.baseline=FALSE,
                    sgp.projections.lagged.baseline=FALSE,
                    sgPlot.demo.report=TRUE,
                    sgp.config=DE_Config,
                    calculate.simex=TRUE,
                    parallel.config=parallel.config)

### Save results
save(Delaware_SGP, file="Data/Delaware_SGP.Rdata")
