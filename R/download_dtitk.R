#' @title Download DTI-TK
#' @description Download DTI-TK tarball from NITRC website
#'
#' @param os Operating system to download
#' @return NULL
#' @export
download_dtitk = function(os = c("osx", "linux")) {
  os = match.arg(os)
  http_stub = "http://www.nitrc.org/frs/download.php"
  stub_url = switch(os,
                    "osx" = "4981/dtitk-2.3.1-Linux-x86_64.tar.gz/?i_agree=1",
                    "linux" = "5300/dtitk-2.3.3-Darwin-x86_64.tar.gz/?i_agree=1")
  url = file.path(http_stub, stub_url)
  browseURL(url)
  return(invisible(NULL))
}

