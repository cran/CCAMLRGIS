## ---- echo = FALSE, message = FALSE-------------------------------------------
library(CCAMLRGIS)
set.seed(12345)

## ----eval=FALSE---------------------------------------------------------------
#  install.packages("CCAMLRGIS")

## ----eval=T-------------------------------------------------------------------
library(CCAMLRGIS)

## ----fig.align="center",out.width="100%",message=FALSE,dpi=200,eval=TRUE------
#Map with axes, to understand projection

#Set the figure margins as c(bottom, left, top, right)
Mypar<-par(mai=c(0.55,0.7,0.2,0.45),xpd=TRUE)
#plot entire Coastline
plot(Coast[Coast$ID=='All',],col='grey',lwd=0.1)
#Add reference grid
add_RefGrid(bb=bbox(Coast[Coast$ID=='All',]),ResLat=10,ResLon=20,LabLon=-40,fontsize=0.4,lwd=0.5)
#add axes and labels
axis(1,pos=0,at=seq(-4000000,4000000,by=1000000),tcl=-0.15,labels=FALSE,lwd=0.8,lwd.ticks=0.8,col='blue')
axis(2,pos=0,at=seq(-4000000,4000000,by=1000000),tcl=-0.15,labels=FALSE,lwd=0.8,lwd.ticks=0.8,col='blue')
text(seq(1000000,4000000,by=1000000),0,seq(1,4,by=1),cex=0.75,col='blue',adj=c(0.5,1.75))
text(seq(-4000000,-1000000,by=1000000),0,seq(-4,-1,by=1),cex=0.75,col='blue',adj=c(0.5,1.75))
text(0,seq(1000000,4000000,by=1000000),seq(1,4,by=1),cex=0.75,col='blue',adj=c(1.75,0.5))
text(0,seq(-4000000,-1000000,by=1000000),seq(-4,-1,by=1),cex=0.75,col='blue',adj=c(1.75,0.5))
text(0,0,0,cex=0.75,col='blue',adj=c(-0.5,-0.5))
text(5200000,0,expression('x ('*10^6~'m)'),cex=0.75,col='blue')
text(0,4700000,expression('y ('*10^6~'m)'),cex=0.75,col='blue')
par(Mypar)


## ----eval=FALSE---------------------------------------------------------------
#  
#  #Step 1: Download the global GEBCO Grid, from:
#  #http://www.gebco.net/data_and_products/gridded_bathymetry_data/
#  
#  #Step 2: load the 'raster' and 'rgeos' libraries
#  library(raster)
#  library(rgeos)
#  
#  #Step 3: Read the data
#  G=raster(" Path to the folder containing the GEBCO data /GEBCO_YearXXXX.nc")
#  
#  #Step 4: Crop the data to below 40 degrees South
#  G=crop(G,extent(-180,180,-90,-40))
#  
#  #Step 5: Project the data using the CCAMLR projection
#  Gp=projectRaster(G, crs=proj4string(CCAMLRp))
#  
#  #Step 6: Mask the data using a buffered contour of the Convention area
#  #load ASDs, buffer them and extract the outer polygon (first polygon within the list of polygons)
#  ASDs=load_ASDs()
#  #Build 500km contour
#  Contour=gBuffer(ASDs,width=500000,quadsegs = 25)
#  #Extract outer boundary (first polygon)
#  pol=Contour@polygons[[1]]@Polygons[1]
#  pol=Polygons(pol,ID='1')
#  pol=SpatialPolygons(list(pol),proj4string = CRS(CCAMLRp))
#  #Apply mask
#  Gpm=mask(Gp, pol)
#  
#  #Step 7: Clamp the raster to exclude values higher than 500m
#  Gpmc=clamp(Gpm, upper=500,useValues=FALSE)
#  
#  #At this point, you may export the data and use it in its native resolution
#  #Export:
#  writeRaster(Gpmc,"GEBCOpmc.tif")
#  #to re-Import:
#  Gpmc=raster(' Path to the folder containing the GEBCO data /GEBCOpmc.tif')
#  
#  #Or, resample it (e.g., at a 500m resolution, using the nearest neighbor method):
#  newR=raster(crs=crs(Gpmc), ext=extent(Gpmc), resolution=500)
#  Gr=resample(Gpmc,newR,method="ngb")
#  #Export:
#  writeRaster(Gr,"GEBCOpmcr500NN.tif")
#  #to re-Import:
#  Gpmcr500N=raster(' Path to the folder containing the data /GEBCOpmc.tif')
#  

