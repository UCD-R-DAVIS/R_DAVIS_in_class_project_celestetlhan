#final_han_celeste

library(tidyverse)

#1
running_df<- read_csv("https://raw.githubusercontent.com/UCD-R-DAVIS/R-DAVIS/refs/heads/main/data/tyler_activity_laps_12-6.csv")
running_df
#2
running_df<- running_df %>% 
  filter(sport == "running")

#3
running_df<- running_df %>% 
  filter( minutes_per_mile >= 5 & minutes_per_mile <= 10) %>%
  filter(total_elapsed_time_s>60)

#4
running_df<- running_df %>% 
  mutate(
    period = case_when(
      year < 2024 ~ "pre-2024",
      year == 2024 & month <= 6 ~ "2024 jan to june",
      year == 2024 & month >= 7 ~ "2024 july to present"
    )
  )

#5 and 6 and 7
#first make the speed and spm/speed column

running_df<- running_df %>% 
  mutate(
   speed_in_milespermin = (total_distance_m/total_elapsed_time_s)* (60/1609.34)
  )

  running_scatterplot <- ggplot(running_df, aes(y=steps_per_minute, x=speed_in_milespermin, colour=period)) +
    geom_point()+
    labs(
      title= "SPM over speed by lap",
      x= "Speed (miles/min)",
      y= "SPM",
    colour = "Period"
    ) +
    theme_minimal()+
    theme(
      text= element_text(size= 12),
      plot.title = element_text(hjust = 0.5, face = "bold")
    ) +
    geom_smooth(method = "lm", se = FALSE)
running_scatterplot

###I realised i did this wrong, i need to create a function to loop for each LAP which is each row

library(ggplot2)

create_scatterplot <- function(lap_data) {
  ggplot(lap_data, aes(y=steps_per_minute, x=speed_in_milespermin, colour=period)) +
    geom_point()+
    labs(
      title= "SPM over speed by lap",
      x= "Speed (miles/min)",
      y= "SPM",
      colour = "Period"
    ) +
    theme_minimal()+
    theme(
      text= element_text(size= 12),
      plot.title = element_text(hjust = 0.5, face = "bold")
    ) 
  }
for (i in 1:nrow(running_df)) {
  lap_data <- running_df[i,]
  print(create_scatterplot(lap_data))
}

