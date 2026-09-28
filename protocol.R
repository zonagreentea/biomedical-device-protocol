protocol <- function() {
  # your program here
}

jump <- function(error) {
  # what happens if something goes wrong
}

tryCatch(
  protocol(),
  error = jump
)