## ----fig.align="center",out.width="100%",message=FALSE,dpi=200,eval=TRUE------
#Load ASDs and EEZs
ASDs=load_ASDs()
EEZs=load_EEZs()
#Set the figure margins as c(bottom, left, top, right)
Mypar<-par(mai=c(0,0.4,0,0))
#Plot the bathymetry
plot(SmallBathy,breaks=Depth_cuts,col=Depth_cols,legend=FALSE,axes=FALSE,box=FALSE)
#Add color scale
add_Cscale(height=65,fontsize=0.4,offset=600,width=25,maxVal=-1,lwd=0.5)
#Add reference grid
add_RefGrid(bb=bbox(SmallBathy),ResLat=10,ResLon=20,LabLon=0,fontsize=0.4,lwd=0.5)
#Add ASD and EEZ boundaries
plot(ASDs,add=TRUE,lwd=0.5,border='red')
plot(EEZs,add=TRUE,lwd=0.5,border='red')
#Add coastline (for all ASDs)
plot(Coast[Coast$ID=='All',],col='grey',lwd=0.01,add=TRUE)
#Add ASD labels
add_labels(mode='auto',layer='ASDs',fontsize=0.3,col='red')
par(Mypar)

## ----fig.align="center",out.width="100%",message=FALSE,dpi=200,eval=TRUE------
#Load ASDs (if you haven't yet, uncomment the following line)
# ASDs=load_ASDs()
#Subsample ASDs to only keep Subarea 48.6
S486=ASDs[ASDs$GAR_Short_Label=='486',]
#Crop bathymetry to match the extent of S486
B486=raster::crop(SmallBathy,S486)
#Optional: get the maximum depth in that area to constrain the color scale
minD=raster::minValue(B486)
#Set the figure margins as c(bottom, left, top, right)
Mypar<-par(mai=c(0,0.2,0,0))
#Plot the bathymetry
plot(B486,breaks=Depth_cuts,col=Depth_cols,legend=FALSE,axes=FALSE,box=FALSE)
#Add color scale
add_Cscale(height=65,fontsize=0.4,offset=600,width=23,lwd=0.5,minVal=minD,maxVal=-1)
#Add coastline (for Subarea 48.6 only)
plot(Coast[Coast$ID=='48.6',],col='grey',lwd=0.01,add=TRUE)
#Add reference grid
add_RefGrid(bb=bbox(B486),ResLat=5,ResLon=10,fontsize=0.4,lwd=0.5,offset = 100000)
#Add Subarea 48.6 boundaries
plot(S486,add=TRUE,lwd=0.5,border='red')
#Add a -2000m contour
raster::contour(B486,levels=-2000,add=TRUE,lwd=0.5,labcex=0.3)
#Add single label at the centre of the polygon (see ?Labels)
text(Labels$x[Labels$t=='48.6'],Labels$y[Labels$t=='48.6'],labels='48.6',col='red')
par(Mypar)

## ----eval=FALSE---------------------------------------------------------------
#  getwd()

## ----eval=FALSE---------------------------------------------------------------
#  ?create_Points

## ----fig.align="center",out.width="100%",message=FALSE,dpi=200,eval=TRUE------

#Prepare layout for 4 sub-plots
Mypar<-par(mfrow=c(2,2),mai=c(0,0.01,0.2,0.01))

#Example 1: Simple points with labels
MyPoints=create_Points(Input=PointData)
plot(MyPoints,main='Example 1',cex.main=0.5,cex=0.5,lwd=0.5)
text(MyPoints$x,MyPoints$y,MyPoints$name,adj=c(0.5,-0.5),xpd=TRUE,cex=0.5)
box()

#Example 2: Simple points with labels, highlighting one group of points with the same name
MyPoints=create_Points(Input=PointData)
plot(MyPoints,main='Example 2',cex.main=0.5,cex=0.5,lwd=0.5)
text(MyPoints$x,MyPoints$y,MyPoints$name,adj=c(0.5,-0.5),xpd=TRUE,cex=0.5)
plot(MyPoints[MyPoints$name=='four',],bg='red',pch=21,cex=1,add=TRUE)
box()

