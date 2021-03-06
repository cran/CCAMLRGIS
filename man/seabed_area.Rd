% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/seabed_area.R
\name{seabed_area}
\alias{seabed_area}
\title{Calculate planimetric seabed area}
\usage{
seabed_area(Bathy, Polys, depth_classes = c(-600, -1800))
}
\arguments{
\item{Bathy}{bathymetry raster with the appropriate \code{\link[CCAMLRGIS:CCAMLRp]{projection}},
such as \code{\link[CCAMLRGIS:SmallBathy]{this one}}. It is recommended to use a raster of higher
resolution than \code{\link{SmallBathy}}.}

\item{Polys}{polygon(s) within which the areas of depth strata are computed.}

\item{depth_classes}{numeric vector of strata depths. for example, \code{depth_classes=c(-600,-1000,-2000)}.
If the values \code{-600,-1800} are given within \code{depth_classes}, the computed area will be labelled as 'Fishable_area'.}
}
\value{
dataframe with the name of polygons in the first column and the area for each strata in the following columns.
Note that polygon names are taken from the first column in the data of the input SpatialPolygonDataframe.
}
\description{
Calculate planimetric seabed area within polygons and depth strata in square kilometers.
}
\examples{
\donttest{


#Example 1: Compute fishable area in Research Blocks using the SmallBathy (not recommended)

RBs=load_RBs() 
RBs@data[,1]=RBs$GAR_Short_Label #Take the 'GAR_Short_Label' as polygon names
FishDepth=seabed_area(SmallBathy,RBs)
#View(FishDepth)

#Example 2: Compute various strata areas within user-generated polygons

MyPolys=create_Polys(PolyData,Densify=TRUE)
FishDepth=seabed_area(SmallBathy,MyPolys,depth_classes=c(0,-200,-600,-1800,-3000,-5000))
#View(FishDepth)


}

}
\seealso{
\code{\link{SmallBathy}}, \code{\link{create_Polys}}, \code{\link{load_RBs}}.
}
