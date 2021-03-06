#' @export
logLik.ivreg <- function(object, ...) {
  res <- object$residuals
  p <- object$rank
  w <- object$weights

  N <- length(res)

  if (is.null(w)) {
    w <- rep.int(1, N)
  } else {
    excl <- w == 0
    if (any(excl)) {
      res <- res[!excl]
      N <- length(res)
      w <- w[!excl]
    }
  }
  N0 <- N

  val <- 0.5 * (sum(log(w)) - N * (log(2 * pi) + 1 - log(N) + log(sum(w * res^2))))

  attr(val, "nall") <- N0
  attr(val, "nobs") <- N
  attr(val, "df") <- p + 1
  class(val) <- "logLik"

  val
}


#' @importFrom insight find_parameters
#' @export
logLik.plm <- function(object, ...) {
  res <- object$residuals
  w <- object$weights

  N <- length(res)

  if (is.null(w)) {
    w <- rep.int(1, N)
  } else {
    excl <- w == 0
    if (any(excl)) {
      res <- res[!excl]
      N <- length(res)
      w <- w[!excl]
    }
  }
  N0 <- N

  val <- 0.5 * (sum(log(w)) - N * (log(2 * pi) + 1 - log(N) + log(sum(w * res^2))))

  attr(val, "nall") <- N0
  attr(val, "nobs") <- N
  attr(val, "df") <- length(insight::find_parameters(object, effects = "fixed", flatten = TRUE))
  class(val) <- "logLik"

  val
}

#' @export
logLik.cpglm <- logLik.plm



#' @importFrom stats residuals
#' @export
logLik.iv_robust <- function(object, ...) {
  res <- stats::residuals(object)
  p <- object$rank
  w <- object$weights

  N <- length(res)

  if (is.null(w)) {
    w <- rep.int(1, N)
  } else {
    excl <- w == 0
    if (any(excl)) {
      res <- res[!excl]
      N <- length(res)
      w <- w[!excl]
    }
  }
  N0 <- N

  val <- 0.5 * (sum(log(w)) - N * (log(2 * pi) + 1 - log(N) + log(sum(w * res^2))))

  attr(val, "nall") <- N0
  attr(val, "nobs") <- N
  attr(val, "df") <- p + 1
  class(val) <- "logLik"

  val
}
