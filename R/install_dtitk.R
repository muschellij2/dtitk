#' @title Install DTI-TK
#' @description Install DTI-TK from the tarball you downloaded
#' @param tarfile Tarball file (with extension \code{.tar.gz})
#' @param verbose Print output of \code{untar}
#' @return Logical indicating files were there
#' @export
install_dtitk = function(tarfile, verbose = TRUE) {
  tfile = tempfile()
  exdir = file.path(tfile, "dtitk")
  dir.create(exdir)



  files = untar(tarfile, exdir = exdir,
                list = TRUE,
                compressed = "gzip", verbose = FALSE)
  res = untar(tarfile, exdir = exdir,
              compressed = "gzip", verbose = verbose)
  stopifnot(res == 0)
  ##########################################
  # Taking out the subdirectory
  ##########################################
  outfiles = strsplit(files, "/")
  outfiles = sapply(outfiles, function(x){
    if (length(x) > 1) {
      x = x[-1]
    }
    x = paste(x, collapse = "/")
    return(x)
  })

  all_fols = unique(dirname(outfiles))

  fols = sapply(strsplit(outfiles, "/"),
                function(x) {
                  if (length(x) <= 1) {
                    return("")
                  } else {
                    return(x[1])
                  }
                })
  fols = sort(unique(fols))
  fols = setdiff(fols, "")
  stopifnot(all(
    fols %in% folnames)
  )

  ##########################################
  # Copying them over
  ##########################################
  files = file.path(exdir, files)

  folnames = c("bin", "include", "lib", "scripts", "utilities")
  dti_fol = system.file(package = "dtitk")
  out_fols = file.path(dti_fol, all_fols)
  res = sapply(out_fols, dir.create,
               showWarnings = verbose, recursive = TRUE)

  outfiles = file.path(dti_fol, outfiles)

  file.remove(outfiles)
  copied = file.copy(from = files, to = outfiles, overwrite = TRUE)

  return(all(copied))
  # infiles = file.path(exdir, fols)
  # file.copy()



}