## This function creates a special "matrix" object (environment)
## that stores matrix and its inverse
## That object has the following functionalities:
## 1. set the value of the matrix
## 2. get the value of the matrix
## 3. set the value of the inverse
## 4. get the value of the inverse
## Function set() invalidates the previously cached inverse 

makeCacheMatrix <- function(x = matrix()) {
    inv <- NULL
    set <- function(y) {
    x <<- y
    inv <<- NULL
  }
  get <- function() x
  setinverse <- function(inverse) inv <<- inverse
  getinverse <- function() inv
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}


## This function returns the inverse of the matrix stored in the object x
## If x has a non-null value of inverse (the cache), it returns the cached value;
## otherwise it calculates the inverse and caches its value in the object x

cacheSolve <- function(x, ...) {
  inv <- x$getinverse() # look for the cached inverse
  if(!is.null(inv)) {
    message("getting cached data")
    return(inv)
  }
  data <- x$get() # get the matrix
  inv <- solve(data, ...) # solve it (calculate inverse)
  x$setinverse(inv) # cache inverse 
  inv
}
