#' Likelihood ratio tests for comparing nested cure models
#'
#' Function for doing likelihood ratio tests for class \code{cm}.
#' @param model1 A model fitted by the fit.cure.model-function
#' @param model2 Another model fitted by the fit.cure.model-function for comparison.
#' @return An object of class "anova" containing the degrees of freedom and log-likelihoods of the two models,
#' the difference in degrees of freedom, the likelihood ratio Chi-squared statistic (twice the difference in log-likelihoods)
#' , and the p-value for the asymptotic likelihood ratio test.
#' @details One of the models must be nested within the other model,
#' and both models must be fitted to the same data set.
#' @export

lrtest.cm <- function(model1, model2) {
  if (!dim(model1$data)[1] == dim(model2$data)[1]) {
    stop("Models not fitted to same dataset")
  } else {
    if (length(unlist(model1$coefs)) == length(unlist(model2$coefs))) {
      stop("One of the models are not nested within the other model.")
    } else {
      lrt <- matrix(rep(NA, 10), ncol = 5)
      colnames(lrt) <- c("#Df", "LogLik", "Df", "Chisq", "Pr(>Chisq)")
      rownames(lrt) <- c("Model 1", "Model 2")
      lrt[, 1] <-
        c(length(unlist(model1$coefs)), length(unlist(model2$coefs)))
      lrt[, 2] <- c(model1$ML, model2$ML)
      lrt[, 3] <- c(NA, abs(lrt[2, 1] - lrt[1, 1]))
      lrt[, 4] <- c(NA, 2 * abs(lrt[2, 2] - lrt[1, 2]))
      lrt[, 5] <- c(NA, 1 - pchisq(lrt[2, 4], df = lrt[2, 3]))
      title <- "Likelihood ratio test\n"
      structure(
        as.data.frame(lrt),
        heading = c("Likelihood ratio test\n"),
        class = c("anova", "data.frame")
      )
    }
  }
}
