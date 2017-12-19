library(readxl)
library(dplyr)
library(tidyr)

q <- read_excel("Raw data.xlsx")
q <- q %>% select(`Response ID`,affiliation,`Provide input as to how you believe the mission statement could be improved.`,
                  `Provide input as to how you believe the vision statement could be improved.`,
                  `Provide input as to how you believe the core values could be improved.`) %>% 
  setNames(c('Id','affiliation','mission','vision','values'))

tmp <- q%>% gather( "Topic",'comment',3:5,na.rm = TRUE) 

#breakdown by respondents - across all three items 

tmp %>% distinct(`Response ID`,.keep_all = TRUE) %>% count(affiliation)

#breakdown by respondents and by each item 

by_q <- tmp %>% 
  group_by(Topic, affiliation) %>% summarise(n=n()) %>%  
  spread(Topic,n) 
