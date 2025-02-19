#' Load CCAMLR statistical Areas, Subareas and Divisions
#'
#' Download the up-to-date spatial layer from the online CCAMLRGIS (\url{https://gis.ccamlr.org/}) and load it to your environment.
#' See examples for offline use. All layers use the Lambert azimuthal equal-area projection
#'  (\code{\link{CCAMLRp}})
#'
#' @seealso 
#' \code{\link{load_SSRUs}}, \code{\link{load_RBs}},
#' \code{\link{load_SSMUs}}, \code{\link{load_MAs}}, \code{\link{load_Coastline}},
#' \code{\link{load_MPAs}}, \code{\link{load_EEZs}}.
#' 
#' @export
#' @examples  
#' \donttest{
#' 
#' #When online:
#' ASDs=load_ASDs()
#' plot(st_geometry(ASDs))
#' 
#' #For offline use, see:
#' #https://github.com/ccamlr/CCAMLRGIS#32-offline-use
#' 
#' 
#' }

load_ASDs=function(){
  #NB: use http not https
  ccamlrgisurl="http://gis.ccamlr.org/geoserver/gis/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=gis:statistical_areas_6932&outputFormat=json"
  CCAMLR_data = st_read(ccamlrgisurl,quiet = TRUE)
  CCAMLR_data = st_transform(CCAMLR_data,6932)
  return(CCAMLR_data)
}

#' Load CCAMLR Small Scale Research Units
#'
#' Download the up-to-date spatial layer from the online CCAMLRGIS (\url{https://gis.ccamlr.org/}) and load it to your environment.
#' See examples for offline use. All layers use the Lambert azimuthal equal-area projection
#'  (\code{\link{CCAMLRp}})
#'
#' @seealso 
#' \code{\link{load_ASDs}}, \code{\link{load_RBs}},
#' \code{\link{load_SSMUs}}, \code{\link{load_MAs}}, \code{\link{load_Coastline}},
#' \code{\link{load_MPAs}}, \code{\link{load_EEZs}}.
#' 
#' @export
#' @examples  
#' \donttest{
#' 
#' #When online:
#' SSRUs=load_SSRUs()
#' plot(st_geometry(SSRUs))
#' 
#' #For offline use, see:
#' #https://github.com/ccamlr/CCAMLRGIS#32-offline-use
#' 
#' }
#' 
load_SSRUs=function(){
  #NB: use http not https
  ccamlrgisurl="http://gis.ccamlr.org/geoserver/gis/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=gis:ssrus_6932&outputFormat=json"
  CCAMLR_data = st_read(ccamlrgisurl,quiet = TRUE)
  CCAMLR_data = st_transform(CCAMLR_data,6932)
  return(CCAMLR_data)
}

#' Load the full CCAMLR Coastline
#' 
#' Download the up-to-date spatial layer from the online CCAMLRGIS (\url{https://gis.ccamlr.org/}) and load it to your environment.
#' See examples for offline use. All layers use the Lambert azimuthal equal-area projection
#'  (\code{\link{CCAMLRp}}).
#' Note that this coastline expands further north than \link{Coast}.
#' Sources: UK Polar Data Centre/BAS and Natural Earth. Projection: EPSG 6932.
#' More details here: \url{https://github.com/ccamlr/geospatial_operations}
#'
#' @seealso 
#' \code{\link{load_ASDs}}, \code{\link{load_SSRUs}}, \code{\link{load_RBs}},
#' \code{\link{load_SSMUs}}, \code{\link{load_MAs}},
#' \code{\link{load_MPAs}}, \code{\link{load_EEZs}}.
#' 
#' @references UK Polar Data Centre/BAS and Natural Earth.
#' 
#' @export
#' @examples  
#' \donttest{
#' 
#' #When online:
#' Coastline=load_Coastline()
#' plot(st_geometry(Coastline))
#' 
#' #For offline use, see:
#' #https://github.com/ccamlr/CCAMLRGIS#32-offline-use
#' 
#' }
#' 
load_Coastline=function(){
  #NB: use http not https
  ccamlrgisurl="http://gis.ccamlr.org/geoserver/gis/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=gis:coastline_v1_6932&outputFormat=json"
  CCAMLR_data = st_read(ccamlrgisurl,quiet = TRUE)
  CCAMLR_data = st_transform(CCAMLR_data,6932)
  return(CCAMLR_data)
}

