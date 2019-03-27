# Make a new environment for personal functions
personal <- new.env()
assign(
    "quit",
    function(save = "no", status = 0, runLast = TRUE) {
        base::quit(save = save)
    },
    envir = personal
)
assign(
    "q",
    function(save = "no", status = 0, runLast = TRUE) {
        base::quit(save = save)
    },
    envir = personal
)

attach(personal)

rm(personal)
