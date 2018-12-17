
a <- data.frame()

AssayNormal <- function(a){
  m <- mean(colSums(a))
  for(i in 1:ncol(a)){
    mi <- mean(a[,i])
    a[,i] <- a[,i]*m/mi
  }
  return(a)
}