#Example 3: Buffered points with radius proportional to catch
MyPoints=create_Points(Input=PointData,Buffer=1*PointData$Catch)
plot(MyPoints,col='green',main='Example 3',cex.main=0.5,cex=0.5,lwd=0.5)
text(MyPoints$x,MyPoints$y,MyPoints$name,adj=c(0.5,0.5),xpd=TRUE,cex=0.5)
box()

#Example 4: Buffered points with radius proportional to catch and clipped to the Coast
MyPoints=create_Points(Input=PointData,Buffer=2*PointData$Catch,Clip=TRUE)
plot(MyPoints,col='cyan',main='Example 4',cex.main=0.5,cex=0.5,lwd=0.5)
plot(Coast[Coast$ID=='All',],add=TRUE,col='grey',lwd=0.5)
box()
par(Mypar)

## ----eval=FALSE---------------------------------------------------------------
#  ?create_Lines

## ----eval=FALSE---------------------------------------------------------------
#  #If your data contains line end locations in separate columns, you may reformat it as follows:
#  
#  #Example data:
#  MyData=data.frame(
#    Line=c(1,2),
#    Lat_Start=c(-60,-65),
#    Lon_Start=c(-10,5),
#    Lat_End=c(-61,-66),
#    Lon_End=c(-2,2)
#  )
#  
#  #Reformat to us as input in create_Lines as:
#  Input=data.frame(
#    Line=c(MyData$Line,MyData$Line),
#    Lat=c(MyData$Lat_Start,MyData$Lat_End),
#    Lon=c(MyData$Lon_Start,MyData$Lon_End)
#  )

## ----fig.align="center",out.width="100%",message=FALSE,dpi=200,eval=TRUE,fig.height=1----

#Prepare layout for 3 sub-plots
Mypar<-par(mai=c(0,0.01,0.2,0.01),mfrow=c(1,3))

#Example 1: Simple and non-densified lines
MyLines=create_Lines(Input=LineData)
plot(MyLines,col=rainbow(length(MyLines)),main='Example 1',cex.main=0.5,lwd=1)
box()

#Example 2: Simple and densified lines (note the curvature of the purple line)
MyLines=create_Lines(Input=LineData,Densify=TRUE)
plot(MyLines,col=rainbow(length(MyLines)),main='Example 2',cex.main=0.5,lwd=1)
box()

#Example 3: Densified, buffered and clipped lines
MyLines=create_Lines(Input=LineData,Densify=TRUE,Buffer=c(10,40,50,80,100),Clip=TRUE)
plot(MyLines,col=rainbow(length(MyLines)),main='Example 3',cex.main=0.5,lwd=1)
plot(Coast[Coast$ID=='All',],col='grey',add=TRUE,lwd=0.5)
box()
par(Mypar)

## ----fig.align="center",out.width="100%",message=FALSE,dpi=200,eval=TRUE,fig.height=2----

#Set the figure margins as c(bottom, left, top, right)
Mypar<-par(mai=c(0.01,0.01,0.01,0.01))

#Buffer merged lines
MyLines=create_Lines(Input=LineData,Buffer=10,SeparateBuf=FALSE)
#The resulting polygon has an area of:
MyLines$Buffered_AreaKm2

plot(MyLines,col='green',lwd=1)
box()
par(Mypar)

## ----eval=FALSE---------------------------------------------------------------
#  ?create_Polys

## ----fig.align="center",out.width="100%",message=FALSE,dpi=200,eval=TRUE,fig.height=1----

#Prepare layout for 3 sub-plots
Mypar<-par(mfrow=c(1,3),mai=c(0,0.01,0.2,0.01))

#Example 1: Simple and non-densified polygons
MyPolys=create_Polys(Input=PolyData,Densify=FALSE)
plot(MyPolys,col='blue',main='Example 1',cex.main=0.5,lwd=0.5)
text(MyPolys$Labx,MyPolys$Laby,MyPolys$ID,col='white',cex=0.5)
box()

#Example 2: Simple and densified polygons (note the curvature of iso-latitude lines)
MyPolys=create_Polys(Input=PolyData)
plot(MyPolys,col='red',main='Example 2',cex.main=0.5,lwd=0.5)
text(MyPolys$Labx,MyPolys$Laby,MyPolys$ID,col='white',cex=0.5)
box()

