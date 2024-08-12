//////////////////////////////////////////////////////////////////////////////////////////////////////
//  Delbono Lab Muscle Analysis Script
//	----------------------------------
//	By: Henry Bonilla and Craig Hamilton (Wake Forest School of Medicine)
//	A heavily modified version of MuscleJ: Mayeuf-Louchart et al. SkeletalMuscle (2018) 8:25
// 
//		This program is a semiautomatic script used for the immunohistochemical analysis of human skeletal muscle.
//		Capabilities: morphological analysis and myosin heavy chain isoform analysis (compatible with hybrid fiber types)
//		NOT FOR CLINICAL USE
//
//   This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License.
// 
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
// 
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <https://www.gnu.org/licenses/>.

////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////
//Used for editing fiber type assignment
// plugin = getDirectory("plugins");
// run("Install...", "install="+plugin+"ColorSelector_.ijm");

////////////////////////////////////////////////////////////////////////////////////////////////////

function AreaClassAttribution(Area,FiberAreaClassCount) {
	//Array used for assigning fibers to area classes in the Global Results
    if (Area < 250) {
	FiberAreaClassCount[0]= FiberAreaClassCount[0]+1;
    }
    else if ((Area < 500) && (Area >= 250)) {
	FiberAreaClassCount[1]= FiberAreaClassCount[1]+1;       
    }
    else if ((Area < 750) && (Area >= 500)) {
	FiberAreaClassCount[2]= FiberAreaClassCount[2]+1;       
    }
    else if ((Area < 1000) && (Area >= 750)) {
	FiberAreaClassCount[3]= FiberAreaClassCount[3]+1;       
    }
    else if ((Area < 2000) && (Area >= 1000)) {
	FiberAreaClassCount[4]= FiberAreaClassCount[4]+1;       
    }
    else if ((Area < 3000) && (Area >= 2000)) {
	FiberAreaClassCount[5]= FiberAreaClassCount[5]+1;       
    }
    else if ((Area < 4000) && (Area >= 3000)) {
	FiberAreaClassCount[6]= FiberAreaClassCount[6]+1;       
    }
    else if ((Area < 5000) && (Area >= 4000)) {
	FiberAreaClassCount[7]= FiberAreaClassCount[7]+1;       
    }
    else if ((Area < 6000) && (Area >= 5000)) {
	FiberAreaClassCount[8]= FiberAreaClassCount[8]+1;       
    }
    else if (Area >= 6000) {
	FiberAreaClassCount[9]= FiberAreaClassCount[9]+1;
    } 
 }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

function ChooseColorCartography(Area, nLast,NameAreaImage) {
	//Used to create Area cartography if the option is selected
    Color = newArray(3);
    selectWindow(NameAreaImage);
    run("RGB Color");
    roiManager("select", nLast);
    if (Area < 250) {
	Color[0]=255;
	Color[1]=255;
	Color[2]=255;   
    }
    if ((Area < 500) && (Area >= 250)) {
	Color[0]=221;
	Color[1]=255;
	Color[2]=221;   
    }
    if ((Area < 750) && (Area >= 500)) {
	Color[0]=189;
	Color[1]=255;
	Color[2]=189;	
    }
    if ((Area < 1000) && (Area >= 750)) {
	Color[0]=153;
	Color[1]=255;
	Color[2]=153;	
    }
    if ((Area < 2000) && (Area >= 1000)) {
	Color[0]=120;
	Color[1]=255;
	Color[2]=120;	
    }
    if ((Area < 3000) && (Area >= 2000)) {
	Color[0]=90;
	Color[1]=255;
	Color[2]=90;	
    }
    if ((Area < 4000) && (Area >= 3000)) {
	Color[0]=0;
	Color[1]=200;
	Color[2]=20;	
    }
    if ((Area < 5000) && (Area >= 4000)) {
	Color[0]=0;
	Color[1]=150;
	Color[2]=0;	
    }
    if ((Area < 6000) && (Area >= 5000)) {
	Color[0]=0;
	Color[1]=100;
	Color[2]=0;	
    }
    if (Area >= 6000) {
	Color[0]=0;
	Color[1]=50;
	Color[2]=10;	
    }
    
    setForegroundColor(Color[0], Color[1], Color[2]);
    roiManager("Fill");
}

////////////////////////////////////////////////////////////////////////////////////////////////////

