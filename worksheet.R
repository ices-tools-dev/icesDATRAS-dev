
# some exploration
library(devtools)

# install local versions of icesDATRAS and dtu-aquas DATRAS
install("icesDATRAS")
install("DATRAS/DATRAS")


## from DATRAS/DATRAS/demo/intro.R


require(DATRAS)

## Example file
zipfile <- system.file("exchange","Exchange1.zip", package="DATRAS")

## Step 1. Read exchange data into R
d <- readExchange(zipfile)

# d is just a list of CA, HL and HH - we can reproduice the same using:

ca <- icesDatras::getDATRAS("CA", survey = "NS-IBTS", years = 2009, quarters = 1)
hh <- icesDatras::getDATRAS("HH", survey = "NS-IBTS", years = 2009, quarters = 1)
hl <- icesDatras::getDATRAS("HL", survey = "NS-IBTS", years = 2009, quarters = 1)

d <- list(CA = ca, HH = hh, HL = hl)
cat("Classes of the variables\n")
print(lapply(d2, function(x) sapply(x, class)))
## Inconsistencies with variable names are resolved here
## =====================================================
## Ices-square variable should have the same name ("StatRec") in age and hydro data.
if (is.null(d[[1]]$StatRec)) d[[1]]$StatRec <- d[[1]]$AreaCode
d <- addExtraVariables(d)
d <- fixMissingHaulIds(d, strict = TRUE)
class(d) <- "DATRASraw"

str(d, 1)


## Step 2. Preprocess the data
## -Take subset
## -Add size spectrum
d <- subset(d,lon>10,Species=="Gadus morhua")
d <- addSpectrum(d)
d <- addNage(d,2:4)

## Step 3. Convert to data.frame with one line for each response.
df <- as.data.frame(d,response="Nage")




