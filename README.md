# DataPrep
This repository will be utilized to store the original data provided by AMPATH, as well as the initial code to clean and prepare that data for further analysis.

When workstream analyses utilize the data from AMPATH, they should read the cleaned file directly into their R file from this repository. An example of how to do that is shown below:

```ruby
install.packages("readr") #Install this package if necessary, which contains the read_csv function. Do not use the basic read.csv()
library(readr)
raw_data <- "https://raw.githubusercontent.com/AMPATH-Capstone/DataPrep/Final-Data/artcoops_final.csv"
ampath_data <- read_csv(raw_data)
```