function FillFiberCartography(LamininWindows,ROIFiberFile,NameAreaImage,FiberArea,LegendBox) {
	//Used to add legend to Area cartography if chosen
    selectWindow(LamininWindows); //Uses laminin image as a frame for the filled ROI's
    run("Duplicate...", "title="+NameAreaImage);
    run("Enhance Contrast...", "saturated=0.3");

    run("Add to Manager");
    roiManager("Open", ROIFiberFile);
    run("Select None");
    fibers=roiManager("count");

    for (i=0 ; i<fibers; i++) { 
	ChooseColorCartography(FiberArea[i], i, NameAreaImage);
    }
    if (LegendBox=="Yes") { //Adds a legend in the bottom corner of the image to identify area ranges
	RangeArea=newArray("<250","250-500","500-750","750-1000","1000-2000","2000-3000",
			   "3000-4000","4000-5000","5000-6000",">6000");
	ColorArea=newArray(255,255,255,221,255,221,189,255,189,153,255,153,120,255,120,90,
			   255,90,0,200,20,0,150,0,0,100,0,0,50,10);

	roiManager("reset");
	selectWindow(NameAreaImage);
	getDimensions(width, height, channels, slices, frames);
	for (i=0; i < 10; i++) {
	    makeRectangle(0, i*100, 200, 100);
	    roiManager("Add");
	}

	for (i=0; i < 10; i++) {
	    roiManager("select", i);
	    setForegroundColor(ColorArea[3*i],ColorArea[3*i+1],ColorArea[3*i+2]);
	    roiManager("Fill");
	    if (i<8) {
		setColor("black");
	    }
	    else {
		setColor("white");
	    }
	    setFont("Sanserif", 40);
	    if (i<4) {
		drawString(RangeArea[i], 25, i*100+75);
	    }
	    else {
		drawString(RangeArea[i], 10, i*100+75);
	    }
	}
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////

function TypeCartographyFill(nbFibers,NameTypeImage,FiberPhenoType1,FiberPhenoType2A,
                             FiberPhenoType2X,FiberPhenoType0)
//Used to assign color codes to fiber type cartogrphy for MHC isoform
{
    setBatchMode(true);
    selectWindow(NameTypeImage);
    
    for (i=0 ; i<nbFibers; i++) {

	selectWindow(NameTypeImage);

	roiManager("select", i);

	// Type I
	if ((FiberPhenoType1[i] ==1) && (FiberPhenoType2A[i]==0) && (FiberPhenoType2X[i]==0)) {
	    Roi.setFillColor("blue");
	    roiManager("update");
	}
	else
	    // Type IIA
	    if ((FiberPhenoType1[i] ==0) && (FiberPhenoType2A[i]==1) && (FiberPhenoType2X[i]==0)) {
		 Roi.setFillColor("green");
		 roiManager("update");
	    }
	    else
		// Type IIX
		if ((FiberPhenoType1[i] ==0) && (FiberPhenoType2A[i]==0) && (FiberPhenoType2X[i]==1)) {
		    Roi.setFillColor("red");
		    roiManager("update");
		}
		else
		    // Type IIX ambig
		    if ((FiberPhenoType1[i] ==0) && (FiberPhenoType2A[i]==0) && (FiberPhenoType2X[i]==2)) {
			 Roi.setFillColor("red");
			 roiManager("update");
		    }
		    else
			// Type I - IIA
			if ((FiberPhenoType1[i] ==1) && (FiberPhenoType2A[i]==1) && (FiberPhenoType2X[i]==0)) {
			     Roi.setFillColor("cyan");
			     roiManager("update");
			}
			else
			    // Type I - IIX
			    if ((FiberPhenoType1[i] ==1) && (FiberPhenoType2A[i]==0) && (FiberPhenoType2X[i]>0)) {
				 Roi.setFillColor("pink");
				 roiManager("update");
			    }

			    else
				// Type IIA - IIX
				if ((FiberPhenoType1[i] ==0) && (FiberPhenoType2A[i]==1) && (FiberPhenoType2X[i]>0)) {
				    Roi.setFillColor("orange");
				    roiManager("update");
				}
				else
				    // Not detected
				    if (FiberPhenoType0[i] ==1) {
					 Roi.setFillColor("gray");
					 roiManager("update");
				    }
				    else 
					// Type I - IIA - IIX
				    if ((FiberPhenoType1[i] ==1) && (FiberPhenoType2A[i]==1) && (FiberPhenoType2X[i]==1)) {
				    	Roi.setFillColor("white");
				    	roiManager("update");
				    }
				    	
    }

    setBatchMode(false);
}
/////////////////////////////////////////////////////////////////////////////////////////////

function TypeCartographyLegend(NameTypeImage, LegendBox) {

	selectWindow(NameTypeImage);

    // Add legend on bottom left to identify fiber types            
    if (LegendBox=="Yes") {
		
	roiManager("reset");
	selectWindow(NameTypeImage);
	getDimensions(width, height, channels, slices, frames);
		
	BottomY=height-225;
	BottomYMidle=height-150;

	BottomYHyb=height-100;
	BottomYHybMidle=height-25;
		
	makeRectangle(0, BottomY, 100, 100);
	roiManager("Add");
	roiManager("select", 0);
	setForegroundColor("blue");
	roiManager("Fill");
	setColor("white");
	setFont("Sanserif", 50);
	drawString("I", 50, BottomYMidle);
	  	
	makeRectangle(100, BottomY, 100, 100);
	roiManager("Add");
	roiManager("select", 1);
	setForegroundColor("green");
	roiManager("Fill");
	setColor("white");
	setFont("Sanserif", 50);
	drawString("IIA", 125, BottomYMidle);
	
	makeRectangle(200, BottomY, 100, 100);
	roiManager("Add");
	roiManager("select", 2);
	setForegroundColor("red");
	roiManager("Fill");
	setColor("white");
	setFont("Sanserif", 50);
	drawString("IIX", 225, BottomYMidle);
		
	// Hybrid
		
	makeRectangle(0, BottomYHyb, 100, 100);
	roiManager("Add");
	roiManager("select", 4);
	setForegroundColor("cyan");
	roiManager("Fill");
	setColor("white");
	setFont("Sanserif", 35);
	drawString("I-IIA", 25, BottomYHybMidle);

	makeRectangle(100, BottomYHyb, 100, 100);
	roiManager("Add");
	roiManager("select", 5);
	setForegroundColor("pink");
	roiManager("Fill");
	setColor("white");
	setFont("Sanserif", 35);
	drawString("I-IIX", 125, BottomYHybMidle);
		
	makeRectangle(200, BottomYHyb, 100, 100);
	roiManager("Add");
	roiManager("select", 6);
	setForegroundColor("orange");
	roiManager("Fill");
	setColor("white");
	setFont("Sanserif", 35);
	drawString("IIA-IIX", 205, BottomYHybMidle);

	makeRectangle(300, BottomYHyb, 100, 100);
	roiManager("Add");
	roiManager("select", 7);
	setForegroundColor("gray");
	roiManager("Fill");
	setColor("white");
	setFont("Sanserif", 35);
	drawString("ND", 325, BottomYHybMidle);

	makeRectangle(400, BottomYHyb, 100, 100);
	roiManager("Add");
	roiManager("select", 8);
	setForegroundColor("white");
	roiManager("Fill");
	setColor("black");
	setFont("Sanserif", 35);
	drawString("I-IIA-IIX", 405, BottomYHybMidle);	
    }

}

////////////////////////////////////////////////////////////////////////////////////////////////////
 function TotalArea(LamEnhanced, RGB) {   
    //Used to find largest continuous area from ROI draw by user
    roiManager("reset");
    
    selectWindow(RGB);
    waitForUser("Select total area for measurement and add to ROI Manager.\nFor whole image, just click OK."); //prompt pauses script to allow user to draw ROI
    selectWindow(LamEnhanced);
    roiManager("deselect");
    run("Select None");
    run("Duplicate...", "title=[LamThresh]"); //duplicate windows to preserve originals for segmentation
    selectWindow("LamThresh");
    run("Auto Threshold", "method=Triangle white"); //"method" can be changed if a different automatic threshold works better
   
    run("Duplicate...","title=[LamThresh2]");
	run("Morphological Filters", "operation=Dilation element=Octagon radius=5"); //binary operations to create a corrected, skeletonized version of laminin
	run("Options...", "iterations=1 count=1 black pad do=Skeletonize");
	run("Options...", "iterations=1 count=1 black do=Dilate");
	run("Create Selection");
	selectWindow("LamThresh");
	run("Restore Selection");
	fill();
	run("Morphological Filters", "operation=Close element=Octagon radius=5");
	run("Morphological Filters", "operation=Erosion element=Octagon radius=1");
	run("Make Binary");
	close("LamThresh2");

	totarea=roiManager("count"); //Analyze particles to find all continuous areas within the selected ROI
	if (totarea > 0) {
		roiManager("select",0);
		run("Clear Outside");
		roiManager("delete");
		run("Analyze Particles...", "size=0-infinity circularity=0.00-1.00 display clear add in_situ");
	} else {
    run("Analyze Particles...", "size=0-infinity circularity=0.00-1.00 display clear add in_situ");
	}

if(roiManager("count")>0) {
	print("Areas found");
}

	MaxSurf=0;
    if (nResults >0) { //picks the largest area from all found
	selectWindow("Results");
	MaxIndex=0;
		for (i=0; i<=nResults-1; i++) {
	    	CurrentArea=getResult("Area", i);
	    	if (MaxSurf < CurrentArea) {
			MaxIndex=i;
			MaxSurf=CurrentArea;
	    	}
		} 
	}
	
    area=roiManager("count")-1; //removes all areas except the largest
	for (j=area; j>=0; j--) {
		if (j != MaxIndex) {
			roiManager("Select", j);
		    roiManager("Delete");
		}
	}

	run("Clear Results");
	roiManager("deselect");
	roiManager("measure");
	MaxSurf=getResult("Area", 0);
	roiManager("select",0);
	
return MaxSurf;
}
///////////////////////////////////////////////////////////////////////////////////////////////////

function FiberTypeDetection(ROIFile,TypeWindows,FiberType,FiberPhenoType,TypeAnalysis) 
{
//uses thresholded channels to determine fiber phenotype
    print("Running FiberTypeDetection");

	setBatchMode(true);
    selectWindow(TypeWindows);
    run("Select None");
    TypeDup=TypeWindows+"_Dup";//Duplicates for any analysis sequence
    run("Duplicate..."," ");
    rename(TypeDup);
    run("Duplicate...", "title=[Background]");
    run("Gaussian Blur...","sigma=75");//gaussian blur background subtraction
    imageCalculator("Subtract", TypeDup,"Background");
    close("Background");
    getStatistics(area, mean, min, max, std, histogram);
	thresh=2*std;
	run("Remove Outliers...","radius=10 threshold=thresh which=Bright");//removes bright points that may affect threshold
    run("Auto Threshold", "method=Triangle white");
    run("Options...", "iterations=1 count=1 black pad do=Close");//unifies thresholded pixels within 1 pixel radius from each other to prevent removal by median filter
    run("Median...", "radius=3");
    roiManager("reset");
    roiManager("Open", ROIFile);
    roiManager("Show None");
    roiManager("sort");

    run("Clear Results");
	roiManager("deselect");
	roiManager("measure");
	nbFiberType=0;
    for (i=1 ; i<nResults; i++) {
		FiberType[i] =0;
		FiberPhenoType[i]=0;
		FiberType[i]=getResult("Mean",i);
		if (FiberType[i] > 102) { //40% of fiber must pass threshold
		    FiberPhenoType[i]=1; //threshold value can be changed but must be between 1-255 (8-bit range)
		    nbFiberType=nbFiberType+1;
		}
    }
    
    run("Close");
    roiManager("reset");
    run("Clear Results");
	setBatchMode(false);

    print("      Finished FiberTypeDetection");
	
    return nbFiberType;
}

////////////////////////////////////////////////////////////////////////////////////////////

function MorphoSegment(LamEnhanced, ROIFiberFile, RGBImage, RGBRef, Dir, Name) 
{ //uses binarized and corrected laminin from TotalArea function to segment individual fibers
	setColor("white");
    
    print("MorphoSeg threshhold");

    roiManager("select",0);
   
	getSelectionBounds(x, y, width, height); //coordinates of total area
	run("Duplicate...","title=[LamThreshSmall]");
	if (roiManager("count")>0) {
		roiManager("add");
		roiManager("select",0);
		roiManager("delete");
		roiManager("select",0);
	}
	
	run("Clear Outside");
	run("Select None");
	run("Duplicate...","title=[LamThreshSmall2]");
	selectWindow("LamThreshSmall");
    run("Morphological Segmentation"); //need to download IJPB plugin set
	
    waitForUser("Run segmentation with Object Image and Morphological gradient type.\nSelect \
                 ''Advanced Options'' and set ''Connectivity'' to 8. Display results \
                 as Watershed lines and Create Image.\nThen click OK.");
                
    selectWindow("Morphological Segmentation");
    close();
	selectWindow("LamThreshSmall-watershed-lines");
    print("MorphoSeg: analyze particles on Morphological Segmentation");
    setBackgroundColor(255, 255, 255);
    run("Kill Borders");
    run("Analyze Particles...", "size=100-infinity circularity=0-1.00 show=Nothing display add in_situ"); //Detects fibers after segmentation
    roiManager("Remove Slice Info");
    selectWindow("LamThreshSmall-watershed-lines");
    close();
    selectWindow("LamThreshSmall-watershed-lines-killBorders");
	close();

	for (g=0; g<roiManager("count"); g++) { //Moves ROI's back to correct positions on original image
			roiManager("select",g);
			Roi.getBounds(a, b, w, h);
			c=a+x;
			d=b+y;
			Roi.move(c, d);
	}

	roiManager("select",0);
    roiManager("rename", "9999-9999");
	
    RGBOverlayR=Dir+Name+"_Overlay.tif"; //Added repository variable to call image  
    RGBOverlay=Name+"_Overlay.tif"; //Name variable to manipulate open image
    selectWindow(RGBImage);
    roiManager("Set Color", "magenta");
    roiManager("Show All with labels");
    
    waitForUser("Edit the segmentation. Remove unwanted cells.");
    saveAs("tiff", RGBOverlayR);
    roiManager("save",ROIFiberFile);
    roiManager("reset");
    close();

    ans=getBoolean("Would you like to perform Level Sets Segmentation?");
    if (ans==1) {
    	open(RGBOverlayR);
    	//setTool("point");
    	waitForUser("Add seed points to cells with point tool. Add cells one at a time to ROI Manager. \
                   Click Add in ROI Manager or press 't' on the keyboard to add seed points.");

    	setBatchMode(true);
    	roiManager("deselect");
    	run("Select None");
    	selectWindow("LamThreshSmall2");
    	do {
    	selectWindow(RGBOverlay);
    	close();
    	newpoints=roiManager("count");
    	for (i=0; i<newpoints; i++) {
			roiManager("select",i);
			Roi.getBounds(xpoint, ypoint, width, height);
			xpoint=xpoint-x;
			ypoint=ypoint-y;
			Roi.move(xpoint, ypoint);
			roiManager("update");
			roiManager("select",i);
			run("Enlarge...", "enlarge=1");
			roiManager("update");
    	}
    	for (i=newpoints-1; i>=0; i--) {
    		roiManager("select", i);
			run("Level Sets", "method=[Active Contours] use_level_sets grey_value_threshold=100 distance_threshold=1.5 \
				advection=3.5 propagation=1 curvature=1.65 grayscale=100 convergence=0.00250 region=outside");
        	print("Level sets done");
			run("Invert");
			run("Analyze Particles...","add");
			roiManager("select",i);
			roiManager("delete");
    	}
		for (g=0; g<roiManager("count"); g++) {
			roiManager("select",g);
			Roi.getBounds(a, b, w, h);
			c=a+x;
			d=b+y;
			Roi.move(c, d);
			setBatchMode(false);
		}
		roiManager("Open",ROIFiberFile);
		open(RGBRef);
		roiManager("Show All with labels");
		waitForUser("Edit the segmentation. Remove unwanted cells.");
    	saveAs("tiff", RGBOverlayR);
    	close();
    	roiManager("deselect");
    	roiManager("save", ROIFiberFile);
    	open(RGBOverlayR);
    	roiManager("reset");
    	//setTool("point");
    	waitForUser("Add seed points to cells with point tool. Add cells one at a time to ROI Manager. \
                   Click Add in ROI Manager or press 't' on the keyboard to add seed points.");
    	pointcount=roiManager("count");
    	} while (pointcount>0);
    roiManager("open", ROIFiberFile);
    } else {
    roiManager("open", ROIFiberFile);
    }
	selectWindow("LamThreshSmall2");
	close();
    selectWindow(LamEnhanced);
    roiManager("save",ROIFiberFile);
    run("Clear Results");
    roiManager("deselect");
    roiManager("sort");
	roiManager("measure");
	

    nbFibers=nbFibersLast=0;

    nbFibers= roiManager("count");

    return nbFibers;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

function FiberStats (nbFibers,FiberArea,FiberFeret,MinFiberFeret,FiberAreaClassCount) {

	AreaMean=Variance=0;
    for (i=0; i < nbFibers; i++) {
	AreaMean=AreaMean+getResult("Area", i);
    }
    AreaMean=(AreaMean/nbFibers);
    for (i=1; i < nbFibers; i++) {
	Variance=Variance+((getResult("Area", i)-AreaMean)*(getResult("Area", i)-AreaMean));
    }

    Variance=(Variance/nbFibers); //HJB: changed to account for total area deletion
    StdDev=sqrt(Variance);
    MinArea=100;

    TotSurfaceFibers =0;
	
    for (i=0; i<nbFibers; i++) {
		FiberArea[i]=getResult("Area", i);
		AreaClassAttribution(FiberArea[i],FiberAreaClassCount);
		FiberFeret[i]=getResult("Feret", i);
		MinFiberFeret[i]=getResult("MinFeret", i);
		TotSurfaceFibers=TotSurfaceFibers+FiberArea[i];
    }
	
    return TotSurfaceFibers;

}

///////////////////////////////////////////////////////////////////////////////////////////////////

function CheckCartography(nbFibers,CartWindow,nbFiberType1,nbFiberType2A,nbFiberType2X,nbFiberType0,FiberTypeArr) 
{

    print("Running FiberTypeDetection");

    selectWindow(CartWindow);
    run("Select None");

    for (h=0 ; h<nbFibers; h++) {
	roiManager("select",h);
	FiberCheck=Roi.getFillColor;
	if (FiberCheck == "blue") {
	    FiberTypeArr[h]="I";
	} 
	if (FiberCheck == "green") {
	    FiberTypeArr[h]="IIA";
	} 
	if (FiberCheck == "red") {
	    FiberTypeArr[h]="IIX";
	} 
	if (FiberCheck == "orange") {
	    FiberTypeArr[h]="IIA-IIX";
	} 
	if (FiberCheck == "pink") {
	    FiberTypeArr[h]="I-IIX";
	} 
	if (FiberCheck == "cyan") {
	    FiberTypeArr[h]="I-IIA";
	} 
	if (FiberCheck == "gray") {
	    FiberTypeArr[h]="Not_detected";
	}
	if (FiberCheck == "white") {
	    FiberTypeArr[h]="I-IIA-IIX";
	}  
    }
    print("      Finished FiberTypeCheck");
}

///////////////////////////////////////////////////////////////////////////////////////////////////

function FiberPhenotype(fibtype,FiberPhenoType1,FiberPhenoType2A,FiberPhenoType2X,FiberPhenoType0,FiberTypeArr) {

   for (j=0; j<nbFibers; j++) {
		       if ((fibtype[T1]) || (fibtype[T2A]) || (fibtype[T2X]))  {
			   if ((FiberPhenoType1[j] ==1) && (FiberPhenoType2A[j]==0) && (FiberPhenoType2X[j]==0)) {
			       FiberTypeArr[j]="I";
			   }
			   if ((FiberPhenoType1[j] ==0) && (FiberPhenoType2A[j]==1) && (FiberPhenoType2X[j]==0)) {
			       FiberTypeArr[j]="IIA";
			   }
			   if ((FiberPhenoType1[j] ==0) && (FiberPhenoType2A[j]==0) && (FiberPhenoType2X[j]==1)) {
			       FiberTypeArr[j]="IIX";
			   }
			   if ((FiberPhenoType1[j] ==1) && (FiberPhenoType2A[j]==1) && (FiberPhenoType2X[j]==0)) {
			       FiberTypeArr[j]="I-IIA";
			   }
			   if ((FiberPhenoType1[j] ==1) && (FiberPhenoType2A[j]==0) && (FiberPhenoType2X[j]>0)) {
			       FiberTypeArr[j]="I-IIX";
			   }
			   if ((FiberPhenoType1[j] ==0) && (FiberPhenoType2A[j]==1) && (FiberPhenoType2X[j]>0)) {
			       FiberTypeArr[j]="IIA-IIX";
			   }
			   if ((FiberPhenoType1[j] ==1) && (FiberPhenoType2A[j]==1) && (FiberPhenoType2X[j]>0)) {
			       FiberTypeArr[j]="I-IIA-IIX";
			   }
			   if ((FiberPhenoType1[j] ==0) && (FiberPhenoType2A[j] ==0) && (FiberPhenoType2X[j] ==0)) {
			       FiberPhenoType0[j]=1;
			       FiberTypeArr[j]="Not_detected";
			   }
		       }
		   }
		   }
///////////////////////////////////////////////////////////////////////////////////////////
function	FiberCounts(FiberTypeArr,nbFiberType,type) {
	nbFiberType=0;
	for (i=0; i<FiberTypeArr.length; i++) {
		if (FiberTypeArr[i]==type) {
			nbFiberType++;
		}
	}
	return nbFiberType;
}

///////////////////////////////////////////////////////////////////////////////////////////////
//////////////////// 			MAIN PROGRAM            	   ////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////

Dialog.create("Delbono Lab Muscle Analysis Script");

Dialog.setInsets(0, 0, 0);
Dialog.addMessage("Acquisition\n=============");

items = newArray("Single plane","Z stack");
Dialog.addRadioButtonGroup("Volume", items, 1, 2, "Single plane");

items = newArray("Bio-Formats compatible file","ImageJ multichannel tiff");
Dialog.addRadioButtonGroup("Data Format", items, 1, 2, "Bio-Formats compatible file");

Dialog.setInsets(0, 0, 0);
Dialog.addMessage(" \nMHC Analysis\n=============");
Dialog.addMessage("Select none to only analyze fiber morphology.");
labels=newArray("Type 1", "Type 2A", "Type 2X");

// WFMOD: change defaults
defaults = newArray(1,1,1);
Dialog.addCheckboxGroup(3, 1, labels, defaults);

Dialog.setInsets(0, 0, 0);
Dialog.addMessage(" \nCartography\n==============");

items = newArray("None","Area classes","Fiber types");
// WFMOD: change default
Dialog.addChoice("Cartography Choice:", items,"Fiber types");
items = newArray("Yes","No");

// WFMOD: change default
Dialog.addChoice("Legend", items,"No");
Dialog.show();

OneZ=Dialog.getRadioButton();
FileFormat=Dialog.getRadioButton();

// WFMOD: make analysis type indices readable
T1=1;
T2A=2;
T2X=3;
bl="I";
gr="IIA";
r="IIX";
cy="I-IIA";
p="I-IIX";
o="IIA-IIX";
gry="Not_detected";
wh="I-IIA-IIX";
ColorArray=newArray("I","IIA","IIX","I-IIA","I-IIX","IIA-IIX","I-IIA-IIX","Not_detected");
fibtype = newArray(1,0,0,0);
typechannel = newArray(-1,-1,-1,-1);
fiberinfo = 1;
ChannelFiber=-1;

for (i=1; i<4; i++) {
    fibtype[i] = Dialog.getCheckbox();
    fiberinfo = fiberinfo + fibtype[i];
}    
print(fiberinfo);
CartographyBox=Dialog.getChoice();
LegendBox=Dialog.getChoice();

items = newArray("1","2","3","4");
nameArr=newArray("Fiber shape", "Type 1", "Type 2A","Type 2X");
items = Array.trim(items, fiberinfo);
fiberinfo=fiberinfo-1; //offset to choose correct value from array
channeldialog=fiberinfo; //used to remove fiber classification from dialog if only morphology is desired

Dialog.create("Channel Information");
Dialog.addChoice(nameArr[0], items, items[fiberinfo]);
for (i=1; i<= 3; i++) {
    if (fibtype[i]) {
    fiberinfo=fiberinfo-1;
    
	if (i==T1) {
	    Dialog.addChoice(nameArr[i], items, items[fiberinfo]);
	}				
	if (i==T2A) {
	    Dialog.addChoice(nameArr[i], items, items[fiberinfo]);
	}				
	if (i==T2X) {
	    Dialog.addChoice(nameArr[i], items, items[fiberinfo]);
	}				
    }
}
Dialog.show();

for (i=0; i<= 3; i++) {
    if (fibtype[i]) {
	typechannel[i]=Dialog.getChoice();
    }
}

Dialog.create("Pixel Dimensions");
Dialog.addNumber("Pixel width (microns)", 1.000);
Dialog.addNumber("Pixel height (microns)", 1.000);
Dialog.show();

XResol=Dialog.getNumber();
YResol=Dialog.getNumber();

if (XResol != YResol) {
	do {
	Dialog.create("Error");
	Dialog.addMessage("Pixel aspect must be 1. Enter pixel dimensions again or click 'Cancel' to exit.");
	Dialog.addNumber("X:", 1.000);
	Dialog.addNumber("Y:", 1.000);
	Dialog.show();

	XResol=Dialog.getNumber();
	XResol=Dialog.getNumber();
	} while (XResol != YResol);
}
seriesnum=0;
if (FileFormat=="Bio-Formats compatible file") {
	Dialog.create("Series");
	Dialog.addNumber("Enter desired image series. If your image only has one series, enter 0.",1);
	Dialog.show;
	seriesnum=Dialog.getNumber();
}

// WFMOD:  add new global
LamininEnhanced="LamininEnhanced";
LamininEnhancedSegmented="LamEnhanced Segmented";


import=getDirectory("Select folder containing images for analysis");
export=getDirectory("Select folder for exporting results (ROI files, results tables, and cartographies)");


listin = getFileList(import);
listout = getFileList(export);

ROIDir=export+"/ROI/";
CartoDir=export+"/Cartography/";
ResultDir=export+"/Results_byfile/";
WFDir=export+"/WFdir/";

if (listout.length < 4) {
    File.makeDirectory(ROIDir);
    File.makeDirectory(CartoDir);
    File.makeDirectory(ResultDir);
    File.makeDirectory(WFDir);
}
else {
    listout = getFileList(ROIDir);
}

if (fibtype[0]) {
    ChannelFiber= parseInt(typechannel[0])-1;
}

if (fibtype[T1]) { 
    ChannelType1= parseInt(typechannel[T1])-1;
}

if (fibtype[T2A]) {
    ChannelType2A= parseInt(typechannel[T2A])-1;
}

if (fibtype[T2X]) {
    ChannelType2X= parseInt(typechannel[T2X])-1;
}

run("Set Measurements...", "area mean centroid feret's redirect=None decimal=3");

print(listin.length+" images to analyze");

FullName=newArray;

////////////////////////////////Analysis procedure//////////////////////////////////////////////

for (z=0; z<listin.length; z++) {
    // Generic information
    min=0;
    max=0;
    FiberFeret = newArray(10000);
    MinFiberFeret = newArray(10000);
    FiberArea = newArray(10000);
    Intensity = newArray(10000);
    FiberType1 = newArray(10000);
    FiberType2A = newArray(10000);
    FiberType2X = newArray(10000);
    FiberPhenoType1 = newArray(10000);
    FiberPhenoType2A = newArray(10000);
    FiberPhenoType2X = newArray(10000);
    FiberPhenoType0 = newArray(10000);
    FiberTypeArr = newArray(10000);
    FiberAreaClassCount = newArray(0,0,0,0,0,0,0,0,0,0);
    GlobalTable="Global_Table";
	FiberTable="Fiber_Table";
	Table.create(GlobalTable);
	Table.create(FiberTable);
	
    nbFibers=nFeretMean=0;
    nbFiberType1=nbFiberType2A=nbFiberType2X=nbFiberType0=nbFiberType12A=nbFiberType12X=nbFiberType2AX=nbFiberType12AX=0;
    IntensityMean=0;
    SurfaceTotSection=TotFiberFeret=0;
    FullName = split(listin[z],".");   // listin is names of images to analyze
    FileName=FullName[0];

    print("Analyzing: "+FileName);
    NameLamininImage = FileName+"_Fibers.jpg";
    NameAreaImage = FileName+"_FiberArea.jpg";
    NameTypeImage = FileName+"_FiberType.jpg";
    NameLamininResult = FileName+"_FiberDetails";
    NameGlobalResult = FileName+"_GlobalResults";
    // ROI associated functionalities
    ROIFiberFile = ROIDir+FileName+"_ROI_F.zip";
    ROISectionFile = ROIDir+FileName+"_SectionROI.zip";

    currentFile=import+listin[z];
    newGlobalName="";
	LamininWindows=newGlobalName+ChannelFiber;

    SurfaceTotFibers=0;
    SurfaceTotSection=0;

    roiManager("reset"); //Reset ROI list
    run("Clear Results"); //Reset Results Table

	//setBatchMode(true);
    if (fibtype[0]) {   // Fiber Morphology: series number needs to be changed based on image type
    	if (seriesnum!=0) {
    		run("Bio-Formats Importer", "open=currentFile autoscale color_mode=Default \
                    split_channels view=Hyperstack stack_order=XYCZT series_"+seriesnum);
    	} else {
		run("Bio-Formats Importer", "open=currentFile autoscale color_mode=Default \
                    split_channels view=Hyperstack stack_order=XYCZT");
    	}
    }
		run("Properties...", "unit=micron pixel_width=XResol pixel_height=YResol global");

		CurrentWindows=getTitle();
		Title = split(CurrentWindows,"=");
		newGlobalName=Title[0]+"=";
		LamininWindows=newGlobalName+ChannelFiber;

		print("LamininWindows = "+LamininWindows);
		
	if (OneZ=="Z stack") {
	    selectWindow(LamininWindows);
	    run("Z Project...", "projection=[Max Intensity]");
	    selectWindow(LamininWindows);
	    run("Close");
	    selectWindow("MAX_"+LamininWindows);
	    rename(LamininWindows);
	}
	
	selectWindow(LamininWindows);
	run("Duplicate...","title=[LamWindowDup]");       // need this if running segm/classif multiple times
	run("Duplicate...","title=[LamWindowDup2]");
	run("Duplicate...", "title=[LamininEnhanced]");
	selectWindow("LamWindowDup2");
	run("Gaussian Blur...", "sigma=75");
	imageCalculator("Subtract", "LamininEnhanced","LamWindowDup2");
	run("Enhance Contrast...", "saturated=0.35");
	selectWindow("LamWindowDup2");
	close();
	setBatchMode("exit and display");
	
	// WFMOD: create RGB of the four channels so the ROIs can be displayed on it after segmentation
	if (fibtype[0]) {
	selectWindow(newGlobalName+ChannelFiber);
	run("Duplicate..."," ");
	run("Enhance Contrast...", "saturated=0.35");
	getMinAndMax(min, max);
	waitForUser("Find the mean gray intensity of a negative region WITHIN the section.\n\
				Insert the value in the next prompt.");
	min=getNumber("Type the negative mean gray intensity for laminin.", 100);
	setMinAndMax(min, max);
	}

	if (fibtype[T1]) {
	selectWindow(newGlobalName+ChannelType1);
	run("Duplicate..."," ");
	run("Enhance Contrast...", "saturated=0.35");
	getMinAndMax(min, max);
	waitForUser("Find the mean gray intensity of a negative region WITHIN the section.\n\
				Insert the value in the next prompt.");
	min=getNumber("Type the negative mean gray intensity for Type I.", 100);
	setMinAndMax(min, max);

	}
	if (fibtype[T2A]) {
	selectWindow(newGlobalName+ChannelType2A);
	run("Duplicate..."," ");
	run("Enhance Contrast...", "saturated=0.35");
	getMinAndMax(min, max);
	waitForUser("Find the mean gray intensity of a negative region WITHIN the section.\n\
				Insert the value in the next prompt.");
	min=getNumber("Type the negative mean gray intensity for Type IIA.", 100);
	setMinAndMax(min, max);
	}
	
	if (fibtype[T2X]) {
	selectWindow(newGlobalName+ChannelType2X);
	run("Duplicate..."," ");
	run("Enhance Contrast...", "saturated=0.35");
	getMinAndMax(min, max);
	waitForUser("Find the mean gray intensity of a negative region WITHIN the section.\n\
				Insert the value in the next prompt.");
	min=getNumber("Type the negative mean gray intensity for Type IIX.", 100);
	setMinAndMax(min, max);
	}

	if (channeldialog==1) {
        run("Merge Channels...","c1=["+newGlobalName+ChannelType2X+"-1"+"] c7=["+newGlobalName+ChannelFiber+"-1"+"] create");
	}
	if (channeldialog==2) {
        run("Merge Channels...","c1=["+newGlobalName+ChannelType2X+"-1"+"] c2=["+newGlobalName+ChannelType2A+"-1"+
                        "] c7=["+newGlobalName+ChannelFiber+"-1"+"] create");
	}
	if (channeldialog==3) {
        run("Merge Channels...","c1=["+newGlobalName+ChannelType2X+"-1"+"] c2=["+newGlobalName+ChannelType2A+"-1"+
                        "] c3=["+newGlobalName+ChannelType1+"-1"+"] c7=["+newGlobalName+ChannelFiber+"-1"+"] create");
	}

	RGBR=WFDir+FileName+"_RGBA.tif";
	RGB= FileName+"_RGBA.tif";
	saveAs("tiff",RGBR);
	close();
	
	
        //  ###############################################################
	// WFMOD: this seems to be the place to launch various analyses,
        //        everything prior is just setup and loading.  This asssumes
        //        fibtype[0], Fiber Morphology, was checked.
        //  ###############################################################

	// WFMOD: now we have all the user input to start processing.  We are going to put
	//   a dialog in a loop that allows user to choose processing steps.  That way,
	//   the laminin can be edited and segmented multiple times, for example.

	firsttime=true;
	done = false;
	while (!done) {

	    if (!firsttime) {

		Dialog.create("Script Controls");
		if (channeldialog==0) {
		items = newArray("Segment Laminin","Finish");
		}
		items = newArray("Segment Laminin","Classify Cells","Finish");
		Dialog.addRadioButtonGroup("Analysis Options", items, 1, 2, "Segment Laminin");

		Dialog.show();

		option=Dialog.getRadioButton();
	   
	    } else {
		firsttime=false;
		option="Segment Laminin";   // first time through, go ahead with first cut at segmentation
	    }

	   if (option=="Segment Laminin") {    // ################################################

	       print("Segmenting Laminin");

	       open(RGBR);

  	       SurfaceTotSection=TotalArea(LamininEnhanced, RGB);
               
 	       nbFibers = MorphoSegment(LamininEnhanced,ROIFiberFile,
						     		RGB,RGBR, WFDir, FileName);

		       
		   close("LamThresh*");
 	       
 	       SurfaceTotFibers = FiberStats(nbFibers,FiberArea,FiberFeret,
						    MinFiberFeret,FiberAreaClassCount);

           FibersAreaPercent=0;

		       FibersAreaPercent= SurfaceTotFibers/SurfaceTotSection;
		       FibersAreaPercent= 100*FibersAreaPercent;
		       FiberAreaMean = SurfaceTotFibers/nbFibers;
		       for (k=0 ; k<nbFibers; k++) {
			   TotFiberFeret=TotFiberFeret+FiberFeret[k];
		       }
	
		       nFeretMean = TotFiberFeret/nbFibers;
               GlobalTableHeadings=newArray("File_Name","Total_Area","Total_Segmented_Fibers",
                                          "Fiber_Area_Mean_(µm2)","Fiber_Feret_Mean","<250_(µm2)","250-500_(µm2)","500-750_(µm2)",
                                          "750-1000_(µm2)","1000-2000_(µm2)","2000-3000_(µm2)","3000-4000_(µm2)",
                                          "4000-5000_(µm2)","5000-6000_(µm2)",">6000_(µm2)");
               selectWindow(GlobalTable);
               Table.setColumn("Output", GlobalTableHeadings);

			   GlobalResults=newArray(FileName,SurfaceTotSection,nbFibers-1, FiberAreaMean,nFeretMean);
			   GlobalResults=Array.concat(GlobalResults,FiberAreaClassCount);
			   selectWindow(GlobalTable);
			   Table.setColumn("Results", GlobalResults);

   			selectWindow(FiberTable);
   			Table.setColumn("Area (µm²)", FiberArea);
   		    Table.setColumn("Max Feret", FiberFeret);
   			Table.setColumn("Min Feret", MinFiberFeret);	   			   

	       roiManager("reset");

	       // Save Fiber Area cartography
	       if (CartographyBox=="Fiber Area Classes") {
		   FillFiberCartography(LamininWindows,ROIFiberFile,NameAreaImage,FiberArea,LegendBox);
		   selectWindow(NameAreaImage);
		   run("RGB Color");
		   saveAs("Jpeg", CartoDir+NameAreaImage);
	       }    
	       
	       print("finished segmenting laminin");

	   } else if (option=="Classify Cells") {   // #########################################################

	       print("Classifying Cells");
	
		   if (fibtype[T1]) {  
			   Type1Windows=newGlobalName+ChannelType1;
		       if (OneZ=="Z stack") {
			   selectWindow(Type1Windows);
			   run("Z Project...", "projection=[Max Intensity]");
			   selectWindow(Type1Windows);
			   run("Close");
			   selectWindow("MAX_"+Type1Windows);
			   rename(Type1Windows);
		       }

		       nbFiberType1=FiberTypeDetection(ROIFiberFile,Type1Windows,FiberType1,FiberPhenoType1,T1);
		   }

		   if (fibtype[T2A]) { 
			   Type2AWindows=newGlobalName+ChannelType2A;
		       if (OneZ=="Z stack") {
			   selectWindow(Type2AWindows);
			   run("Z Project...", "projection=[Max Intensity]");
			   selectWindow(Type2AWindows);
			   run("Close");
			   selectWindow("MAX_"+Type2AWindows);
			   rename(Type2AWindows);
		       }
			
		       nbFiberType2A=FiberTypeDetection(ROIFiberFile,Type2AWindows,FiberType2A,
							FiberPhenoType2A,T2A);
		   }
	
		   if (fibtype[T2X]) {  
			   Type2XWindows=newGlobalName+ChannelType2X;
		       if (OneZ=="Z stack") {
			   selectWindow(Type2XWindows);
			   run("Z Project...", "projection=[Max Intensity]");
			   selectWindow(Type2XWindows);
			   run("Close");
			   selectWindow("MAX_"+Type2XWindows);
			   rename(Type2XWindows);
		       }

		       nbFiberType2X=FiberTypeDetection(ROIFiberFile,Type2XWindows,FiberType2X,
							FiberPhenoType2X,T2X);			
		   }
		
		   
		       // WFMOD: use the copy, in case running segm/classif multiple times
		       selectWindow("LamininEnhanced");
		       run("Duplicate...", " ");
		       rename("Temp");
		       run("RGB Color");
		       roiManager("Open", ROIFiberFile);
		       nbFibers=roiManager("count");
		       roiManager("sort");
		       roiManager("select",nbFibers-1);
		       Roi.setStrokeColor("magenta");
		       Roi.setStrokeWidth(3);
		       run("Flatten");
		       rename(NameTypeImage);
		       close("Temp");
		       roiManager("Show all with labels");
		       roiManager("select",nbFibers-1);
		       roiManager("delete");
		       nbFibers=roiManager("count");

		       FiberPhenotype(fibtype,FiberPhenoType1,FiberPhenoType2A,FiberPhenoType2X,FiberPhenoType0,FiberTypeArr);
		       TypeCartographyFill(nbFibers,NameTypeImage,FiberPhenoType1,FiberPhenoType2A,FiberPhenoType2X,
					   FiberPhenoType0);

				if (CartographyBox=="Fiber Types") {
				TypeCartographyLegend(NameTypeImage, LegendBox);
				}

				open(RGBR);
				roiManager("Show all with labels");
				
    			waitForUser("Use the color-coded cartography and RGB image to edit the classification output. \n\
    						Select the ROI and press ''q'' to change colors. \n Blue=I \n Green=IIA \n Red=IIX \n Cyan=I-IIA \n Pink=I-IIX -> edit immediately \n\
    						Orange=IIA-IIX \n White=I-IIA-IIX \n Gray=Not detected");
				
				close(RGB);
				CheckCartography(nbFibers,NameTypeImage,nbFiberType1,nbFiberType2A,nbFiberType2X,nbFiberType0,FiberTypeArr);
				nbFiberType1=FiberCounts(FiberTypeArr,nbFiberType1,bl);
				nbFiberType2A=FiberCounts(FiberTypeArr,nbFiberType2A,gr);
				nbFiberType2X=FiberCounts(FiberTypeArr,nbFiberType2X,r);
				nbFiberType12A=FiberCounts(FiberTypeArr,nbFiberType12A,cy);
				nbFiberType12X=FiberCounts(FiberTypeArr,nbFiberType12X,p);
				nbFiberType2AX=FiberCounts(FiberTypeArr,nbFiberType2AX,o);
				nbFiberType0=FiberCounts(FiberTypeArr,nbFiberType0,gry);
				nbFiberType12AX=FiberCounts(FiberTypeArr,nbFiberType12AX,wh);
				TypeFiber=newArray(nbFiberType1,nbFiberType2A,nbFiberType2X,nbFiberType12A,nbFiberType12X,nbFiberType2AX,nbFiberType12AX,nbFiberType0); //fill global table with number of each fiber type (if type not analyzed = 0)

   			selectWindow(FiberTable);
   			Table.setColumn("Area (µm²)", FiberArea);
   		    Table.setColumn("Max Feret", FiberFeret);
   			Table.setColumn("Min Feret", MinFiberFeret);
   			Table.setColumn("Fiber type", FiberTypeArr);
   			Table.deleteRows(nbFibers, Table.size);
   			print(Table.size);
			   selectWindow(GlobalTable);
		       end=Table.size;
		       for (i=0; i<ColorArray.length; i++) {
		       	Table.set("Output", end, ColorArray[i]);
		       	Table.set("Results", end, TypeFiber[i]); 
		       	end=Table.size;
		       }

		       selectWindow(NameTypeImage);
		       roiManager("Show All without labels");
		       run("Flatten");
		       run("RGB Color");
		       saveAs("Jpeg", CartoDir+NameTypeImage);
		       close();
		       close(NameTypeImage); 
		       roiManager("reset");
    
	       print("Finished Classifying Cells");

		}	else if (option=="Finish") {

   			NameLamininResult=NameLamininResult+".csv";
   			selectWindow(FiberTable);
   			Table.save(ResultDir+NameLamininResult);			

		   NameGlobalResult=NameGlobalResult+".csv";
		   selectWindow(GlobalTable);
		   Table.save(ResultDir+NameGlobalResult);
	       done=true;

	   }
	   }
			run("Close All");
			close(FiberTable);
			close(GlobalTable);    
       }

showMessage(listin.length+"/"+listin.length+" images analyzed");
print("All done!");

