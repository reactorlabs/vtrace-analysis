library(instrumentr)
library(vtrace)

trace_code(context = vtrace::create_tracer(),
           code = {
               library(dplyr)

               starwars %>% filter(species == "Droid")
           })