#Example 3: Buffered and clipped polygons
MyPolysBefore=create_Polys(Input=PolyData,Buffer=c(10,-15,120))
MyPolysAfter=create_Polys(Input=PolyData,Buffer=c(10,-15,120),Clip=TRUE)
plot(MyPolysBefore,col='green',main='Example 3',cex.main=0.5,lwd=0.5)
plot(Coast[Coast$ID=='All',],add=TRUE,lwd=0.5)
plot(MyPolysAfter,col='orange',add=TRUE,lwd=0.5)
text(MyPolysAfter$Labx,MyPolysAfter$Laby,MyPolysAfter$ID,col='white',cex=0.5)
box()
par(Mypar)

## ----eval=FALSE---------------------------------------------------------------
#  ?create_PolyGrids

## ----fig.align="center",out.width="100%",message=FALSE,dpi=200,eval=TRUE,fig.height=1----

#Prepare layout for 2 sub-plots
Mypar<-par(mfrow=c(1,2),mai=c(0,0.01,0.2,0.01))

#Example 1: Simple grid, using automatic colors
MyGrid=create_PolyGrids(Input=GridData,dlon=2,dlat=1)
plot(MyGrid,col=MyGrid$Col_Catch_sum,main='Example 1',cex.main=0.5,lwd=0.1)
box()

#Example 2: Same grid, colored by the area of each cell. This function offers an equal-area gridding
# option if required (see ?create_PolyGrids).
plot(MyGrid,col=MyGrid$Col_AreaKm2,main='Example 2',cex.main=0.5,lwd=0.1)
box()

par(Mypar)

## ----fig.align="center",out.width="100%",message=FALSE,dpi=200,eval=TRUE,fig.height=3----

#Prepare layout for 2 sub-plots
Mypar<-par(mfrow=c(2,1),mai=c(0.2,0.05,0.1,0.15))

#Step 2: Inspect your gridded data (e.g. sum of Catch) to determine whether irregular cuts are required
hist(MyGrid$Catch_sum,100,cex=0.5,main='Frequency distribution of data',
     cex.main=0.5,col='grey',axes=FALSE)
axis(1,pos=0,tcl=-0.15,lwd=0.8,lwd.ticks=0.8,labels=FALSE)
text(seq(0,2500,by=500),-1.5,seq(0,2500,by=500),cex=0.5,xpd=TRUE)

#In this case (heterogeneously distributed data) irregular cuts would be preferable
#Such as:
MyCuts=c(0,50,100,500,2000,3500)
abline(v=MyCuts,col='green',lwd=0.1,lty=2) #Add classes to histogram as green dashed lines

#Step 3: Generate colors according to the desired classes (MyCuts)
Gridcol=add_col(MyGrid$Catch_sum,cuts=MyCuts,cols=c('yellow','purple'))

#Step 4: Plot result and add color scale
#Use the colors generated by add_col
plot(MyGrid,col=Gridcol$varcol,lwd=0.1) 
#Add color scale using cuts and cols generated by add_col
add_Cscale(title='Sum of Catch',cuts=Gridcol$cuts,cols=Gridcol$cols,width=17,
     fontsize=0.35,lwd=0.5,offset=-400) 
par(Mypar)

## ----eval=FALSE---------------------------------------------------------------
#  ?create_Stations

## ----fig.align="center",out.width="100%",message=FALSE,dpi=200,eval=TRUE------
#Create polygons
MyPolys=create_Polys(Input=PolyData,Densify=TRUE)

#Set the figure margins as c(bottom, left, top, right)
Mypar<-par(mai=c(0,0,0,0))
plot(MyPolys)

#Subsample MyPolys to only keep the polygon with ID 'one'
MyPoly=MyPolys[MyPolys$ID=='one',]

plot(MyPoly,col='green',add=TRUE)
text(MyPolys$Labx,MyPolys$Laby,MyPolys$ID)
par(Mypar)

## ----fig.align="center",out.width="100%",message=FALSE,dpi=200,eval=TRUE------

#Create polygon as shown above
MyPolys=create_Polys(Input=PolyData,Densify=TRUE)
MyPoly=MyPolys[MyPolys$ID=='one',]

#optional: crop your bathymetry raster to match the extent of your polygon
BathyCroped=raster::crop(SmallBathy,MyPoly)



MyStations=create_Stations(Poly=MyPoly,Bathy=BathyCroped,Depths=c(-2000,-1500,-1000,-550),N=c(20,15,10))
#Set the figure margins as c(bottom, left, top, right)
Mypar<-par(mai=c(0,0,0,0))

