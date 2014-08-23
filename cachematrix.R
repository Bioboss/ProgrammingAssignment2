# This set of functions can be used to obtain the inverse matrix of an 
# invertable matrix. However, to save repeated computation of the same matrix
# the first time a matrix is been inverted, the results are stored in the cache

# This first function creates a list containing variables wich represents 
# functions able to access either the matrix that are to be inverted or the 
# inverted matrix
makeCacheMatrix <- function(x = matrix()) {
        # The matrix have just been crated and potential leftover from previous
        # calls of the function is erased by setting the invers matris to null
        inverse <- NULL
        
        # The following three functions are not activated when makeCacheMatrix()
        # is called. These will be used by casheSolve()
        
        # This function returns the original matrix
        get <- function() {
                x
        }
        # This function is called by casheSolve() the first time the inverse 
        # matrix is evaluated
        setInverse <- function(i) {
                inverse <<- i
        }
        # This function returns a cached inverted matrix when called by 
        # casheSolve()
        getInverse <- function() {
                inverse
        }
        
        # The output of makeCascheMatrix is a list 
        list(get = get, setInverse = setInverse, getInverse = getInverse)

}


# The second function investigates if an inverse matrix is already determined 
# If not, the inverse matrix is computed. Else, it is fetched from the cashe

cacheSolve <- function(x, ...) {
        # Access the list object x and fech the inverse matrix
        i <- x$getInverse()
        
        # If the inverse matrix has not been determined the value is null
        if (!is.null(i)) {
                # The inverse matrix is found and returned to the user
                message("getting cached data")
                return(i)
                # Function stops
        }
        # The matrix is found in the list object x and the inverse is determined
        # and stored
        m <- x$get()
        
        # Something wrong with solve
        i <- solve(m, ...)
        x$setInverse(i)
        
        # Finally, the inverse matrix is returned
        i        
}
