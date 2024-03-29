% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/caller.R
\name{get_call}
\alias{get_call}
\alias{get_function}
\title{Get information about currently executing calls.}
\usage{
get_call(
  env = caller(environment()),
  ifnotfound = stop("get_call: environment not found on stack")
)

get_function(
  env = caller(environment()),
  ifnotfound = stop("get_function: environment not found on stack")
)
}
\arguments{
\item{env}{An environment belonging to a currently executing
function call. By default, the \link{caller} of get_call itself
(so \code{get_call()} is equivalent to \code{get_call(environment())}.)}

\item{ifnotfound}{What to return if the call is not found. By
default an error is thrown.}
}
\value{
\code{get_call} returns a \link{dots} object, the first element of
which represents the function name and \link{caller} environment.

\code{get_function} returns a closure.
}
\description{
\code{get_call(env)}, given an environment associated with a currently
executing call, returns the function call and its arguments, as a
\link{dots} object. To replicate a call, the \link{dots} object returned can
be passed to \link{do}.

\code{get_function(env)} finds the function object associated with a
currently executing call.
}
\details{
\code{get_call} is meant to replace \code{\link{match.call}} and \code{\link{sys.call}};
its advantage is that it captures the environments bound to
arguments in addition to their written form.

\code{get_function} is similar to \code{\link{sys.function}}, but is keyed by
environment rather than number.
}
\examples{
# We might think of re-writing the start of [lm] like so:
LM <- function(formula, data, subset, weights, na.action, method = "qr",
               model = TRUE, x = FALSE, y = FALSE, qr = TRUE, singular.ok = TRUE, 
               contrasts = NULL, offset, ...) {
  cl <- get_call()
  mf <- do(model.frame,
           arg_list(formula, data, subset, weights, na.action, offset))

  z <- get.call()

  class(z) <- c("LM", class(z))
  z$call <- cl
  z
}

# and `update` like so:
update.LM <- function(object, formula., ...) {
  call <- object$call
  extras <- dots(...)
  call$formula <- forced_quo(update.formula(formula(object), formula.))
  do(call)
}
}
\seealso{
do dots caller
}
