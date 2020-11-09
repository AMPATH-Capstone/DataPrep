#
# AMAPTH Cost Calculator for Co-Op vs Clinic
# Shiny App Developers: Kelsey Cooper & William Nicholas
# SPEA-V 600: Capstone
#
#

library(tidyverse)
library(RColorBrewer)
library(patchwork)
library(here)
library(ggmap)
library(ggplot2)
library(ggthemes)
library(reshape2)
library(shiny)
library(shinyalert)
library(markdown)
library(knitr)
library(dplyr)
library(shinythemes)

includeRmd <- function(path){
  contents <- paste(readLines(path, warn = FALSE), collapse = '\n')
  html <- knit2html(text = contents, fragment.only = TRUE, options=c("use_xhtml","smartypants","mathjax","highlight_code", "base64_images"))
  Encoding(html) <- 'UTF-8'
  HTML(html)
}


shinyUI(
  fluidPage(
    theme = shinytheme("flatly"),
    useShinyalert(),
    navbarPage("AMPATH Cost Calculator",
               tabPanel("About",
                        mainPanel(
                          includeRmd("www/index.rmd")
                        )),
               tabPanel("AMPATH Costs",
                        sidebarLayout(
                          sidebarPanel(
                            fluidRow(
                              h3("Clinic Annual Costs"),
                              numericInput("cl_clinicians",
                                           "Total Clinician Cost (USD)",
                                           value=0),
                              numericInput("cl_staff",
                                           "Total Staff Cost (USD)",
                                           value=0),
                              numericInput("cl_travel",
                                           "Total Travel Cost (USD)",
                                           value=0),
                              numericInput("cl_equipment",
                                           "Total Equipment Cost (USD)",
                                           value=0),
                              numericInput("cl_clinics",
                                           "Average number of active clinics",
                                           value=0),
                              numericInput("cl_patients",
                                           "Average number of patients by clinic",
                                           value=0),
                              hr(),
                              h3("Co-op Annual Costs"),
                              numericInput("coop_clinicians",
                                           "Total Clinician Cost (USD)",
                                           value=0),
                              numericInput("coop_staff",
                                           "Total Staff Cost (USD)",
                                           value=0),
                              numericInput("coop_travel",
                                           "Total Travel Cost (USD)",
                                           value=0),
                              numericInput("coop_equipment",
                                           "Total Equipment Cost (USD)",
                                           value=0),
                              numericInput("coop_clinics",
                                           "Average number of active co-ops",
                                           value=0),
                              numericInput("coop_patients",
                                           "Average number of patients by co-op",
                                           value=0),
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
                              h4("Clinic Time"),
                              numericInput("pt_min_cl",
                                           "Number of minutes to travel to the clinic (roundtrip)",
                                           value = 0),
                              numericInput("pt_wait_cl",
                                           "Number of minutes to wait at clinic for appointment",
                                           value = 0),
                              numericInput("pt_appt_time_cl",
                                           "Length of appointment time in minutes at clinic",
                                           value = 0),
                              h4("Co-Op Time"),
                              numericInput("pt_min_coop",
                                           "Number of minutes to travel to the co-op (roundtrip)",
                                           value = 0),
                              numericInput("pt_wait_coop",
                                           "Number of minutes to wait at the co-op for appointment",
                                           value = 0),
                              numericInput("pt_appt_time_coop",
                                           "Length of appointment time in minutes at co-op",
                                           value = 0),
                              h4("Opportunity Costs"),
                              numericInput("hourly_wage",
                                           "Wage per hour (KES)",
                                           value = 0),
                              numericInput("wrk_hr",
                                           "Work - Share of total hours missed",
                                           value = 0.00),
                              numericInput("fam_care",
                                           "Value of an hour of family care (KES)",
                                           value = 0),
                              numericInput("fam_hr",
                                           "Family care - Share of total hours missed",
                                           value = 0.00),
                              numericInput("school_hrs",
                                           "Value of an hour of school (KES)",
                                           value = 0.00),
                              numericInput("sch_hr",
                                           "School - Share of total hours missed",
                                           value = 0.00),
                              numericInput("inf_sales",
                                           "Value of an hour of informal sales (KES)",
                                           value = 0),
                              numericInput("inf_hr",
                                           "Informal sales - Share of total hours missed",
                                           value = 0.00),
                              numericInput("agr_losses",
                                           "Value of an hour of agricultural work (KES)",
                                           value = 0),
                              numericInput("ag_hr",
                                           "Agriculture - Share of total hours missed",
                                           value = 0.00),
                              numericInput("other",
                                           "Value of an hour of other opportunity costs (KES)",
                                           value = 0),
                              numericInput("ooc_hr",
                                           "Other - Share of total hours missed",
                                           value = 0),

                              hr(),

                            )),



                          mainPanel(
                            fluidRow(

                              # Show a plot of the costs
                              strong(h4("Calculation Plots")),
                              plotOutput("costPatientPlot"),
                              br(),
                              plotOutput("hoursPatientPlot"),
                              br(),
                              strong(h4("Comparison Plots from AMPATH ART Co-Op Study")),
                              plotOutput("costscatterplot"),
                              br(),
                              plotOutput("hoursscatterplot")
                            )),

                        ))
               )))