#add custom colors to the bathymetry to indicate the strata of interest
MyCols=add_col(var=c(-10000,10000),cuts=c(-2000,-1500,-1000,-550),cols=c('blue','cyan'))
plot(BathyCroped,breaks=MyCols$cuts,col=MyCols$cols,legend=FALSE,axes=FALSE,box=FALSE)
add_Cscale(height=90,fontsize=0.5,width=25,lwd=0.5,offset=0,cuts=MyCols$cuts,cols=MyCols$cols)
plot(MyPoly,add=TRUE,border='red',lwd=1)
plot(MyStations,add=TRUE,col='orange',cex=0.5)
par(Mypar)

## ----eval=FALSE---------------------------------------------------------------
#  ?load_ASDs

## ----fig.align="center",out.width="100%",message=FALSE,dpi=200,eval=TRUE------

#Load ASDs and EEZs (if you haven't yet, uncomment the following lines)
# ASDs=load_ASDs()
# EEZs=load_EEZs()

#Set the figure margins as c(bottom, left, top, right)
Mypar<-par(mai=c(0,0,0,0))
#Plot
plot(ASDs,col='green',border='blue')
plot(EEZs,col='orange',border='purple',add=TRUE)
plot(Coast[Coast$ID=='All',],col='grey',add=TRUE)
add_labels(mode='auto',layer='ASDs',fontsize=0.5,col='red')
par(Mypar)

## ----eval=FALSE---------------------------------------------------------------
#  
#  #Load all layers
#  ASDs=load_ASDs()
#  EEZs=load_EEZs()
#  Coastline=load_Coastline()
#  SSRUs=load_SSRUs()
#  RBs=load_RBs()
#  SSMUs=load_SSMUs()
#  MAs=load_MAs()
#  MPAs=load_MPAs()
#  
#  #Save as .RData file (here in the temp directory)
#  save(list=c('ASDs','EEZs','Coastline','SSRUs','RBs','SSMUs','MAs','MPAs'),
#       file = file.path(tempdir(), "CCAMLRLayers.RData"), compress='xz')
#  
#  #Later, when offline load layers:
#  load(file.path(tempdir(), "CCAMLRLayers.RData"))

## ----eval=FALSE---------------------------------------------------------------
#  ?get_depths

## ----fig.align="center",out.width="100%",message=FALSE,dpi=200,eval=TRUE,fig.height=5----

#Generate a dataframe
MyData=data.frame(Lat=PointData$Lat,
                  Lon=PointData$Lon,
                  Catch=PointData$Catch)
#The input data looks like this:
head(MyData)


#Example 1: get depths of locations
MyDataD=get_depths(Input=MyData,Bathy=SmallBathy)
#The resulting data looks like this (where 'd' is the depth and 'x' and 'y' are the projected locations):
head(MyDataD)
#Prepare layout for 2 sub-plots
Mypar<-par(mfrow=c(2,1),mai=c(0.2,0.2,0.01,0.01))
#Plot Catch vs Depth
XL=c(-5000,0) #Set plot x-axis limits
YL=c(10,80)       #Set plot y-axis limits
plot(MyDataD$d,MyDataD$Catch,xlab='',ylab='',pch=21,bg='red',axes=FALSE,xpd=TRUE,xlim=XL,ylim=YL)
axis(1,pos=YL[1],tcl=-0.15,lwd=0.8,lwd.ticks=0.8,at=seq(XL[1],XL[2],by=500),cex.axis=0.5,labels=FALSE)
axis(2,pos=XL[1],tcl=-0.15,lwd=0.8,lwd.ticks=0.8,at=seq(YL[1],YL[2],by=10),cex.axis=0.5,labels=FALSE)
text(seq(XL[1],XL[2],by=500),YL[1]-3,seq(XL[1],XL[2],by=500),cex=0.5,xpd=TRUE)
text(XL[1]-100,seq(YL[1],YL[2],by=10),seq(YL[1],YL[2],by=10),cex=0.5,xpd=TRUE)

text(mean(XL),YL[1]-7,'Depth',cex=0.5,xpd=TRUE)
text(XL[1]-500,mean(YL),'Catch',cex=0.5,xpd=TRUE,srt=90)


#Example 2: get depths of locations and distance to isobath -3000m
MyDataD=get_depths(Input=MyData,Bathy=SmallBathy,Isobaths=-3000,IsoLocs=TRUE,d=200000)
plot(MyDataD$x,MyDataD$y,pch=21,bg='green',cex=0.75,lwd=0.5)
raster::contour(SmallBathy,levels=-3000,add=TRUE,col='blue',maxpixels=10000000)
segments(x0=MyDataD$x,
         y0=MyDataD$y,
         x1=MyDataD$X_3000,
         y1=MyDataD$Y_3000,col='red')