#' Load CCAMLR Research Blocks
#'
#' Download the up-to-date spatial layer from the online CCAMLRGIS (\url{https://gis.ccamlr.org/}) and load it to your environment.
#' See examples for offline use. All layers use the Lambert azimuthal equal-area projection
#'  (\code{\link{CCAMLRp}})
#'
#' @seealso 
#' \code{\link{load_ASDs}}, \code{\link{load_SSRUs}},
#' \code{\link{load_SSMUs}}, \code{\link{load_MAs}}, \code{\link{load_Coastline}},
#' \code{\link{load_MPAs}}, \code{\link{load_EEZs}}.
#' 
#' @export
#' @examples  
#' \donttest{
#' 
#' #When online:
#' RBs=load_RBs()
#' plot(st_geometry(RBs))
#' 
#' #For offline use, see:
#' #https://github.com/ccamlr/CCAMLRGIS#32-offline-use
#' 
#' }
#' 
load_RBs=function(){
  #NB: use http not https
  ccamlrgisurl="http://gis.ccamlr.org/geoserver/gis/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=gis:research_blocks_6932&outputFormat=json"
  CCAMLR_data = st_read(ccamlrgisurl,quiet = TRUE)
  CCAMLR_data = st_transform(CCAMLR_data,6932)
  return(CCAMLR_data)
}

#' Load CCAMLR Small Scale Management Units
#'
#' Download the up-to-date spatial layer from the online CCAMLRGIS (\url{https://gis.ccamlr.org/}) and load it to your environment.
#' See examples for offline use. All layers use the Lambert azimuthal equal-area projection
#'  (\code{\link{CCAMLRp}})
#'
#' @seealso 
#' \code{\link{load_ASDs}}, \code{\link{load_SSRUs}}, \code{\link{load_RBs}},
#' \code{\link{load_MAs}}, \code{\link{load_Coastline}},
#' \code{\link{load_MPAs}}, \code{\link{load_EEZs}}.
#' 
#' @export
#' @examples  
#' \donttest{
#' 
#' #When online:
#' SSMUs=load_SSMUs()
#' plot(st_geometry(SSMUs))
#' 
#' #For offline use, see:
#' #https://github.com/ccamlr/CCAMLRGIS#32-offline-use
#' 
#' }
#' 
load_SSMUs=function(){
  #NB: use http not https
  ccamlrgisurl="http://gis.ccamlr.org/geoserver/gis/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=gis:ssmus_6932&outputFormat=json"
  CCAMLR_data = st_read(ccamlrgisurl,quiet = TRUE)
  CCAMLR_data = st_transform(CCAMLR_data,6932)
  return(CCAMLR_data)
}

#' Load CCAMLR Management Areas
#'
#' Download the up-to-date spatial layer from the online CCAMLRGIS (\url{https://gis.ccamlr.org/}) and load it to your environment.
#' See examples for offline use. All layers use the Lambert azimuthal equal-area projection
#'  (\code{\link{CCAMLRp}})
#'
#' @seealso 
#' \code{\link{load_ASDs}}, \code{\link{load_SSRUs}}, \code{\link{load_RBs}},
#' \code{\link{load_SSMUs}}, \code{\link{load_Coastline}},
#' \code{\link{load_MPAs}}, \code{\link{load_EEZs}}.
#' 
#' @export
#' @examples  
#' \donttest{
#' 
#' #When online:
#' MAs=load_MAs()
#' plot(st_geometry(MAs))
#' 
#' #For offline use, see:
#' #https://github.com/ccamlr/CCAMLRGIS#32-offline-use
#' 
#' }
#' 
load_MAs=function(){
  #NB: use http not https
  ccamlrgisurl="http://gis.ccamlr.org/geoserver/gis/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=gis:omas_6932&outputFormat=json"
  CCAMLR_data = st_read(ccamlrgisurl,quiet = TRUE)
  CCAMLR_data = st_transform(CCAMLR_data,6932)
  return(CCAMLR_data)
}

