% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/project_data.r
\name{project_data}
\alias{project_data}
\title{Project user-supplied locations}
\usage{
project_data(
  Input,
  NamesIn = NULL,
  NamesOut = NULL,
  append = TRUE,
  inv = FALSE
)
}
\arguments{
\item{Input}{dataframe containing - at the minimum - Latitudes and Longitudes to be projected (or Y and X to be back-projected).}

\item{NamesIn}{character vector of length 2 specifying the column names of Latitude and Longitude fields in
the \code{Input}. \strong{Latitudes (or Y) name must be given first, e.g.:

\code{NamesIn=c('MyLatitudes','MyLongitudes')}}.}

\item{NamesOut}{optional. Names of the resulting columns in the output dataframe,
with order matching that of \code{NamesIn} (e.g., \code{NamesOut=c('Y','X')}).}

\item{append}{TRUE or FALSE. Should the projected locations be appended to the \code{Input}?}

\item{inv}{TRUE or FALSE. Should a back-projection be performed? In such case, locations must be given in meters
and have been projected using a Lambert azimuthal equal-area projection.}
}
\description{
Given an input dataframe containing locations (given in decimal degrees or meters),
projects these locations and, if desired, appends them to the dataframe.
May also be used to back-project to Latitudes/Longitudes provided the input was projected
using a Lambert azimuthal equal-area projection.
}
\examples{


#Generate a dataframe
MyData=data.frame(Lat=runif(100,min=-65,max=-50),
                  Lon=runif(100,min=20,max=40))

#Project data using a Lambert azimuthal equal-area projection
MyData=project_data(Input=MyData,NamesIn=c("Lat","Lon"))


}
\seealso{
\code{\link{assign_areas}}.
}