par(Mypar)

## ----eval=FALSE---------------------------------------------------------------
#  ?seabed_area

## ----message=FALSE,eval=TRUE--------------------------------------------------
#create some polygons
MyPolys=create_Polys(Input=PolyData,Densify=TRUE)
#compute the seabed areas
FishDepth=seabed_area(Bathy=SmallBathy,Polys=MyPolys,depth_classes=c(0,-200,-600,-1800,-3000,-5000))
#Result looks like this (note that the -600m to -1800m is renamed 'Fishable_area')
head(FishDepth)

## ----eval=FALSE---------------------------------------------------------------
#  ?assign_areas

## ----message=FALSE,eval=TRUE--------------------------------------------------
#Generate a dataframe with random locations
MyData=data.frame(Lat=runif(100,min=-65,max=-50),
                  Lon=runif(100,min=20,max=40))
#The input data looks like this:
head(MyData)

#load ASDs and SSRUs (if you haven't yet, uncomment the following line)
# ASDs=load_ASDs()
SSRUs=load_SSRUs()

#Assign ASDs and SSRUs to these locations 
MyData=assign_areas(Input=MyData,Polys=c('ASDs','SSRUs'),NamesOut=c('MyASDs','MySSRUs'))
#The output data looks like this:
head(MyData)

#count of locations per ASD
table(MyData$MyASDs) 

#count of locations per SSRU
table(MyData$MySSRUs) 


## ----message=FALSE,eval=TRUE--------------------------------------------------

#The input data looks like this:
head(PointData)
#Generate a dataframe with random locations
MyData=project_data(Input=PointData,NamesIn=c('Lat','Lon'),NamesOut=c('Projected_Y','Projectd_X'),append=TRUE)
#The output data looks like this:
head(MyData)

## ----fig.align="center",out.width="100%",message=F,dpi=200,eval=T-------------
#Set the figure margins as c(bottom, left, top, right)
Mypar<-par(mai=c(0,0.4,0,0))
#Plot the bathymetry
plot(SmallBathy,breaks=Depth_cuts,col=Depth_cols,axes=FALSE,box=FALSE,legend=FALSE)
#Add color scale
add_Cscale(cuts=Depth_cuts,cols=Depth_cols,fontsize=0.4,height=65,offset=600,width=25)
par(Mypar)

## ----fig.align="center",out.width="100%",message=F,dpi=200,eval=T-------------
#Set the figure margins as c(bottom, left, top, right)
Mypar<-par(mai=c(0,0.4,0,0))
#Plot the bathymetry
plot(SmallBathy,breaks=Depth_cuts2,col=Depth_cols2,axes=FALSE,box=FALSE,legend=FALSE)
#Add color scale
add_Cscale(cuts=Depth_cuts2,cols=Depth_cols2,fontsize=0.4,height=65,offset=600,width=25)
par(Mypar)

## ----eval=FALSE---------------------------------------------------------------
#  ?add_col
#  #and
#  ?add_Cscale

## ----fig.align="center",out.width="100%",message=FALSE,dpi=200,eval=TRUE,fig.height=5----

#Adding color to points

#Prepare layout for 3 sub-plots
Mypar<-par(mfrow=c(3,1),mai=c(0.01,0.01,0.1,0.6))
#Create some points
MyPoints=create_Points(Input=PointData)

#Example 1: Add default cols and cuts
MyCols=add_col(MyPoints$Nfishes) 
plot(MyPoints,pch=21,bg=MyCols$varcol,main='Example 1:',cex.main=0.5,cex=1.5,lwd=0.5)
box()
add_Cscale(title='Number of fishes',
           height=80,fontsize=0.5,width=23,lwd=0.5,offset=0,
           cuts=MyCols$cuts,cols=MyCols$cols)

#Example 2: Given the look of example 1, reduce the number of cuts and round their values (in add_Cscale)
MyCols=add_col(MyPoints$Nfishes,cuts=10) 
plot(MyPoints,pch=21,bg=MyCols$varcol,main='Example 2:',cex.main=0.5,cex=1.5,lwd=0.5)
box()
add_Cscale(title='Number of fishes',
           height=80,fontsize=0.5,width=23,lwd=0.5,offset=0,
           cuts=round(MyCols$cuts,1),cols=MyCols$cols)

