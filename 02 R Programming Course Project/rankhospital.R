rankhospital <- function(state, outcome, num = "best"){
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
       
        ## Return hospital name in that state with the given rank
        ## 30-day death rate
        
        # Order data with tie handling
        if (outcome=="heart attack"){
                # Subset data by state dropping NAs in outcome column
                numoutcome <- suppressWarnings(as.numeric(data[,11]))
                data <- data[data$State==state&!is.na(numoutcome),]
                # Order data by 30-day death rate and alphabetical name
                data <- data[order(as.numeric(data[,11]),data$Hospital.Name),]
        }
        else if (outcome=="heart failure"){
                # Subset data by state dropping NAs in outcome column
                numoutcome <- suppressWarnings(as.numeric(data[,17]))
                data <- data[data$State==state&!is.na(numoutcome),]
                # Order data by 30-day death rate and alphabetical name
                data <- data[order(as.numeric(data[,17]),data$Hospital.Name),]
        }
        else{
                # Subset data by state dropping NAs in outcome column
                numoutcome <- suppressWarnings(as.numeric(data[,23]))
                data <- data[data$State==state&!is.na(numoutcome),]
                # Order data by 30-day death rate and alphabetical name
                data <- data[order(as.numeric(data[,23]),data$Hospital.Name),]
        }
        # Find hospital with given rank
        if (num=="best") rankhospital <- data$Hospital.Name[1]
        else if (num=="worst") rankhospital <- data$Hospital.Name[nrow(data)]
        else if (num>nrow(data)) rankhospital <- NA
        else rankhospital <- data$Hospital.Name[num]

        # Return result
        rankhospital
}