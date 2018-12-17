# rmdup <- function(mt, INDICES){
# colMax <- function(data) sapply(data, max, na.rm = TRUE)
# mt <- by(mt, INDICES = INDICES, colMax)
# mt <- as.data.frame(do.call(rbind,mt))
# return(mt)
# }
# ?by



rmdup <- function(mt, Type=max){
  nc <- ncol(mt)
  cn <- colnames(mt)
  colMax <- function(data) sapply(data, Type, na.rm = TRUE)
  mt <- by(mt, INDICES = row.names(mt), colMax)
    if(nc > 1){
      mt <- as.data.frame(do.call(rbind,mt))
    }
    if(nc == 1){
      mt <- as.matrix(mt)
      colnames(mt) <- cn
    }
  return(mt)
}





a
colMax <- function(data) sapply(data, max, na.rm = TRUE)
mt <- by(a, INDICES = a$X6, colMax)
mt <- as.data.frame(do.call(rbind,mt))
dim(mt)
table(duplicated(mt$X6))
