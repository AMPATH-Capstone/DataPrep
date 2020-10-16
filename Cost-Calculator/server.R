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

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  output$costAmpathPlot <- renderPlot({
    patients <- c(1:500)
    cta <-
      data.frame(
        cta_cl <- (((((
          input$cl_min_appt/60)*input$cl_hrly_cost)*input$cl_num_appt)+input$cl_variable)*patients)+input$cl_fixed,

        cta_cp <- (((((input$coop_min_appt/60)*input$coop_hrly_cost)*input$coop_num_appt)+input$coop_variable)*patients)+input$coop_fixed,
        patients
      )
    cta2 <- melt(cta, id="patients")
    ggplot(data=cta2,
           aes(x=patients, y=value, color=variable)) +
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
      labs(x="Number of Patients", y="Annual Cost (KES)") +
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
        ctp_cl <- (pt_num_appt*(input$pt_min_cl+input$pt_wait_cl+input$pt_appt_time_cl)*input$pt_opp_cost),
        ctp_cp <- (pt_num_appt*(input$pt_min_coop+input$pt_wait_coop+input$pt_appt_time_coop)*input$pt_opp_cost),
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
      labs(x="Appointments per year", y="Annual Cost (KES)") +
      geom_line(size=2) +
      ggtitle("Annual Patient Costs by Treatment Model") +
      scale_color_gdocs(
        name="Treatment Model",
        labels=c("Clinic", "Co-Op"))




  })

})