#Example 3: same as example 2 but with custom colors
MyCols=add_col(MyPoints$Nfishes,cuts=10,cols=c('black','yellow','purple','cyan')) 
plot(MyPoints,pch=21,bg=MyCols$varcol,main='Example 3:',cex.main=0.5,cex=1.5,lwd=0.5)
add_Cscale(title='Number of fishes',
           height=80,fontsize=0.5,width=23,lwd=0.5,offset=0,
           cuts=round(MyCols$cuts,1),cols=MyCols$cols)
box()
par(Mypar)

## ----eval=FALSE---------------------------------------------------------------
#  ?legend

## ----eval=FALSE---------------------------------------------------------------
#  Legend_Coordinates=add_Cscale(pos='2/3',offset=1000,height=40)

## ----fig.align="center",out.width="100%",message=FALSE,dpi=200,eval=TRUE------
#Adding a color scale and a legend

#Create some point data
MyPoints=create_Points(Input=PointData)

#Crop the bathymetry to match the extent of MyPoints (extended extent)
BathyCr=raster::crop(SmallBathy,raster::extend(raster::extent(MyPoints),100000))
#set plot margins as c(bottom, left, top, right)
Mypar<-par(mai=c(0,0,0,0.05))
#Plot the bathymetry
plot(BathyCr,breaks=Depth_cuts,col=Depth_cols,legend=FALSE,axes=FALSE,box=FALSE)
#Add a color scale
add_Cscale(pos='1/2',height=50,maxVal=-1,minVal=-4000,fontsize=0.45,lwd=0.5,width=24)

#Plot points with different symbols and colors (see ?points)
Psymbols=c(21,22,23,24)
Pcolors=c('red','green','blue','yellow')
plot(MyPoints[MyPoints$name=='one',],pch=Psymbols[1],bg=Pcolors[1],add=TRUE)
plot(MyPoints[MyPoints$name=='two',],pch=Psymbols[2],bg=Pcolors[2],add=TRUE)
plot(MyPoints[MyPoints$name=='three',],pch=Psymbols[3],bg=Pcolors[3],add=TRUE)
plot(MyPoints[MyPoints$name=='four',],pch=Psymbols[4],bg=Pcolors[4],add=TRUE)

#Add legend with position determined by add_Cscale
Loc=add_Cscale(pos='2/2',height=40,mode='Legend')
legend(Loc,legend=c('one','two','three','four'),
       title='Vessel',pch=Psymbols,pt.bg=Pcolors,xpd=TRUE,
       box.lwd=0.5,cex=0.5,pt.cex=1,y.intersp=1.5)
par(Mypar)

## ----eval=FALSE---------------------------------------------------------------
#  ?add_labels

## ----fig.align="center",out.width="100%",message=FALSE,dpi=200,eval=TRUE------
#Example 1: 'auto' mode
#label ASDs in bold and red
#load ASDs (if you haven't yet, uncomment the following line)
# ASDs=load_ASDs()
#set plot margins as c(bottom, left, top, right)
Mypar<-par(mai=c(0,0,0,0))
plot(ASDs)
add_labels(mode='auto',layer='ASDs',fontsize=0.5,fonttype=2,col='red')
#add MPAs and EEZs and their labels in large, green and vertical text
MPAs=load_MPAs()
# EEZs=load_EEZs() (if you haven't loaded EEZs yet, uncomment the following line)
plot(MPAs,add=TRUE,border='green')
plot(EEZs,add=TRUE,border='green')
add_labels(mode='auto',layer=c('EEZs','MPAs'),fontsize=1,col='green',angle=90)
par(Mypar)

## ----eval=FALSE---------------------------------------------------------------
#  #Example 2: 'auto' and 'input' modes
#  #This example is not executed here because it needs user interaction.
#  #Please copy and paste it to see how it works.
#  
#  #Prepare a basemap
#  plot(SmallBathy)
#  #Load ASDs
#  ASDs=load_ASDs()
#  plot(ASDs,add=TRUE)
#  
#  #Build your labels
#  MyLabels=add_labels(mode='manual')
#  
#  #Re-use the label table generated (if desired)
#  plot(SmallBathy)
#  plot(ASDs,add=TRUE)
#  add_labels(mode='input',LabelTable=MyLabels)

