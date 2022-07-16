# Shiny App Directory Structure
# create shiny app directory
app_name = 'first-app'
cdir = getwd()
app_dir = file.path(cdir, app_name)
dir.create(path = file.path(app_dir, "data"),recursive = TRUE)

# create four basic files required for shiny app
ui_fp = file.path(app_dir, "ui.R")  # user interface or client file
server_fp = file.path(app_dir, "server.R")  # shiny server side file
global_fp = file.path(app_dir, "global.R")  # holds global variables and functions

file.create(ui_fp) 
file.create(server_fp)  
file.create(global_fp)

# create run file : after creating shiny app, source this file to run the app
# source("./first-app/run.R")
run_fp = file.path(app_dir, "run.R")
file.create(run_fp)

# add contents to user interface file
fd = file(ui_fp, open = "at")
writeLines(text = "require(shiny)", con = fd)
writeLines(text = "ui = fluidPage(", con = fd)
writeLines(text = paste0("\t", 'textOutput("greeting")', "\n)"), con = fd)
close(fd)

# add contents to server file
fd = file(server_fp, open = "at")
writeLines(text = "require(shiny)", con = fd)
writeLines(text = "server = function(input, output, session) {", con = fd)
writeLines(text = "\toutput$greeting = renderText({", con = fd)
writeLines(text = paste0("\t\t", 
                         'paste0("Hello, ", name, "!")',
                         '  # name is a global variable defined in global.R'), 
           con = fd)
writeLines(text = "\t })\n}", con = fd)
close(fd)

# add contents to global file
fd = file(global_fp, open = "at")
writeLines(text = 'name = "John Doe"', con = fd)
close(fd)

# add contents to run file
fd = file(run_fp, open = "at")
writeLines("require(shiny)", con = fd)
writeLines(paste0("shiny::runApp(appDir = ", '"', app_dir, '"', ")"), con = fd)
close(fd)

