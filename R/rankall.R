rankall <- function(outcome, num = "best") {
  
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # Rename columns
  names(data)[2] <- "hospital"
  names(data)[7] <- "state"
  names(data)[11] <- "heart attack"
  names(data)[17] <- "heart failure"
  names(data)[23] <- "pneumonia"
  
  ## Check that state and outcome are valid
  if (!(outcome %in% names(data)))
  {
    stop("invalid outcome")
  }
  
  data[, outcome] <- as.numeric(data[,outcome])
  data_per_state <- split(data, data$state)
  num_states <- length(data_per_state)
    
  rankhospital1 <- function(state)
  {
    ranked <- data_per_state[[state]][order(data_per_state[[state]][,outcome], data_per_state[[state]][,"hospital"], na.last = NA), ]
    nranked <- nrow(ranked)
    
    state.num <- num
    
    if (num == "best")
      state.num <- 1
    else if (num == "worst")
      state.num <- nranked
    
    ranked[state.num, "hospital"]
  }
  
  df <-data.frame(hospital = numeric(0), 
                  state = numeric(0))
  
  ## For each state, find the hospital of the given rank
  for (state in names(data_per_state))
  {
   df[state,] <- c(rankhospital1(state), state)
  }
  
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  df
}