
library(Rcwl)

.sourceCWL <- function(rscript, env = .GlobalEnv){
    .env <- new.env()
    source(rscript, .env)
    objs <- ls(.env)
    oidx <- sapply(objs,
                   function(x)is(get(x, envir = .env), "cwlParam"))
    for(i in seq(sum(oidx))){
        assign(objs[oidx][i],
               get(objs[oidx][i], envir = .env),
               envir = env)
    }
}

#' source Rcwl scripts
#' @param file The Rcwl tool or pipeline receipes. The dependent
#'     Rcwl scripts should be included with @include tag.
#' @param env The enviroment to export.
sourceRcwl <- function(file, env = .GlobalEnv) {
    scripts <- readLines(file)
    iscripts <- grep("@include", scripts, value = TRUE)
    if(length(iscripts) > 0){
        rscripts <- grep(".R$",
                         unlist(strsplit(iscripts, split = " ")),
                         value = TRUE)
        if(length(rscripts) > 0){
            sapply(rscripts, function(x){
                rscript <- file.path(dirname(file), x)
                if(any(grepl("cwlStepParam", readLines(rscript)))){
                    sourceRcwl(rscript, env)
                }else{
                    .sourceCWL(rscript, env)
                }
            })
        }
    }
    .sourceCWL(file, env)
}

pp <- list.files("Rcwl", "pl_", full.names = TRUE)
lapply(pp, function(p){
    sourceRcwl(p)
    pid <- sub(".R$", "", sub("^pl_", "", basename(p)))
    dir.create(file.path("cwl", pid), recursive = TRUE, showWarnings = FALSE)
    writeCWL(get(pid), prefix = file.path("cwl", pid, pid))
})

tl <- list.files("Rcwl", "tl_", full.names = TRUE)
lapply(tl, function(p){
    print(p)
    sourceRcwl(p)
    pid <- sub(".R$", "", sub("^tl_", "", basename(p)))
    # dir.create(file.path("cwl", pid), recursive = TRUE, showWarnings = FALSE)
    writeCWL(get(pid), prefix = file.path("cwl", pid))
    if(is(baseCommand(get(pid)), "function")){
        s <- readLines(paste0("cwl/", pid, ".cwl"))
        file.copy(sub("- ", "", grep(".R$", s, value = T)), paste0("cwl/", pid, ".R"))
    }
})
