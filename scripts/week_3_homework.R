#week_3_homework

surveys_base<-read_csv("data/portal_data_joined.csv")
surveys_base<-surveys_base[1:5000,c("species_id", "plot_type", "weight")]

#surveys_base$weight(na.rm = TRUE)
#doesnt seem to work

surveys_base <- surveys_base[complete.cases(surveys_base), ] 
str(surveys_base)
summary(surveys_base)
summary(surveys_base$species_id)
class(surveys_base$species_id)

surveys_base$species_id <- factor(surveys_base$species_id)
class(surveys_base$species_id)

surveys_base$plot_type <- factor(surveys_base$plot_type)
class(surveys_base$plot_type)


##challenge
challenge_base<-surveys_base[surveys_base$weight>150,]
