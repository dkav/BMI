library(shiny)
source('bmi_gconst.R')

shinyUI(fluidPage(
  titlePanel('Calculate Body Mass Index (BMI) and Weight Class'),
  fluidRow(
    column(3, wellPanel(
      h4("Select Inputs"),
      br(),
      numericInput(inputId = "ht", label = "Height in Inches:", value = def_ht,
                  min = min_ht_range, max = max_ht_range, step = 1),
      verbatimTextOutput("height"), 
      br(), 
      numericInput(inputId ="wt", label = "Weight in Pounds:", value = def_wt,
                 min = min_wt_range, max = max_wt_range, step = 1),  
      verbatimTextOutput("weight"),
      br(), 
      actionButton("subButton", "Submit")
    )),
    column(8,
      h3("Inputs"),
      verbatimTextOutput("usrInputs"),
      hr(),
      h3("Results"),
      verbatimTextOutput("bmiResult"),
      br(),
      h4("Summary Plot"),
      plotOutput('plot1')      
    )
  )
))
