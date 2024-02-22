# Adding dependencies
cat("Adding dependencies...")
source("Classes/DataSet.R")  # Assuming DataSet.R contains code to define DataSet class
source("Support Fcns/*")  # Assuming Support Fcns directory contains necessary R scripts
cat("...done!\n")

# Initialize the DataSet
myData <- DataSet(filePath = "data")

if (augment_data) {
    augDataSet <- myData$augment()
    myData <- augDataSet
}

# User-controlled Parameters
smoothing <- 3000
vis_type <- "patient"  # either patient or independent
plot_flag <- FALSE

# System Parameters
cat("Initializing system parameters...")
myData <- myData$updateIDStruct()
cat("...done!\n")

# Load all the currently available features
myData$getTemporalFeatures()
myData$getFrequencyFeatures()
# myData$getrawMFCC()
# myData$getrawFFT()
