time <- TRUE
space <- function(state) {
  state
}

advance <- function(state) {
  if (!time) {
    return(space(state))
  }

  state
}

protocol <- function(state) {
  advance(state)
}
