

# Load the necessary packages
library(dplyr) 
library(tidyr)

# Read the data
crimes <- read.csv("G://Final project//data//a//crime_data.csv", header = T)

crimes <- crimes %>% select(date = Month,
                                                     location = Location,
                                                    borough = Borough,
                                                     
                                                    category = Crime.type,
                                                   long = Longitude,
                                                  lat = Latitude)
## Using ggplot2
library(ggplot2)

df <- crimes %>%
  group_by(category, date) %>%
  summarise(n = n())

ggplot(df, aes(x=category, y=date, fill=n)) +
  geom_tile(aes(fill=n)) +
  geom_text(aes(label=n), size=4, color="black") +
  scale_x_discrete("", expand = c(0,0)) +
  scale_y_discrete("", expand = c(0,-2)) +
  scale_fill_gradient("Frequency", low = "white", high = "steelblue") +
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  theme(axis.text=element_text(size=12)) +
  theme(legend.position="none") +
  ggtitle("Crime levels in Manchester by month\n") +
  theme(plot.title = element_text(face="bold", size="20"))

ggsave("calendar_heatmap.png", scale = 1, dpi = 300)
