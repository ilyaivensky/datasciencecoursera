rankhospital <- function(state, outcome, num = "best") {
  
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # Rename columns
  names(data)[2] <- "name"
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

  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  
  ranked <- state_data[order(state_data[,outcome], state_data[,"name"], na.last = NA), ]
  nranked <- nrow(ranked)
  
  if (num == "best")
    num <- 1
  else if (num == "worst")
    num <- nranked
  
  ranked[num, "name"]
}