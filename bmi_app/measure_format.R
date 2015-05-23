# Functions to format input measures

# Convert inches to feet and inches
footinch_formatter <- function(x) {
  foot <- floor(x/12)
  inch <- x %% 12
  return(paste(foot, "ft", inch, "inches", sep = " "))
}

# Convert pounds to stone and pounds
stonepound_formatter <- function(x) {
  stone <- floor(x/14)
  pound <- x %% 14
  return(paste(stone, "stone", pound, "pounds", sep = " "))
}