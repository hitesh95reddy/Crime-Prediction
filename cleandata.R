library(tidyverse) ; library(lubridate) ; library(stringr)


setwd("G://Final project//data//")
# Find all file names in the 'data' folder that end in .csv
filenames <- dir(pattern = "*.csv")
filenames
# Read in the files and combine them into one data frame

crimes <- filenames %>% 
  map(read_csv) %>%
  reduce(rbind)

# Check the data
glimpse(crimes)

# Convert ‘Month’ to a date variable
crimes$Month <- parse_date_time(crimes$Month, "ym")

# Split LSOA.name and retain just the Borough name
crimes <- separate(crimes, `LSOA name`, into = c("Borough", "x"), sep = -5)

# Trim the trailing space on 'Borough' and convert it to a factor
crimes$Borough <- str_trim(crimes$Borough, side = "right") 
crimes$Borough <- as.factor(crimes$Borough)
levels(crimes$Borough) # check the different boroughs

# Select and rename some of the variables
#crimes <- crimes %>% select(date = Month,
#                           location = Location,
#                          borough = Borough,
#                         lsoa = `LSOA code`,
#                        category = `Crime type`,
#                       long = Longitude,
#                      lat = Latitude)


# Filter crimes with missing coordinates
crimes <- crimes %>% filter(!is.na(Longitude))


# Export the tidy data as a CSV for later use
write_csv(crimes, ".//a//crime_data.csv")

