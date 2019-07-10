# Make a new environment for personal functions. This allows the masking of base
# R functions without including them in the global environment.
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

# Stop R from opening an X11 window every time online documentation is opened.
options("menu.graphics" = FALSE)

# Don't accidentally match things with the dollar sign.
options("warnPartialMatchDollar" = TRUE)

# Issue an error if an `if` statement has length greater than one.
Sys.setenv("_R_CHECK_LENGTH_1_CONDITION_" = "true")
