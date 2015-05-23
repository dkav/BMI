# BMI Weight Categories Config

# Weight cutoffs and categories
wt_uw_cut <- 18.5  # Underweight cutoff
wt_ov_cut <- 25    # Overweight cutoff
wt_cuts <- c(-Inf, wt_uw_cut, wt_ov_cut, Inf)  # Weight cuts
wt_cat <- c("Underweight", "Normal", "Overweight")  # Weight categories

bmi_cat <- data.frame(cat_start = c(min_BMI, wt_uw_cut, wt_ov_cut), 
                      cat_end = c(wt_uw_cut, wt_ov_cut, max_BMI), 
                      category = wt_cat)  # Data frame for plot areas

# BMI Weight Categories ggplot2 configuation
bmi_cat_rect <- geom_rect(data = bmi_cat, 
  mapping = aes(xmin = min_wt_range, 
                xmax = max_wt_range, 
                ymin = cat_start, 
                ymax = cat_end, 
                fill = category), 
  alpha = 0.4)

bmi_cat_fill <- scale_fill_manual(
  values = setNames(c("lightblue","white", "rosybrown2"), wt_cat),
  name = "Weight Class",
  breaks = wt_cat)
