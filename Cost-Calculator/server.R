#
# AMAPTH Cost Calculator for Co-Op vs Clinic
# Shiny App Developers: Kelsey Cooper & William Nicholas
# SPEA-V 600: Capstone
#
#


library(ggplot2)
library(ggthemes)
library(reshape2)
library(shiny)
library(shinyalert)
library(markdown)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  shinyalert(
    title = "Disclaimer",
    text = "This application is intended for informational, educational, and research purposes only. It does not represent specific AMPATH costs, patient costs, or other HIV treatment information.


        To find out more about this app, please read the About section of this site.",
    closeOnEsc = TRUE,
    closeOnClickOutside = TRUE,
    html = TRUE,
    type = "info",
    showConfirmButton = TRUE,
    showCancelButton = FALSE,
    confirmButtonText = "OK",
    confirmButtonCol = "#AEDEF4",
    timer = 0,
    imageUrl = "",
    animation = TRUE
  )
  output$costAmpathPlot <- renderPlot({
    ptcount <- c(1:500)
    cta <-
      data.frame(
        cta_cl <- ptcount*(((input$cl_clinicians+input$cl_staff+input$cl_travel+input$cl_equipment)/input$cl_clinics)/input$cl_patients),
        cta_cp <- ptcount*(((input$coop_clinicians+input$coop_staff+input$coop_travel+input$coop_equipment)/input$coop_clinics)/input$coop_patients),
        ptcount
      )
    cta2 <- melt(cta, id="ptcount")
    ggplot(data=cta2,
           aes(x=ptcount, y=value, color=variable)) +
      theme(plot.title = element_text(color="black", size=14, face="bold"),
            axis.title.x = element_text(color="black", size=12, face="bold"),
            axis.title.y = element_text(color="black", size=12, face="bold"),
            panel.background = element_rect(fill="white"),
            panel.grid.major = element_line(size = 0.5,
                                            linetype = 'solid',
                                            colour = "grey"),
            panel.grid.minor = element_line(size = 0.25,
                                            linetype = 'solid',
                                            colour = "grey")) +
      labs(x="Number of Patients", y="Annual Cost (USD)") +
      geom_line(size=2) +
      ggtitle("Annual AMPATH Costs by Treatment Model") +
      scale_color_gdocs(
        name="Treatment Model",
        labels=c("Clinic", "Co-Op"))

  })

  output$costPatientPlot <- renderPlot({
    pt_num_appt <- c(1:10)

    ctp <-
      data.frame(
        ctp_cl <- (pt_num_appt*(((input$pt_min_cl+input$pt_wait_cl+input$pt_appt_time_cl)/60)*((input$hourly_wage*input$wrk_hr)+(input$agr_losses*input$ag_hr)+(input$school_hrs*input$sch_hr)+(input$fam_care*input$fam_hr)+(input$inf_sales*input$inf_hr)+(input$other*input$ooc_hr)))),
        ctp_cp <- (pt_num_appt*(((input$pt_min_coop+input$pt_wait_coop+input$pt_appt_time_coop)/60)*((input$hourly_wage*input$wrk_hr)+(input$agr_losses*input$ag_hr)+(input$school_hrs*input$sch_hr)+(input$fam_care*input$fam_hr)+(input$inf_sales*input$inf_hr)+(input$other*input$ooc_hr)))),
        pt_num_appt
      )
    ctp2 <- melt(ctp, id="pt_num_appt")
    ggplot(data=ctp2,
           aes(x=pt_num_appt, y=value, color=variable)) +
      theme(plot.title = element_text(color="black", size=14, face="bold"),
            axis.title.x = element_text(color="black", size=12, face="bold"),
            axis.title.y = element_text(color="black", size=12, face="bold"),
            panel.background = element_rect(fill="white"),
            panel.grid.major = element_line(size = 0.5,
                                            linetype = 'solid',
                                            colour = "grey"),
            panel.grid.minor = element_line(size = 0.25,
                                            linetype = 'solid',
                                            colour = "grey")) +
      labs(x="Appointments per year", y="Annual Cost (USD)") +
      geom_line(size=2) +
      ggtitle("Annual Patient Costs by Treatment Model") +
      scale_color_gdocs(
        name="Treatment Model",
        labels=c("Clinic", "Co-Op"))




  })



})


