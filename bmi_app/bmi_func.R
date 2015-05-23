# Calculate BMI - Height in inches and weight in pounds
bmi <- function(ht, wt) {
  bmi <- (wt / (ht^2)) * 703
  return (bmi)
}
