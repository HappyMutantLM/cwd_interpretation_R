# Main.R
#
#   High level script
#       * load data
#       * extract features from signals
#       * run ML algorithms on features
#       * plot (and save) results (ROC curves)
#
#   Modified: 22 Feb 2024

## User-controlled parameters for ML

# Data parameters
load_data <- TRUE  # Read data from folder
augment_data <- FALSE  # Data augmented by chopping samples into subsamples
flag_save <- FALSE  # Whether images/results are saved
results_name <- "test"  # Name you want results to be saved as

# ML Parameters
ML_types <- c("knn", "svm", "bayes")  # List of ML algorithms
ListOfFeatures <- c("fhi", "power", "RDTR", "RMTR")  # List of features
NumOfCVFolds <- 10
TrainTestSplitPercentage <- 100

RNG_seed <- 1  # Random number generator seed for reproducibility

## Load Data
source("LoadData.R")  # Assuming LoadData.R contains code to load data

if (load_data) {
    LoadData()  # Function to load data
}

## Set up system variables
results_name <- paste("Results/", results_name, sep = "")
ML_params <- list(NumOfCVFolds = NumOfCVFolds, TrainTestSplitPercentage = TrainTestSplitPercentage)

## Extracting and Plotting of Results
source("getROCResults.R")  # Assuming getROCResults.R contains code to obtain ROC results

myML <- getROCResults(ListOfFeatures, ML_types, myData, results_name, RNG_seed, ML_params, flag_save)
# todo???: script called makeROCStruct <-- Results_cv, Results_train, etc....
source("makeROCPlots.R")  # Assuming makeROCPlots.R contains code to make ROC plots

makeROCPlots(results_name, myML$Results_train, myML$Results_cv, flag_save)
