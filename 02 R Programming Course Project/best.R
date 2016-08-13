best <- function(state, outcome){
        ## Read outcome data
        
        data <- read.csv("outcome-of-care-measures.csv",colClasses = "character")
        
        ## Check that state and outcome are valid
        
        # Extract valid states from data
        states.vect <- unique(data$State)
        # Define valid outcomes
        outcomes.vect <- c("heart attack","heart failure","pneumonia")
        # Check state
        if (!any(state==states.vect)) stop("invalid state")
        # Check outcome
        if (!any(outcome==outcomes.vect)) stop("invalid outcome")
       
        ## Return hospital name in that state with lowest 30-day death rate
        
        # Calculate minima of the corresponding outcome and find best hospital
        if (outcome=="heart attack"){
                # Subset data by state dropping NAs in outcome column
                numoutcome <- suppressWarnings(as.numeric(data[,11]))
                data <- data[data$State==state&!is.na(numoutcome),]
                # Calculate min value in outcome column
                minval <- min(as.numeric(data[,11]))
                # Find best hospital(s)
                best <- data$Hospital.Name[as.numeric(data[,11])==minval]
        }
        else if (outcome=="heart failure"){
                # Subset data by state dropping NAs in outcome column
                numoutcome <- suppressWarnings(as.numeric(data[,17]))
                data <- data[data$State==state&!is.na(numoutcome),]
                # Calculate min value in outcome column
                minval <- min(as.numeric(data[,17]))
                # Find best hospital(s)
                best <- data$Hospital.Name[as.numeric(data[,17])==minval]
        }
        else{
                # Subset data by state dropping NAs in outcome column
                numoutcome <- suppressWarnings(as.numeric(data[,23]))
                data <- data[data$State==state&!is.na(numoutcome),]
                # Calculate min value in outcome column
                minval <- min(as.numeric(data[,23]))
                # Find best hospital(s)
                best <- data$Hospital.Name[as.numeric(data[,23])==minval]
        }
        # Handling ties
        if (length(best)>1){
                sort(best)
        }
        # Return result
        best[1]
}