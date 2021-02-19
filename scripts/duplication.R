library(vtrace)

trace_code({
               library(dplyr)

               starwars %>% filter(species == "Droid")
           })
