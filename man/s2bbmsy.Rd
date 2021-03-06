% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/s2bbmsy.R
\name{s2bbmsy}
\alias{s2bbmsy}
\title{Convert saturation to B/BMSY}
\usage{
s2bbmsy(s)
}
\arguments{
\item{s}{A vector of saturation values}
}
\value{
A vector of B/BMSY values
}
\description{
Converts saturation  to B/BMSY. Note: S = 1 - depletion = B / K = 0.5 * B/BMSY.
}
\examples{
# Convert saturation of 0.75 to B/BMSY
s2bbmsy(0.75)
}
