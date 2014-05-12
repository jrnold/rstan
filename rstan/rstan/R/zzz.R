.onLoad <- function(libname, pkgname) { }

.onAttach <- function(...) {
  rstanLib <- dirname(system.file(package = "rstan"))
  pkgdesc <- packageDescription("rstan", lib.loc = rstanLib)
  builddate <- gsub(';.*$', '', pkgdesc$Packaged)
  packageStartupMessage(paste("rstan (Version ", pkgdesc$Version, ", packaged: ", builddate, ")", sep = ""))
} 

