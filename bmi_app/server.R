library(shiny)
library(ggplot2)

source('bmi_gconst.R')
source('bmi_wtcat.R')
source('bmi_func.R')
source('measure_format.R')
  
shinyServer(function(input, output, session) {  
  # Present alternative weight and heights display
  output$height <- renderText({footinch_formatter(input$ht)})
  output$weight <- renderText({stonepound_formatter(input$wt)}) 
  
  # Calculate input BMI
  cur_bmi <- reactive({
    cur_bmi <- bmi(input$ht, input$wt)
  })
    
  # Display inputs
  output$usrInputs <- renderText({ 
    if (input$subButton == 0)
      return()
    
    isolate({
      wt_category <- wt_cat[findInterval(cur_bmi(), wt_cuts)]
      paste0("Input height is: ", input$ht, " inches",
             "\t Input weight is: ", input$wt, " pounds")
    })
  })
    
  # Calculate and display BMI
  output$bmiResult <- renderText({ 
    if (input$subButton == 0)
      return()
    
    isolate({
      wt_category <- wt_cat[findInterval(cur_bmi(), wt_cuts)]
      paste0("BMI is: ", round(cur_bmi(),2), 
             "\t\t\t Weight class is: ", wt_category)
    })
  })
    
  # Create plot
  output$plot1 <- renderPlot({  
    if (input$subButton == 0)
      return()
    
    isolate({
      # Create plot object
      plt <- ggplot(data.frame(x = c(min_wt_range, max_wt_range)))
      
      # Add BMI function
      plt <- plt + stat_function(fun = bmi, args = list(ht = input$ht), 
                                 aes(color = "BMI Curve"), na.rm = TRUE) +
            scale_colour_manual(values = c("black"), name = "", 
                                label=("BMI/Weight for\nSelected Height"))
        
      # Add BMI weight categories
      plt <- plt + bmi_cat_rect + bmi_cat_fill
      
      # Add individual BMI marker & its intersections
      plt <- plt + geom_segment(aes_string(x = input$wt, y = cur_bmi(), 
                                           xend = input$wt, yend = min_BMI),
                                lty = 2, color = "darkgrey") +
        geom_segment(aes_string(x = min_wt_range, y = cur_bmi(), 
                                xend = input$wt, yend = cur_bmi()), 
                     lty = 2, color = "darkgrey") +
        geom_point(aes_string(x = input$wt, y = cur_bmi()), size  = 4)
       
      # Add labels and define axis limits
      plt <- plt + xlab("Weight (pounds)") + ylab("BMI") + 
        xlim(min_wt_range, max_wt_range) + ylim(min_BMI, max_BMI)
      
      # Plot graph
      plt
   })
  })
  
})
