#' Project user-supplied locations
#'
#' Given an input dataframe containing locations (given in decimal degrees or meters),
#' projects these locations and, if desired, appends them to the dataframe.
#' May also be used to back-project to Latitudes/Longitudes provided the input was projected
#' using a Lambert azimuthal equal-area projection.
#' 
#' @param Input dataframe containing - at the minimum - Latitudes and Longitudes to be projected (or Y and X to be back-projected).
#' 
#' @param NamesIn character vector of length 2 specifying the column names of Latitude and Longitude fields in
#' the \code{Input}. \strong{Latitudes (or Y) name must be given first, e.g.:
#' 
#' \code{NamesIn=c('MyLatitudes','MyLongitudes')}}.
#' 
#' @param NamesOut optional. Names of the resulting columns in the output dataframe,
#' with order matching that of \code{NamesIn} (e.g., \code{NamesOut=c('Y','X')}).
#' 
#' @param append TRUE or FALSE. Should the projected locations be appended to the \code{Input}?
#' 
#' @param inv TRUE or FALSE. Should a back-projection be performed? In such case, locations must be given in meters
#' and have been projected using a Lambert azimuthal equal-area projection.
#' 
#'
#' @seealso 
#' \code{\link{assign_areas}}.
#' 
#' @examples
#' 
#'
#' #Generate a dataframe
#' MyData=data.frame(Lat=runif(100,min=-65,max=-50),
#'                   Lon=runif(100,min=20,max=40))
#' 
#' #Project data using a Lambert azimuthal equal-area projection
#' MyData=project_data(Input=MyData,NamesIn=c("Lat","Lon"))
#' 
#' 
#' @export

project_data=function(Input,NamesIn=NULL,NamesOut=NULL,append=TRUE,inv=FALSE){
  Input = as.data.frame(Input)
  
  if (is.null(NamesIn) == FALSE) {
    if (length(NamesIn) != 2) {
      stop("'NamesIn' should be a character vector of length 2")
    }
    if (any(NamesIn %in% colnames(Input) == FALSE)) {
      stop("'NamesIn' do not match column names in 'Input'")
    }
  }else{
    stop("'NamesIn' not specified")
  }
  
  if (is.null(NamesOut) == TRUE) {
    if(inv==FALSE){
      NamesOut=c("Y","X")
    }else{
      NamesOut=c("Latitude","Longitude")
    }
  }
  
  Locs = Input[, c(NamesIn[2], NamesIn[1])]
  
  Missing = which(is.na(Locs[, 1]) == TRUE | is.na(Locs[, 2]) == TRUE)
  if (length(Missing) > 1) {
    warning(paste0(length(Missing), " records are missing location and will not be projected\n"))
  }
  if (length(Missing) == 1) {
    warning("One record is missing location and will not be projected\n")
  }
  
  if(inv==FALSE){
    Impossible = which(Locs[, 1] > 180 | Locs[, 1] < (-180) | Locs[, 2] > 90 | Locs[, 2] < (-90))
    if (length(Impossible) > 1) {
      warning(paste0(length(Impossible), " records are not on Earth and will not be projected\n"))
      Locs[Impossible, ] = NA
    }
    if (length(Impossible) == 1) {
      warning("One record is not on Earth and will not be projected\n")
      Locs[Impossible, ] = NA
    }
  }else{
    Impossible=NULL
  }
  
  #Temporary fill
  tmpf=unique(c(Missing,Impossible))
  if(length(tmpf)>0){
    Locs[tmpf,1]=0
    Locs[tmpf,2]=-60
  }
  
  if(inv==FALSE){
    Locs=SpatialPoints(Locs,proj4string=CRS("+init=epsg:4326"))
    Locs=spTransform(Locs,CRS("+init=epsg:6932"))
    Locs=as.data.frame(coordinates(Locs))
    colnames(Locs)=c(NamesOut[2],NamesOut[1])
    Locs=Locs[,NamesOut]
  }else{
    Locs=SpatialPoints(Locs,proj4string=CRS("+init=epsg:6932"))
    Locs=spTransform(Locs,CRS("+init=epsg:4326"))
    Locs=as.data.frame(coordinates(Locs))
    colnames(Locs)=c(NamesOut[2],NamesOut[1]) 
    Locs=Locs[,NamesOut]
  }
  
  #Remove temporary fill
  if(length(tmpf)>0){
    Locs[tmpf,1]=NA
    Locs[tmpf,2]=NA
  }
  
  
  if(append==TRUE){
    out=cbind(Input,Locs)
    return(out)
  }else{
    return(Locs)
  }
}
