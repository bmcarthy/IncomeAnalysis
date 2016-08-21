#'A Shiny App used to compare household income with market survey data.
#'
#'This Shiny App allows users to compare their household income with those
#'found in the Market Basket Analysis data from the ElemStatLearn package.
#' @author Blane McCarthy
#' @details The user can specify gender, employment category, education level,
#' and household income.  The app will then show how their income compares
#' with the market basket observations that match the criteria specified.

library(shiny)
library("ElemStatLearn")

shinyUI(fluidPage(
    # Application title

    titlePanel("Household Income Analysis"),

    tags$p("Choose your gender, employment category, education level,
and household income.  This Income Analysis app will then show how your
income compares with the market basket observations that match the
criteria you specified."),

    sidebarLayout(

    sidebarPanel(
      radioButtons(inputId = "Gender", label = h4("1. Select Your Gender"),
                   choices = list("Male" = 1,
                                  "Female" = 2),
                             selected = 1),

      selectInput(inputId = "Occupation", label = h4("2. Select Your Occupational Category"),
                   choices = list(" " = 0,
                                  "Professional/Managerial" = 1,
                                  "Sales Worker" = 2,
                                  "Factory Worker/Laborer/Driver" = 3,
                                  "Clerical/Service Worker" = 4,
                                  "Homemaker" = 5,
                                  "Student, HS or College" = 6,
                                  "Military" = 7,
                                  "Retired" = 8,
                                  "Unemployed" = 9),
                              selected = 0),

      selectInput(inputId = "EdLevel", label = h4("3. Select Your Education Level"),
                    choices = list(" " = 0,
                                   "Grade 8 or less" = 1,
                                   "Grades 9 to 11" = 2,
                                   "Graduated high school" = 3,
                                   "1 to 3 years of college" = 4,
                                   "College graduate" = 5,
                                   "Grad Study" = 6),
                              selected = 0),

      sliderInput(inputId = "Income", label = h4("4. Enter Your Current Income"),
                  min = 0, max = 100000, value = 1000, step = 1000)

    ),

    mainPanel(
      h3('Results of Analysis'),
#      h4('You entered a gender of '),
#      verbatimTextOutput(outputId = "inputGender"),
#      h4('You entered an Occupation of '),
#      verbatimTextOutput(outputId = "inputOccupation"),
#      h4('You entered an education level of '),
#      verbatimTextOutput(outputId = "inputEdLevel"),
      h4('You entered an income of '),
      verbatimTextOutput(outputId = "inputIncome"),
      h4('Which resulted in an income rating of '),
      verbatimTextOutput(outputId = "inputIncRate"),
      plotOutput('newHist')
    )
  )
))
