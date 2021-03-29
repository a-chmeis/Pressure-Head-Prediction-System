## ---------------------------------------------------------------------------------------------------------------
## Script name: h/T_Plots
## Purpose of script: Plotting model results
## Author: Arij Chmeis
## Date Created: 2021-03-29
## Copyright (c) Arij Chmeis, 2021
## Email: achmeis1949@gmail.com
## ----------------------------------------------------------------------------------------------------------------
## 

setwd('~/ownCloud/Thesis/Case Study')

library(ggplot2)
library(data.table)
library(lubridate)
library(tidyverse)
library(gridExtra)
library(ggthemes)
library(RColorBrewer)
library(ggpubr)


#------------------ Reading files ------------------------------------------------------------------------------------

#PRESSURE HEAD

h1 <- as.data.table(read.table(path = '~/ownCloud/Thesis/Case Study/drutes.conf/out/obspt_RE_matrix-1.out'), 
                                col.names = c('Step', 'h', 'theta_l', 'theta_v', 'qL', 'cumulativeL', 'qv', 'cumulativeV', 'Total', 'cumulativeT')))

h5 <- as.data.table(read.table(path = '~/ownCloud/Thesis/Case Study/drutes.conf/out/obspt_RE_matrix-5.out'), 
                                col.names = c('Step', 'h', 'theta_l', 'theta_v', 'qL', 'cumulativeL', 'qv', 'cumulativeV', 'Total', 'cumulativeT')))

h6 <- as.data.table(read.table(path = '~/ownCloud/Thesis/Case Study/drutes.conf/out/obspt_RE_matrix-6.out'), 
                                col.names = c('Step', 'h', 'theta_l', 'theta_v', 'qL', 'cumulativeL', 'qv', 'cumulativeV', 'Total', 'cumulativeT')))

#TEMPERATURE

temp1 <- as.data.table(read.table(path = '~/ownCloud/Thesis/Case Study/drutes.conf/out/obspt_heat-1.out'),
                                   col.names = c('Step', 'temp', 'heat_flux', 'cumulative')))

temp5 <- as.data.table(read.table(path = '~/ownCloud/Thesis/Case Study/drutes.conf/out/obspt_heat-5.out'), 
                                   col.names = c('Step', 'temp', 'heat_flux', 'cumulative')))

temp6 <- as.data.table(read.table(path = '~/ownCloud/Thesis/Case Study/obspt_heat-6.out'), 
                                   col.names = c('Step', 'temp', 'heat_flux', 'cumulative')))


#Sensor bservations and energy balance output

sense<- as.data.table(read.table(path = '~/ownCloud/Thesis/Case Study/observations.out'), sep = ',', header = T))

EB_Out <- as.data.table(read.table(path = '~/ownCloud/Thesis/Case Study/drutes.conf/out/ebalance.out'),
                        col.names = c('Step', 'R', 'H', 'LE')))



#------------------ Calculating G and E ------------------------------------------------------------------------------------

temp1 <- temp1[-c(15485:15486),]
temp1 <- temp1[,-c(3,4)]
new_table <- merge(e_Out, temp1, by = 'Step')

Lw <- transform(new_table, L = 2501000 - ( 2369.2 * new_table$temp))
Evap <- transform(Lw, E = Lw$LE / (Lw$L * 997))
daily <- transform(Evap, dE = -1 * Evap$E * 86400000)
SEB <- transform(daily, G = daily$R - daily$H + daily$LE)


#------------------ Setting color scales and axis labels ------------------------------------------------------------------------------------

h_colors <- c('OBS' = '#A1D6E2', 'SIM' = '#4682B4')
temp_colors <- c('OBS' = '#FFCCBB','SIM' = '#AF4425')
e_colors <- c('H' = '#FFCCBB','R' = '#4682B4','LE' = '#A10115',
              'G' = '#A1D6E2', 'E' = '#4682B4')

Date <- c('Nov 26', 'Nov 29', 'Dec 2', 'Dec 5', 'Dec 8', 'Dec 11')
position <- c(0, 250000, 500000, 750000, 1000000, 1250000)

#------------------ Plots ------------------------------------------------------------------------------------

#PRESSURE HEAD

a <- ggplot() + theme_minimal() +
  theme(legend.title=element_blank(),
        legend.background = element_rect(fill='white', linetype='solid', 
                                         colour ='white'),
        plot.title=element_text(face='bold', colour='turquoise4', size=9),
        axis.title.x = element_text(face="bold", color='turquoise4', vjust=-1, size = 10),
        axis.title.y = element_text(face="bold", color='turquoise4', vjust=2.5, size = 9)) +
  ggtitle('(a)') +
  geom_line(data = sense, linetype = 'dashed', aes(x = Step, y = h.35cm, color = 'OBS'), size=1) +
  geom_line(data = h5, linetype = 'dashed', aes(x = Step, y = h, color = 'SIM'), size=1) +
  labs(x = 'Time [days]',
       y = 'Pressure head [m]') +
  scale_x_continuous(breaks = position, n.breaks = 6, labels = Date) +
  scale_color_manual(values = h_colors)

