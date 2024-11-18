#week7_videos

## DATA VISUALIZATION 2AA DataVizinR VIZTIPS

library(tidyverse)
library(ggplot2)

#section 1: plot best practices and ggplot review
#ggplot has four parts:
#data/materials ggplot(data=yourdata)
#plot type / design geom_..
#aesthetics / decor aes()
#stats / wiring stat_...

#lets see what this looks like:
#here we practice creating a dot plot of price on carat
ggplot(diamonds, aes(x=carat, y=price)) + 
  geom_point()

#rmbr from pt 1 last week how we iiterate on plots? well do that this week by creating a basic plot  and adding stuff to it
#now well add transparency and colour

#all-over colour
ggplot(diamonds, aes(x=carat, y=price)) + 
  geom_point(colour= "blue")

#colour by variable
ggplot(diamonds, aes(x=carat, y=price, colour=clarity)) + 
  geom_point(alpha=0.2)
#here we coloured by the clarity variable, and we added transparency with the alpha

#plot best practices:
#remove backgrounds, redundant labels, borders, reduce colour and special effects
#remove bolding, lighten labels, remove lines, direct label

#here we remove the background to clean up the plot
#as we learned last week, there are other themes beside classic
ggplot(diamonds, aes(x=carat, y=price, colour=clarity)) + 
  geom_point(alpha=0.2) + theme_classic()

#keep your visualizatio simple with a clear message
#label axes
#start axes at zero

#now ive added a title and edited the y label to be more specific
ggplot(diamonds, aes(x=carat, y=price, colour=clarity))+
  geom_point(alpha=0.2) + theme_classic()+
  ggtitle("Price by Diamond Quality") + ylab("Price in $")
  
#now ive added linear regression trendlines for each colour 
ggplot(diamonds, aes(x=carat, y=price, colour=clarity))+
  geom_point(alpha=0.2) + theme_classic()+
  ggtitle("Price by Diamond Quality") + ylab("Price in $")+
  stat_smooth(method="lm")

#now ive instead added LOESS trendcurves for each colour
ggplot(diamonds, aes(x=carat, y=price, colour=clarity))+
  geom_point(alpha=0.2) + theme_classic()+
  ggtitle("Price by Diamond Quality") + ylab("Price in $")+
  stat_smooth(method="loess")

#go to tutorials > data visualixation part 1 for a refreasher on how to use colours in geom_line (a time series)


##DATA VISUALIZATION 2B COLOUR
#section 2 colour palatte choices and colour-blind friendly visualizations
#always work to use colourblind-friendly or black-and-white friendly colours


#there are four types of palettes:
#1: continuous
#2: ordinal (for plotting categories representing least to most of something, discrete categories (can be 0, 1, 2, 3, or strongly disagree to neutral to strongly agree))
#3: qualitative (for showing different categories that are non-ordered (not one greater or less than other))
#4: diverging (for plotting a range from negative values to positive values)

#theres several different packages you can use in R to use different palattes so we can take a look at a couple of them

#RColourBrewer shows some good examples of these. lets take a look:
install.packages("RColorBrewer")
library("RColorBrewer")

#this is a list of all of RColorBrewer's colourblind friendly discrete colouur palettes
display.brewer.all(colorblindFriendly = TRUE)

##continuous data
#use scale_fill_viridis_c or scale_color_viridis_c for continuous
#you can set direction = -1 to rerverse the direction of the colourscale
ggplot(diamonds, aes(x= clarity, y= carat, colour=price))+
  geom_point(alpha=0.2) + theme_classic()+
  scale_colour_viridis_c(option = "C", direction = -1)
# this is an example of continuous data^ so we set as viridis C for continuous bc price isnt discrete or categorical
# there different "options" here for option = "C" you can change it to different ones for slightly different colours and moods


#lets pick another viridis colour scheme by using a different letter for option
ggplot(diamonds, aes(x= clarity, y= carat, colour=price))+
  geom_point(alpha=0.2) + theme_classic()+
  scale_colour_viridis_c(option = "E", direction = -1)

#to bin continuous data, use the suffix "_b" instead
ggplot(diamonds, aes(x= clarity, y= carat, colour=price))+
  geom_point(alpha=0.2) + theme_classic()+
  scale_colour_viridis_b(option = "C", direction = -1)

#ordinal (discrete sequential)
#from the viridis palette
# use scale_fill_viridis_d or scale_color_viridis_d for discrete, ordinal
ggplot(diamonds, aes(x= cut, y= carat, fill=color))+
  geom_boxplot() + theme_classic()+
  ggtitle("Diamond Quality by Cut")+
  scale_fill_viridis_d("color")

#scale_color is for color and scale_fill is for the fill
#note I have to change the
#aes parameter from "fill =" to "color=" to match
ggplot(diamonds, aes(x= cut, y= carat, color=color))+
  geom_boxplot(alpha=0.2) + theme_classic()+
  ggtitle("Diamond Quality by Cut")+
  scale_color_viridis_d("color")

#heres how it looks on a barplot
ggplot(diamonds, aes(x=clarity, fill=cut))+
  geom_bar()+
  theme(axis.text.x= element_text(angle=70, vjust=0.5))+
  scale_fill_viridis_d("cut", option= "B")+
  theme_classic()

#from RColorBrewer:
ggplot(diamonds, aes(x=cut, y=carat, fill = color))+
  geom_boxplot()+theme_classic()+
  ggtitle("Diamond Quality by Cut")+
  scale_fill_brewer(palette = "PuRd")
