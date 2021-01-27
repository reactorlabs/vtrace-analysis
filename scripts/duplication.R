library(instrumentr)
library(injectr)

functions <- get_package_function_names("dplyr", public = TRUE, private = FALSE)

application_load_callback <- function(context, application) {
    set_data(context, new.env(parent=emptyenv()))
}

application_unload_callback <- function(context, application) {
    data <- get_data(context)

    result <- data.frame(input = data$input_address,
                         output = data$output_address,
                         type = data$type)

    write.csv(result, "data/duplication.csv")
}

object_duplicate_callback <- function(context,
                                      application,
                                      input,
                                      output,
                                      deep) {

    data <- get_data(context)

    input_details <- get_object_details(variable = "input")

    input_address <- input_details$address
    output_address <- get_object_details(variable = "output")$address
    type <- input_details$type

    input_vec <- get0("input_address",
                      envir = data,
                      ifnotfound = character(0))
    input_vec <- c(input_vec, input_address)

    output_vec <- get0("output_address",
                      envir = data,
                      ifnotfound = character(0))
    output_vec <- c(output_vec, output_address)

    type_vec <- get0("type",
                     envir = data,
                     ifnotfound = character(0))
    type_vec <- c(type_vec, type)

    assign("input_address", input_vec, envir = data)
    assign("output_address", output_vec, envir = data)
    assign("type", type_vec, envir = data)
}

context <- create_context(application_load_callback = application_load_callback,
                          application_unload_callback = application_unload_callback,
                          object_duplicate_callback = object_duplicate_callback,
                          functions = functions)

trace_code(context = context,
           code = {
               library(dplyr)

               starwars %>%
                 filter(species == "Droid")
           })

