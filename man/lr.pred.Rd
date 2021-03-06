% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/lrpred_function.R
\name{lr.pred}
\alias{lr.pred}
\title{Calculates predictions from logistic regression}
\usage{
lr.pred(formula, data.train, data.test = NULL, lr.model = NULL,
  thresholds = 0.5)
}
\arguments{
\item{formula}{a formula}

\item{data.train}{A training dataset}

\item{data.test}{A testing dataset}

\item{lr.model}{An optional logistic regression model created from glm(family = "binomial")}

\item{thresholds}{A vector of decision thresholds}
}
\description{
Calculates predictions from logistic regression
}