#' Load CCAMLR Marine Protected Areas
#'
#' Download the up-to-date spatial layer from the online CCAMLRGIS (\url{https://gis.ccamlr.org/}) and load it to your environment.
#' See examples for offline use. All layers use the Lambert azimuthal equal-area projection
#'  (\code{\link{CCAMLRp}})
#'
#' @seealso 
#' \code{\link{load_ASDs}}, \code{\link{load_SSRUs}}, \code{\link{load_RBs}},
#' \code{\link{load_SSMUs}}, \code{\link{load_MAs}}, \code{\link{load_Coastline}},
#' \code{\link{load_EEZs}}.
#' 
#' @export
#' @examples  
#' \donttest{
#' 
#' #When online:
#' MPAs=load_MPAs()
#' plot(st_geometry(MPAs))
#' 
#' #For offline use, see:
#' #https://github.com/ccamlr/CCAMLRGIS#32-offline-use
#' 
#' }
#' 

load_MPAs=function(){
  #NB: use http not https
  ccamlrgisurl="http://gis.ccamlr.org/geoserver/gis/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=gis:mpas_6932&outputFormat=json"
  CCAMLR_data = st_read(ccamlrgisurl,quiet = TRUE)
  CCAMLR_data = st_transform(CCAMLR_data,6932)
  return(CCAMLR_data)
}

#' Load Exclusive Economic Zones
#' 
#' Download the up-to-date spatial layer from the online CCAMLRGIS (\url{https://gis.ccamlr.org/}) and load it to your environment.
#' See examples for offline use. All layers use the Lambert azimuthal equal-area projection
#'  (\code{\link{CCAMLRp}})
#'
#' @seealso 
#' \code{\link{load_ASDs}}, \code{\link{load_SSRUs}}, \code{\link{load_RBs}},
#' \code{\link{load_SSMUs}}, \code{\link{load_MAs}}, \code{\link{load_Coastline}},
#' \code{\link{load_MPAs}}.
#' 
#' @export
#' @examples  
#' \donttest{
#' 
#' #When online:
#' EEZs=load_EEZs()
#' plot(st_geometry(EEZs))
#' 
#' #For offline use, see:
#' #https://github.com/ccamlr/CCAMLRGIS#32-offline-use
#' 
#' }
#' 

load_EEZs=function(){
  #NB: use http not https
  ccamlrgisurl="http://gis.ccamlr.org/geoserver/gis/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=gis:eez_6932&outputFormat=json"
  CCAMLR_data = st_read(ccamlrgisurl,quiet = TRUE)
  CCAMLR_data = st_transform(CCAMLR_data,6932)
  return(CCAMLR_data)
}

