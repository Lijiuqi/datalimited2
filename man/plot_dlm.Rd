% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_dlm.R
\name{plot_dlm}
\alias{plot_dlm}
\title{Plot data-limited stock assessment model output}
\usage{
plot_dlm(output)
}
\arguments{
\item{output}{Output from a \pkg{datalimited2} model}
}
\description{
Plots the results of data-limited stock assessment models implemented in the
\pkg{datalimited2} package.
}
\details{
Produces different plots for each model:

1. \strong{zBRT} - Plots show: (A) catch time series; (B) saturation time series; and
(C) B/BMSY time series.

2. \strong{OCOM} - Plots show: (A) catch time series; (B) viable r/K pairs;
(C) saturation time series; and (D) B/BMSY time series.

3. \strong{cMSY / BSM} - Plots show: (A) catch time series; (B) viable r/K pairs;
(C) B/BMSY time series; (D) F/FMSY time series; and (E) Kobe plot.

4. \strong{MS-cMSY} - Plots show: (A) viable and effort constrained r/K pairs;
(B) viable and effort constrained B/BMSY time series with final estimate.

In all plots, dashed lines show the reference point target (i.e., B/BMSY = 1,
F/FMSY = 1, or saturation = 0.5) and dotted lines show the overfishing limit
(i.e., B/BMSY = 0.5 or saturation = 0.25). If MSY is estimated, the median value
and 95\% confidence intervals are shown in the catch time series plot as a horizontal dashed line and
grey rectangle, respectively.
}
\examples{
# Fit OCOM to catch time series and plot output
output <- ocom(year=YELLSNEMATL$year, catch=YELLSNEMATL$catch, m=0.2)
plot_dlm(output)
}
