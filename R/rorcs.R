
# rORCS function
################################################################################

#' Refined ORCS approach
#'
#' Estimates stock status (i.e., under, fully, or overexploited) from 12 stock- and
#' fishery-related predictors using the refined ORCS approach from Free et al. 2017.
#' Stock status categories are defined as follows: (1) B/BMSY > 1.5 = underexploited;
#' (2) 0.5 < B/BMSY < 1.5 = fully exploited; and (3) B/BMSY < 0.5 = overexploited.
#'
#' @param scores A numeric vector of length twelve containing scores for the
#' following "Table of Attributes" questions (see Free et al. 2017 for more details):
#' \itemize{
#'   \item{TOA 1 - Status of assessed stocks in fishery}
#'   \item{TOA 3 - Behavior affecting capture (2 or 3 only)}
#'   \item{TOA 5 - Discard rate}
#'   \item{TOA 6 - Targeting intensity}
#'   \item{TOA 7 - M compared to dominant species}
#'   \item{TOA 8 - Occurence in catch}
#'   \item{TOA 9 - Value (US$/lb) - continuous value}
#'   \item{TOA 10 - Recent trends in catch}
#'   \item{TOA 11 - Habitat loss}
#'   \item{TOA 12 - Recent trend in effort}
#'   \item{TOA 13 - Recent trend in abundance index}
#'   \item{TOA 14 - Proportion of population protected}
#' }
#' @return A data frame containing the probability that a stock is under, fully,
#' or overexploited with stock status identified by the most probable category.
#' @details The refined ORCS approach (rORCS) uses a boosted classification tree
#' model trained on the RAM Legacy Database to estimate stock status (i.e., under, fully,
#' or overexploited) from twelve stock- and fishery-related predictors, the
#' most important of which are the value of the taxa, status of the assessed
#' stocks in the fishery, targeting intensity, discard rate, and occurrence in
#' the catch (Free et al. 2017). The approach also includes a step for estimating
#' the overfishing limit (OFL) as the product of a historical catch statistic and
#' scalar based on stock status and risk policy.
#' @references Free CM, Jensen OP, Wiedenmann J, Deroba JJ (2017) The
#' refined ORCS approach: a catch-based method for estimating stock status
#' and catch limits for data-poor fish stocks. \emph{Fisheries Research} 193: 60-70.
#' \url{https://doi.org/10.1016/j.fishres.2017.03.017}
#' @examples
#' # Create vector of TOA scores and estimate status
#' scores <- c(1, 2, NA, 2, 2, 3, 1.93, 2, 1, 2, 1, 3)
#' rorcs(scores)
#' @export
rorcs <- function(scores){

  # Check for errors in TOA scores
  error.flag <- F
  if(!scores[2]%in%c(NA,2,3)){
    cat("Error: The answer to TOA #3 must be 2, 3, or NA. It is currently ", scores[2], ".", sep="", fill=T)
    error.flag <- T
  }
  pos.to.check <- c(1,3:6,8:12)
  toa.to.check <- c(1, 5:8, 10:14)
  for(i in 1:length(pos.to.check)){
    index <- pos.to.check[i]
    if(!scores[index]%in%c(NA,1,2,3)){
      cat("Error: The answer to TOA #", toa.to.check[i],  " must be 1, 2, 3, or NA. It is currently ", scores[index], ".", sep="", fill=T)
      error.flag <- T
    }
  }

  # If there is an error, create empty output
  if(error.flag==T){
    # Create output
    out <- data.frame(status="error", p.under=NA, p.fully=NA, p.over=NA)
  # If there are no errors, predict stock status
  }else{
    # Build TOA dataframe
    scores.df <- as.data.frame(matrix(scores, nrow=1))
    colnames(scores.df) <- c("toa1", "toa3", "toa5", "toa6",
                             "toa7", "toa8", "toa9b", "toa10a",
                             "toa11", "toa12", "toa13", "toa14")

    # Predict status probabilities
    probs <- dismo::predict(rorcs_model, newdata=scores.df, type="prob", na.action=NULL)
    colnames(probs) <- c("p.under", "p.fully", "p.over")

    # Identify most-likely status
    status <- gsub("p.", "", colnames(probs)[which.max(probs)])

    # Create output
    out <- cbind(status, probs)
  }

  # Return status info
  return(out)

}