#' Load Bathymetry data
#' 
#' Download the up-to-date projected GEBCO data from the online CCAMLRGIS (\url{https://gis.ccamlr.org/}) and load it to your environment.
#' This functions can be used in two steps, to first download the data and then use it. If you keep the downloaded data, you can then
#' re-use it in all your scripts.
#' 
#' To download the data, you must either have set your working directory using \code{\link[base]{setwd}}, or be working within an Rproject.
#' In any case, your file will be downloaded to the folder path given by \code{\link[base]{getwd}}.
#' 
#' It is strongly recommended to first download the lowest resolution data (set \code{Res=5000}) to ensure it is working as expected.
#' 
#' To re-use the downloaded data, you must provide the full path to that file, for example:
#' 
#' \code{LocalFile="C:/Desktop/GEBCO2024_5000.tif"}.
#' 
#' This data was reprojected from the original GEBCO Grid after cropping at 40 degrees South. Projection was made using the Lambert
#' azimuthal equal-area projection (\code{\link{CCAMLRp}}),
#' and the data was aggregated at several resolutions.
#' 
#' @param LocalFile To download the data, set to \code{FALSE}. To re-use a downloaded file, set to the full path of the file 
#' (e.g., \code{LocalFile="C:/Desktop/GEBCO2024_5000.tif"}).
#' @param Res Desired resolution in meters. May only be one of: 500, 1000, 2500 or 5000.
#' @return Bathymetry raster.
#' 
#' @seealso
#' \code{\link{add_col}}, \code{\link{add_Cscale}}, \code{\link{Depth_cols}}, \code{\link{Depth_cuts}},
#' \code{\link{Depth_cols2}}, \code{\link{Depth_cuts2}}, \code{\link{get_depths}},
#' \code{\link{create_Stations}}, \code{\link{get_iso_polys}},
#' \code{\link{SmallBathy}}.
#' 
#' @references GEBCO Compilation Group (2024) GEBCO 2024 Grid (doi:10.5285/1c44ce99-0a0d-5f4f-e063-7086abc0ea0f)
#' 
#' @export
#' @examples  
#' \donttest{
#' 
#' #The examples below are commented. To test, remove the '#'.
#' 
#' ##Download the data. It will go in the folder given by getwd():
#' #Bathy=load_Bathy(LocalFile = FALSE,Res=5000)
#' #plot(Bathy, breaks=Depth_cuts,col=Depth_cols,axes=FALSE)
#' 
#' ##Re-use the downloaded data (provided it's here: "C:/Desktop/GEBCO2024_5000.tif"):
#' #Bathy=load_Bathy(LocalFile = "C:/Desktop/GEBCO2024_5000.tif")
#' #plot(Bathy, breaks=Depth_cuts,col=Depth_cols,axes=FALSE)
#' 
#' }
#' 

load_Bathy=function(LocalFile,Res=5000){
  if(LocalFile==FALSE){
    if(Res%in%c(500,1000,2500,5000)==FALSE){stop("'Res' should be one of: 500, 1000, 2500 or 5000")}
    Fname=paste0("GEBCO2024_",Res,".tif")
    url=paste0("https://gis.ccamlr.org/geoserver/www/",Fname)
    OldTimeOut=getOption("timeout")
    options(timeout = max(3600, OldTimeOut))
    download.file(url, destfile=paste0(getwd(),"/",Fname),mode="wb")
    on.exit(options(timeout = OldTimeOut))          
    Bathy=terra::rast(paste0(getwd(),"/",Fname))
  }else{
    if(file.exists(LocalFile)==FALSE){stop("File not found. Either the file is missing or 'LocalFile' is not properly set.")}
    Bathy=terra::rast(LocalFile)
  }
  return(Bathy)
}

#' Small bathymetry dataset
#'
#' Bathymetry dataset derived from the GEBCO 2024 (see \url{https://www.gebco.net/}) dataset.
#' Subsampled at a 10,000m resolution. Projected using the CCAMLR standard projection (\code{\link{CCAMLRp}}).
#' To highlight the Fishable Depth range, use \code{\link{Depth_cols2}} and \code{\link{Depth_cuts2}}.
#' To be only used for large scale illustrative purposes. Please refer to \code{\link{load_Bathy}}
#' to get higher resolution data.
#' 
#' 
#' @usage SmallBathy()
#' @format raster
#' @export
#' @examples terra::plot(SmallBathy(),breaks=Depth_cuts,col=Depth_cols,axes=FALSE,box=FALSE)
#' @seealso \code{\link{load_Bathy}}, \code{\link{add_col}}, \code{\link{add_Cscale}}, \code{\link{Depth_cols}},
#' \code{\link{Depth_cuts}},
#' \code{\link{Depth_cols2}}, \code{\link{Depth_cuts2}}, \code{\link{get_depths}}, \code{\link{create_Stations}}.
#' @references GEBCO Compilation Group (2024) GEBCO 2024 Grid (doi:10.5285/1c44ce99-0a0d-5f4f-e063-7086abc0ea0f)
#' 

SmallBathy=function(){
  terra::rast(system.file("extdata/SmallBathy.tif", package="CCAMLRGIS"))
}
