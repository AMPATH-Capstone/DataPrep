#
# AMAPTH Cost Calculator for Co-Op vs Clinic
# Shiny App Developers: Kelsey Cooper & William Nicholas
# SPEA-V 600: Capstone
#
#

library(shiny)
library(shinythemes)
shinyUI(
  fluidPage(theme = shinytheme("flatly"),
            navbarPage("AMPATH Cost Calculator",
              tabPanel("AMPATH Costs",
                       sidebarLayout(
                         sidebarPanel(
                           fluidRow(
                             h3("Clinic Costs"),
                             numericInput("cl_hrly_cost",
                                          "Healthcare worker hourly cost (KES)",
                                          value = 0),
                             numericInput("cl_num_appt",
                                          "Number of appointments per year per patient",
                                          value = 0),
                             numericInput("cl_min_appt",
                                          "Average minutes per appointment",
                                          value = 0),
                             numericInput("cl_fixed",
                                          "Fixed Costs per year (KES)",
                                          value = 0),
                             numericInput("cl_variable",
                                          "Variable Costs per patient (KES)",
                                          value = 0),
                             hr(),
                             h3("Co-op Costs"),
                             numericInput("coop_hrly_cost",
                                          "Healthcare worker hourly cost (KES)",
                                          value = 0),
                             numericInput("coop_num_appt",
                                          "Number of appointments per year",
                                          value = 0),
                             numericInput("coop_min_appt",
                                          "Average minutes per appointment",
                                          value = 0),
                             numericInput("coop_fixed",
                                          "Fixed Costs per year (KES)",
                                          value = 0),
                             numericInput("coop_variable",
                                          "Variable Costs per patient (KES)",
                                          value = 0),
                             hr(),

                           )),



                         mainPanel(
                           fluidRow(

                             # Show a plot of the costs
                             plotOutput("costAmpathPlot"),

                           ))
                       )),

              tabPanel("Patient Costs",
                       sidebarLayout(
                         sidebarPanel(
                           fluidRow(
                             h3("Patient Costs"),
                             numericInput("pt_min_cl",
                                          "Number of minutes to travel to the clinic (roundtrip)",
                                          value = 0),
                             numericInput("pt_min_coop",
                                          "Number of minutes to travel to the co-op (roundtrip)",
                                          value = 0),
                             numericInput("pt_wait_cl",
                                          "Number of minutes to wait at clinic for appointment",
                                          value = 0),
                             numericInput("pt_wait_coop",
                                          "Number of minutes to wait at the co-op for appointment",
                                          value = 0),
                             numericInput("pt_appt_time_cl",
                                          "Length of appointment time in minutes at clinic",
                                          value = 0),
                             numericInput("pt_appt_time_coop",
                                          "Length of appointment time in minutes at co-op",
                                          value = 0),
                             numericInput("pt_opp_cost",
                                          "Opportunity cost per hour (KES)",
                                          value = 0),

                             hr(),

                           )),



                         mainPanel(
                           fluidRow(

                             # Show a plot of the costs
                             plotOutput("costPatientPlot"),

                           ))
                       ))

            )))