#how did we know the name of the palette is PuRd?? from this list:
display.brewer.all(colorblindFriendly = TRUE)

##qualitative categorical
#dont worry about this line of code; the "sub" function isnt part of the..?
#we're just making a column for the make of the car
mycars <- cbind(mtcars, make=sub(".*","", rownames(mtcars)))
mycars<- head(mycars, n=16)

#From RColorBrewer:
ggplot(iris,
       aes(x=Sepal.Length, y=Petal.Length, fill= Species))+
  geom_point(shape=24, color="black", size=4)+ theme_classic()+
  ggtitle("Sepal and Petal Length of three Iris Species")+
  scale_fill_brewer(palette="Set2")
#how did we know the name of the palette is "Set2"? From this list:
display.brewer.all(colorblindFriendly = TRUE)    
    
#From the ggthemes package:
#lets also clarify the units
library(ggplot2)
install.packages("ggthemes")
library(ggthemes)
ggplot(iris, aes(x=Sepal.Length, y=Petal.Length, color=Species))+
  geom_point()+theme_classic()+
  ggtitle("Sepal and Petal Length of Three Iris Species")+
  scale_color_colorblind("Species")+
  xlab("Sepal Length in cm")+
  ylab("Petal Length in cm")

#manual palette design
#this is another version of the same
#colorblind palette from the ggthemes package but with gray instead of black
#this is an example of how to create a named vector
#of colors and use it as a manual fill
cbPalette<- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2")
names(cbPalette)<- levels(iris$Species)
#we dont need all the colours int he palette because there are only 3 categories
#we cut the vector length to 3 here
cbPalette<- cbPalette[1:length(levels(iris$Species))]

ggplot(iris, aes(x=Sepal.Length, y=Petal.Length, color= Species))+
  geom_point()+theme_classic()+
  ggtitle("Sepal and Petal Length of Three Iris Species")+
  scale_color_manual(values=cbPalette)+
  xlab("Sepal Length in cm")+
  ylab("Petal Length in cm")


##diverging discrete
#from RColorBrewer
myiris<- iris %>% group_by(Species) %>%  
  mutate(size=case_when(
    Sepal.Length > 1.1 * mean(Sepal.Length) ~ "very large",
    Sepal.Length < 0.9 * mean(Sepal.Length) ~ "very small",
    Sepal.Length < 0.94 * mean(Sepal.Length) ~ "small",
    Sepal.Length > 1.06 * mean(Sepal.Length) ~"large",
    T ~ "average"
  ))
myiris$size <- factor(myiris$size, levels = c(
  "very small", "small", "average", "large", "very large"
))

ggplot(myiris, aes(x=Petal.Width, y=Petal.Length, color= size))+
  geom_point(size=2)+theme_gray()+
  ggtitle("Diamond Quality by Cut")+
  scale_color_brewer(palette = "RdYlBu")




###DATA VISUALIZATION 2C NONVISUAL PUBLISHING SAVING PLOTLY

#section 3: non-visual representations ##
#braille package
mybarplot<- ggplot(diamonds, aes(x=clarity))+
  geom_bar()+
  theme(axis.text.x=element_text(angle=70, vjust=0.5))+
  theme_classic() +ggtitle("Number of Diamonds by Clarity")
mybarplot

install.packages("BrailleR")
library(BrailleR)

VI(mybarplot)
#interprets the bar plot for you in words

install.packages("sonify")
library(sonify)
plot(iris$Petal.Width)
sonify(iris$Petal.Width)


detach("package:BrailleR", unload=TRUE)

#section 4: publishing plots and saving figures & plots 
install.packages("cowplot")
library(cowplot)

#you can print multiple plots together which is helpful for publications

#make a few plots:
plot.diamonds <- ggplot(diamonds, aes(clarity, fill=cut))+
  geom_bar()+
  theme(axis.text.x=element_text(angle=70, vjust=0.5))
plot.diamonds

plot.cars<- ggplot(mpg, aes(x=cty, y=hwy, colour=factor(cyl)))+
  geom_point(size=2.5)
plot.cars

plot.iris<- ggplot(data=iris, aes(x=Sepal.Length, y=Petal.Length, fill = Species ))+
  geom_point(size=3, alpha=0.7, shape=21)
plot.iris


#use plot_grid
panel_plot <- plot_grid(plot.cars, plot.iris, plot.diamonds,
                        labels = c("A", "B", "C"), ncol=2, nrow=2)
panel_plot

#you can fix the sizes for more control over the result
fixed_gridplot<-ggdraw()+draw_plot(plot.iris, x=0, y=0, width=1, height=0.5)+
  draw_plot(plot.cars, x=0, y=0.5, width=0.5, height=0.5)+
  draw_plot(plot.diamonds, x=0.5, y=0.5, width=0.5, height=0.5)+
  draw_plot_label(label=c("A", "B", "C"), x=c(0, 0.5, 0), y=c(1,1,0.5)) #the x and y is where you want the x and y to start at for the plot position
fixed_gridplot



#saving figures
ggsave("figures/gridplot.png", fixed_gridplot)
#you can save images as .png, .jpeg, .tiff, .pdf, .bmp, or .svg

#for publications, use dpi of at least 700
ggsave("figures/gridplot.png", fixed_gridplot,
       width=6, height=4, units = "in", dpi=700)

#interactive web applications
install.packages("plotly")
library(plotly)

plot.iris<- ggplot(data=iris, aes(x=Sepal.Length, y=Petal.Length, fill=Species))+
  geom_point(size=3, alpha=0.7, shape=21)

plotly::ggplotly(plot.iris)


