best <- function(state, outcome) {
  
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

  # Rename columns
  names(data)[11] <- "heart attack"
  names(data)[17] <- "heart failure"
  names(data)[23] <- "pneumonia"
  
  data_per_state <- split(data, data$State)
  
  ## Check that state and outcome are valid
  if (!(state %in% names(data_per_state)))
  {
    stop("invalid state")
  }
  
  if (!(outcome %in% names(data)))
  {
    stop("invalid outcome")
  }
  
  data[, outcome] <- as.numeric(data[,outcome])
  
  state_data <- data[data[,"State"] == state,]   
  outcomes <- state_data[,outcome]
  
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  
  best_outcomes <- which(outcomes == min(outcomes, na.rm=TRUE))
  names <- state_data[c(best_outcomes), 2]
  min(names)
}