b <- ggplot() + theme_minimal() +
  theme(legend.title=element_blank(),
        legend.background = element_rect(fill='white', linetype='solid', 
                                         colour ='white'),
        plot.title=element_text(face='bold', colour='turquoise4', size=9),
        axis.title.x = element_text(face="bold", color='turquoise4', vjust=-1, size = 10),
        axis.title.y = element_text(face="bold", color='turquoise4', vjust=2.5, size = 9)) +
  ggtitle('(b)') +
  geom_line(data = sense, aes(x = Step, y = h.80cm, color = 'OBS'), size=1) +
  geom_line(data = h6, aes(x = Step, y = h, color = 'SIM'), size=1) +
  labs(x = 'Time [days]',
       y = 'Pressure head [m]') +
  scale_x_continuous(breaks = position, n.breaks = 6, labels = Date) +
  scale_color_manual(values = h_colors)


ggarrange(a,b, ncol = 1, nrow = 2, common.legend = T,
          legend = 'right', align = 'hv')


#TEMPERATURE

a <- ggplot() + theme_minimal() +
  theme(legend.title=element_blank(),
        legend.background = element_rect(fill='white', linetype='solid', 
                                         colour ='white'),
        plot.title=element_text(face='bold', colour='salmon3', size=9),
        axis.title.x = element_text(face="bold", color='salmon3', vjust=-1, size = 10),
        axis.title.y = element_text(face="bold", color='salmon3', vjust=2.5, size = 9)) +
  ggtitle('(a)') +
  geom_line(data = sense, aes(x = Step, y = Temp.35cm, color = 'OBS'), size=1) +
  geom_line(data = temp5, aes(x = Step, y = temp, color = 'SIM'), size=1) +
  labs(x = 'Time [days]',
       y = 'Soil temperature [ ºC]') +
  scale_x_continuous(breaks = position, n.breaks = 6, labels = Date) +
  scale_color_manual(values = temp_colors)


b <- ggplot() + theme_minimal() +
  theme(legend.title=element_blank(),
        legend.background = element_rect(fill='white', linetype='solid', 
                                         colour ='white'),
        plot.title=element_text(face='bold', colour='salmon3', size=9),
        axis.title.x = element_text(face="bold", color='salmon3', vjust=-1, size = 10),
        axis.title.y = element_text(face="bold", color='salmon3', vjust=2.5, size = 9)) +
  ggtitle('(b)') +
  geom_line(data = sense, aes(x = Step, y = Temp.80cm, color = 'OBS'), size=1) +
  geom_line(data = temp6, aes(x = Step, y = temp, color = 'SIM'), size=1) +
  labs(x = 'Time [days]',
       y = 'Soil temperature [ ºC]') +
  scale_x_continuous(breaks = position, n.breaks = 6, labels = Date) +
  scale_color_manual(values = temp_colors)

ggarrange(a,b, ncol = 1, nrow = 2, common.legend = T,
          legend = 'right', align = 'hv')

#ENERGY BALANCE OUTPUT

ggplot() + theme_minimal() +
  theme(legend.title=element_blank(),
        legend.background = element_rect(fill='white', linetype='solid', 
                                         colour ='white', size = 1),
        axis.title.x = element_text(face='bold', color='turquoise4', vjust=-1, size = 10),
        axis.title.y = element_text(face='bold', color='turquoise4', vjust=2.5, size = 10)) + 
  geom_line(data = SEB, aes(x = Step, y = G, color = 'G'), size=1) +
  geom_line(data = SEB, aes(x = Step, y = R, color = 'R'), size=1) +
  geom_line(data = SEB, aes(x = Step, y = H, color = 'H'), size=1) +
  geom_line(data = SEB, aes(x = Step, y = LE, color = 'LE'), size=1) +
  labs(x = 'Time [days]',
       y = f) +
  scale_x_continuous(breaks = position, n.breaks = 6, labels = Date) +
  scale_color_manual(values = e_colors)

#EVAPORATION RATE

ggplot() + theme_minimal() +
  theme(legend.title=element_blank(),
        legend.background = element_rect(fill='white', linetype='solid', 
                                         colour ='white', size = 1),
        axis.title.x = element_text(face='bold', color='turquoise4', vjust=-1, size = 10),
        axis.title.y = element_text(face='bold', color='turquoise4', vjust=2.5, size = 10)) + 
  geom_line(data = SEB, aes(x = Step, y = dE, color = 'E'), size=1)+
  labs(x = 'Time [days]',
       y = expression(bold(paste('Evaporation rate [mm.', day^'-1',']'))) ) +
  scale_x_continuous(breaks = position, n.breaks = 6, labels = Date) +
  scale_color_manual(values = mycolors)

