#' Calculates AUC (Area under the Curve) using trapezoidal approximation
#' @param hr.v a vector of hit rates
#' @param far.v A vector of false alarm rates
#' @export
#' @examples
#'
#' # Calculate the AUC for a vector of hit rates and false alarm rates
#'
#' auc(hr.v = c(.1, .3, .5, .7), far.v = c(.05, .1, .15, .3))
#'
#'

auc <- function(hr.v, far.v) {

  hr.order <- order(hr.v)

  hr.v <- hr.v[hr.order]
  far.v <- far.v[hr.order]

  hr.v <- c(0, hr.v, 1)
  far.v <- c(0, far.v, 1)

  # Remove bad (i.e.. non-increasing values)

  hr.v.n <- hr.v[1]
  far.v.n <- far.v[1]

  if(all(is.finite(hr.v) & is.finite(far.v))) {

  for(i in 2:length(hr.v)) {

    if(hr.v[i] >= hr.v.n[length(hr.v.n)] & far.v[i] >= far.v.n[length(far.v.n)]) {

      hr.v.n <- c(hr.v.n, hr.v[i])
      far.v.n <- c(far.v.n, far.v[i])

    }


  }

  hr.v <- hr.v.n
  far.v <- far.v.n
  n <- length(hr.v)


  auc.i <- sum((far.v[2:n] - far.v[1:(n - 1)]) * hr.v[1:(n - 1)] +
    (far.v[2:n] - far.v[1:(n - 1)]) * (hr.v[2:(n)] - hr.v[1:(n-1)]) / 2)

  } else {

    auc.i <- NA
}

  return(auc.i)

}
