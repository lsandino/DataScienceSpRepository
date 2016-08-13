rankall <- function(outcome, num = "best"){
        ## Read outcome data
        
        data <- read.csv("outcome-of-care-measures.csv",colClasses = "character")
        
        ## Check that outcome is valid
        
        # Define valid outcomes
        outcomes.vect <- c("heart attack","heart failure","pneumonia")
        # Check outcome
        if (!any(outcome==outcomes.vect)) stop("invalid outcome")
        
        ## For each state, find the hospital of the given rank
        
        # Initialize auxiliary list
        rank.states <- sapply(sort(unique(data$State)),function(x) NULL)
        
        # Loop through states
        for(i in sort(unique(data$State))){
                # Order data with tie handling
                if (outcome=="heart attack"){
                        # Subset data by state dropping NAs in outcome column
                        numoutcome <- suppressWarnings(as.numeric(data[,11]))
                        subdata <- data[data$State==i&!is.na(numoutcome),]
                        # Order data by 30-day death rate and alphabetical name
                        subdata <- subdata[order(as.numeric(subdata[,11]),subdata$Hospital.Name),]
                        # Save hospital rank in auxiliary list
                        rank.states[[i]] <- subdata$Hospital.Name
                }
                else if (outcome=="heart failure"){
                        # Subset data by state dropping NAs in outcome column
                        numoutcome <- suppressWarnings(as.numeric(data[,17]))
                        subdata <- data[data$State==i&!is.na(numoutcome),]
                        # Order data by 30-day death rate and alphabetical name
                        subdata <- subdata[order(as.numeric(subdata[,17]),subdata$Hospital.Name),]
                        # Save hospital rank in new data frame
                        rank.states[[i]] <- subdata$Hospital.Name
                }
                else{
                        # Subset data by state dropping NAs in outcome column
                        numoutcome <- suppressWarnings(as.numeric(data[,23]))
                        subdata <- data[data$State==i&!is.na(numoutcome),]
                        # Order data by 30-day death rate and alphabetical name
                        subdata <- subdata[order(as.numeric(subdata[,23]),subdata$Hospital.Name),]
                        # Save hospital rank in new data frame
                        rank.states[[i]] <- subdata$Hospital.Name
                }
        }
        
        # Create data frame given rank
        if (num=="best") rankall <- data.frame("hospital"=unlist(lapply(rank.states,function(x) x[1])),"state"=names(rank.states))
        else if (num=="worst") rankall <- data.frame("hospital"=unlist(lapply(rank.states,function(x) x[length(x)])),"state"=names(rank.states))
        else rankall <- data.frame("hospital"=unlist(lapply(rank.states,function(x) x[num])),"state"=names(rank.states))
        
        # Return result
        rankall
}