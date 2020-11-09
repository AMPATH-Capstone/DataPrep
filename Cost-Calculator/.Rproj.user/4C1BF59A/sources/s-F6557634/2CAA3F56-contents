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

dfac <- read_csv("https://raw.githubusercontent.com/AMPATH-Capstone/DataPrep/master/Original-Data/new_ArtsCoop.csv")

dfac <- dfac %>% select(2, 3, 487, 489, 490, 498, 499, 500, 501, 502, 503, 504, 505, 506, 507, 515)
dfac[is.na(dfac)] <- 0
dfac <- dfac %>% filter(redcap_event_name=="Month 12")
dfac1 <- dfac %>% filter(participant_arm=="Control")
dfac2 <- dfac %>% filter(participant_arm=="Intervention")

dfac1$hrs <- dfac1$own_health_visit * (dfac1$time_to_hc_hr + ((dfac1$time_to_hc_mins + dfac1$waiting_time + dfac1$consult_time)/60))
dfac1$cost <- dfac1$comm_on_health_cost + dfac1$other_med_costs + (dfac1$own_health_visit * (dfac1$cost_of_travel_to_hc*2))
dfac1 <- dfac1[!(dfac1$cost >15000),]

dfac2$interven_time_to_meet_hrs <- ifelse(dfac2$interven_time_to_meet_hrs>=60, dfac2$interven_time_to_meet_hrs/60, dfac2$interven_time_to_meet_hrs)
dfac2$hrs <- dfac2$no_of_meetings_att * (dfac2$interven_time_to_meet_hrs + ((dfac2$interven_time_to_meet_mins + dfac2$time_spent_meeting)/60))
dfac2$cost <- dfac2$comm_cost_artcoops + dfac2$other_med_costs + (dfac2$no_of_meetings_att * (dfac2$int_cost_of_travel_to_meet*2))

dfac1 <- dfac1 %>% select(2, 3, 17, 18)
dfac1 <- dfac1 %>% rename(Appointments = own_health_visit)
dfac2 <- dfac2 %>% select(2, 11, 17, 18)
dfac2 <- dfac2 %>% rename(Appointments = no_of_meetings_att)
dfac3 <- rbind(dfac1, dfac2)
byappt <- dfac3 %>% group_by(participant_arm, Appointments)
byappt <- byappt %>% summarize(
  mxh = max(hrs),
  mih = min(hrs),
  mnh = mean(hrs),
  mxc = max(cost),
  mic = min(cost),
  mnc = mean(cost)
)

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
    pt_num_appt <- c(1:5)

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
      labs(x="Appointments per year", y="Annual Cost (KES)") +
      geom_line(size=2) +
      ggtitle("Annual Patient Costs by Treatment Model - Calculated Values") +
      scale_color_gdocs(
        name="Treatment Model",
        labels=c("Clinic", "Co-Op"))

  })

  output$hoursPatientPlot <- renderPlot({
    pt_num_appt <- c(1:5)

    ctp <-
      data.frame(
        ctp_cl <- (pt_num_appt*((input$pt_min_cl+input$pt_wait_cl+input$pt_appt_time_cl)/60)),
        ctp_cp <- (pt_num_appt*((input$pt_min_coop+input$pt_wait_coop+input$pt_appt_time_coop)/60)),
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
      labs(x="Appointments per year", y="Annual Hours") +
      geom_line(size=2) +
      ggtitle("Annual Healthcare Hours by Treatment Model - Calculated Values") +
      scale_color_gdocs(
        name="Treatment Model",
        labels=c("Clinic", "Co-Op"))

  })

  output$hoursscatterplot <- renderPlot({

    ggplot(data=byappt,
           aes(x=Appointments, ymin=mih, ymax =mxh, y=mnh, color=participant_arm, group=participant_arm)) +
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
      labs(x="Annual Appointments", y="Hours Demanded by Healthcare") +
      geom_pointrange(position=position_dodge(width=0.20)) +
      ggtitle("Non-Opportunity Patient Costs by Treatment Model - AMPATH Study") +
      scale_color_gdocs(
        name="Treatment Model",
        labels=c("Clinic", "Co-Op"))

  })

  output$costscatterplot <- renderPlot({

    ggplot(data=byappt,
           aes(x=Appointments, ymin=mic, ymax =mxc, y=mnc, color=participant_arm, group=participant_arm)) +
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
      labs(x="Annual Appointments", y="Hours Demanded by Healthcare") +
      geom_pointrange(position=position_dodge(width=0.20)) +
      ggtitle("Hours Demanded by Treatment Model - AMPATH Study") +
      scale_color_gdocs(
        name="Treatment Model",
        labels=c("Clinic", "Co-Op"))

  })
})


