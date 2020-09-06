# DataPrep
This repository will be utilized to store the original data provided by AMPATH, as well as the initial code to clean and prepare that data for further analysis.

When workstream analyses utilize the data from AMPATH, they should read the cleaned file directly into their R file from this repository. An example of how to do that is shown below:

```{r}
library(readr)  # This library contains the read_csv function. Do not use the standard R function read.csv()
raw_data <- "https://raw.github.com//AMPATH-Capstone/DataPrep/Final-Data/artcoops.csv"
ampath_data <- read_csv(raw_data)
```
