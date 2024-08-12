


/*Requirements : tif 16 bit file
From Zen : 
[Processing]
Method v
		Image Export
Parameters v
		File type : Tagged Image File Format (tiff)
		8bit - deselect
		Compression : NONE
		Original Data - select
		Apply Display Curve and Channel Color - deselect
		Export to : choose file where all images are
		Create folder - select
*/
 // 1) Ask for image's folder
// => Content list
// 2) Open C1
// 3) Duplicate and reduce noise with threshold
// 4) Detection of Myofibers 
// 5) Fill holes for every ROI 
// 6) Fiber's detection, size between 100 pixels and 30000, circularity > 0.10
// 7) Label in Cyan. circularity<0.45&Area<500
// 8) Save the flatten image
// 9) Save results
// 10) Open C2
// 11) Duplicate and reduce noise with threshold
// 12) Recovery of ROI for detected fibers in C1
// 13) Eliminate fibers that don't have the Fast Myosin staining
// 14) Save the flatten image
// 15) Save results



//Variables 
Amin = 250;//Area min  
AMax = 13000;//Area max 

Circmin = 0.40;// Circularity min 
CircMax = 1.00;//Circularity Max

MinorDia = 1.5;//Minor Diameter
//Dialog box for parameters
Dialog.create("Parameters ");
Dialog.addMessage ("Exclusion parameters\n");

Dialog.addNumber("Minimum Area", 250);
Dialog.addNumber("Maximum Area", 13000);

Dialog.addMessage ("\n");
Dialog.addNumber("Minimum Circularity", 0.4);
Dialog.addNumber("Maximum Circularity", 1);

Dialog.addMessage ("\n");
Dialog.addNumber("Minor Diameter", 1.5);

Dialog.show();

Amin = Dialog.getNumber();
AMax = Dialog.getNumber();

Circmin = Dialog.getNumber(); 
CircMax = Dialog.getNumber();

MinorDia = Dialog.getNumber();
//

//Some settings for the macro
run("Colors...", "foreground=black background=white selection=cyan");
run("Set Measurements...", "area mean perimeter fit shape feret's redirect=None decimal=2");//
roiManager("Reset");
run("Clear Results");
run("Close All");
setTool("hand");
if(isOpen("Log")==1){
	selectWindow("Log");
	run("Close");
};
//
function Analyse(){
// If file is finished by 1_ORG.tif so the analysis is completed
	if (endsWith(file,"1_ORG.tif")==1){
		run("Close All");
			
		open(fich);
		nom = getTitle();
		ID = getImageID();
		DirI = getDirectory("Image");
		print(DirI);
		run("Clear Results");
		roiManager("Reset");
		run("Set Scale...", "distance=773 known=500 pixel=1 unit=µm global");
		h = getHeight();
		w = getWidth();	
		
		//delimitation of the tissue
		run("Duplicate...", "title=Muscle_c1_ORG-1.tif");
		run("Despeckle");
		run("Enhance Contrast...", "saturated=10 normalize");
		setAutoThreshold("Yen dark");
		setOption("BlackBackground", true);
		run("Convert to Mask");
		run("Erode");
		run("Erode");
		run("Fill Holes");
		run("Dilate");
		run("Analyze Particles...", "size=15000-Infinity  show=Masks exclude clear");
		run("Create Selection");
		run("Measure");//mesure surface tissue
		TissueAr = getResult("Area",0);
		run("Clear Results");
		run("Close");
		
		selectImage(ID);
		run("Restore Selection");
		setBackgroundColor(0, 0, 0);
		run("Clear Outside");
		run("Select None");
		run("Colors...", "foreground=black background=white selection=cyan");
		
		
		
		//Duplicate and image treatment
		run("Duplicate...", "title=BIN_C1");
		run("Despeckle");
		run("Enhance Contrast...", "saturated=5 normalize equalize"); //
		run("Subtract Background...", "rolling=10 sliding");
		
		//threshold
		setAutoThreshold("IsoData");
		
		setOption("BlackBackground", false);
		run("Convert to Mask");		
		run("Close-");
		run("Erode");
		run("Analyze Particles...", "size=2-2000000 pixel circularity=0.1-1.00 exclude clear add");
		roiManager("Deselect");
		roiManager("multi-measure");
		n=roiManager("count");		
		for (j=0;j<n;j++){
			roiManager("select",j);
			roiManager("Fill");
		};	
		run("Clear Results");
		roiManager("Deselect");
		roiManager("delete");
		
		run("Set Measurements...", "area perimeter fit shape feret's redirect=None decimal=2");
		run("Analyze Particles...", "size="+Amin+"-"+AMax+" circularity="+Circmin+"-"+CircMax+" display exclude clear add");
		selectWindow("BIN_C1");
		run("Close");
		n=roiManager("count");

		for (j=0;j<n;j++){
			roiManager("select",j);
			Ar = getResult("Area",j);
			Ci = getResult("Circ.",j);
			Mi = getResult("Minor",j);
			if((Ar<500&&Ci<0.50)||Mi<MinorDia){
				roiManager("Set Fill Color", "#cc00ffff");
			};
		};

		// Save the flatten image
		selectWindow(nom);
		roiManager("Show All with labels");
		run("Flatten");
		saveAs("Jpeg", DirI+nom+"_Fibers_Flatten.jpg");
		newImage("ROI_C1", "8-bit white", w, h, 1);
		
		
		for (j=0;j<n;j++){
			roiManager("select",j);
			Ar = getResult("Area",j);
			Ci = getResult("Circ.",j);
			Mi = getResult("Minor",j);
			if((Ar<500&&Ci<0.5||Mi<MinorDia)){
				IJ.deleteRows(j,j);
				roiManager("delete");
				j--;
				n=roiManager("count");
			};
			else
			{
				roiManager("Fill");
			};	
		};
		


		// Save results
		selectWindow("Results");
		saveAs("Results", DirI+nom+"_Results.xls");
		print("Parameters\n");
		print("Minimum Area "+Amin);
		print ("Maximum Area "+AMax);
		print("Minimum Circularity "+Circmin);
		print("Maximum Circularity "+CircMax);
		print("Minor Diameter "+MinorDia+"\n");
		print (nom);
		print(" Tissue Area detected : "+TissueAr);
		print ("Number of fibers : "+nResults);
		selectWindow("Log");
		run("Text...", "save="+DirI+"Log_"+nom+".txt");
		saveAs("Text", ""+DirI+"Log_"+nom+".txt");
		
	
		
		nR = nResults;
		for (j=0; j<nR; j++){
			petita = getResult("Minor",j);
			roiManager("select",j);
			
			if (petita>1&&petita<=10){
				roiManager("Set Fill Color", "#9932cc");//Dark Orchid
			};

			if (petita>10&&petita<=20){
				roiManager("Set Fill Color", "#00008b");//Blue Night
			};

			if (petita>20&&petita<=30){
				roiManager("Set Fill Color", "#87cefa");//Cyan
			};

			if (petita>30&&petita<=40){
				roiManager("Set Fill Color", "#008b8b");//Dark Cyan
			};

			if (petita>40&&petita<=50){
				roiManager("Set Fill Color", "#8fbc8f");//Dark Sea Green
			};

			if (petita>50&&petita<=60){
				roiManager("Set Fill Color", "#ffdead");//Yellow
			};

			if (petita>60&&petita<=70){
				roiManager("Set Fill Color", "#ffa500");//Orange
			};
			if (petita>70){
				roiManager("Set Fill Color", "#ff4500");//Red
			};
		};		
		
		selectWindow(nom);
		
		roiManager("Show All without labels");
		run("Flatten");
		saveAs("Jpeg", DirI+nom+"_Flatten_SmallDiameter.jpg");

		for (j=0; j<nR; j++){
			area = getResult("Area",j);
			roiManager("select",j);
			
			if (area>1&&area<=1000){
				roiManager("Set Fill Color", "#9932cc");//Dark orchid
			};
			if (area>1000&&area<=1500){
				roiManager("Set Fill Color", "#00008b");//Blue Night
			};
			if (area>1500&&area<=2000){
				roiManager("Set Fill Color", "#87cefa");//Cyan
			};
			if (area>2000&&area<=2500){
				roiManager("Set Fill Color", "#008b8b");//Dark Cyan
			};
			if (area>2500&&area<=3000){
				roiManager("Set Fill Color", "#8fbc8f");//Dark Sea Green
			};
			if (area>3000&&area<=3500){
				roiManager("Set Fill Color", "#ffdead");//Yellow
			};
			if (area>3500&&area<=4000){
				roiManager("Set Fill Color", "#ffa500");//Orange
			};
			if (area>4000){
				roiManager("Set Fill Color", "#ff4500");//Red
			};
		};		
		open(fich);
		roiManager("Show All without labels");
		run("Flatten");
		saveAs("Jpeg", DirI+nom+"_Flatten_Area.jpg");
	};
	
	//If file is finished by 2_ORG.tif so the analysis is completed
	if (endsWith(file,"2_ORG.tif")==1){
		open(fich);
		nom = getTitle();
		DirI = getDirectory("Image");
		w = getWidth();
		h = getHeight();
		// Duplicate and image treatment
		run("Duplicate...", "title=BIN_C2");
		run("Despeckle");
		run("Enhance Contrast...", "saturated=5 normalize equalize"); 
		
		run("Subtract Background...", "rolling=30 sliding");
		//Threshold
		setAutoThreshold("Li Dark");
		setOption("BlackBackground", false);
		run("Convert to Mask");
	
		selectWindow("ROI_C1");
		run("Create Selection");
		selectWindow("BIN_C2");
		run("Restore Selection");

		run("Clear Outside");
		run("Fill Holes");
		run("Select None");
		selectWindow("ROI_C1");
		run("Select None");
		
		run("Set Measurements...", "area mean perimeter fit shape feret's redirect=None decimal=2");
		run("Analyze Particles...", "size="+Amin+"-"+AMax+" circularity="+Circmin+"-"+CircMax+" display exclude clear add");
		
		selectWindow("BIN_C2");
		roiManager("multi-measure measure_all");
		run("Close");
		
		//Create a white image to receive the ROI
		newImage("ROI_C2", "8-bit white", w, h, 1);
		n=roiManager("count");
		//Elimination of myofibers with no staining
		for (j=0;j<n;j++){
			roiManager("select",j);
			moyI = getResult("Mean",j);
			
			if(moyI<40){
				IJ.deleteRows(j,j);
				roiManager("delete");
				j--;
				n=roiManager("count");
			};
			else
			{
				roiManager("Fill");
			};		
		};
		
		// Save the flatten image
		
		selectWindow(nom);
		roiManager("Show All with labels");
		
		run("Flatten");
		saveAs("Jpeg", DirI+nom+"_Flatten_TypeI_fibers.jpg");
		
		
		// Save results
		run("Set Measurements...", "area perimeter fit shape feret's redirect=None decimal=2");
		selectWindow("Results");
		saveAs("Results", DirI+nom+"_TypeI_fibers_Results.xls");
		print(" ");
		print (nom);
		print ("Number of Type I fibers : "+nResults);

		selectWindow("ROI_C1");
		run("Select None");
		run("Invert");
		selectWindow("ROI_C2");
		run("Invert");
		
		imageCalculator("Subtract create", "ROI_C1","ROI_C2");

		run("Invert");
	
		run("Set Measurements...", "area perimeter fit shape feret's redirect=None decimal=2");
		run("Analyze Particles...", "size="+Amin+"-"+AMax+" circularity="+Circmin+"-"+CircMax+" display exclude clear add");
		
		// Save results
		selectWindow(nom);
		roiManager("Show All with labels");
		
		run("Flatten");
		saveAs("Jpeg", DirI+nom+"_Flatten_TypeII_fibers.jpg");
		// run("Close");		
		selectWindow("Results");
		saveAs("Results", DirI+nom+"_TypeII_fibers_Results.xls");

		print ("Number of Type II fibers : "+nResults);
		print(" ");
		selectWindow("Log");
		run("Text...", "save="+DirI+"Log_"+nom+".txt");
		saveAs("Text", ""+DirI+"Log_"+nom+".txt");
		
		selectWindow("Log");
		run("Close");
	};

};


//  Ask the image's folder
Dir = getDirectory("Choose the folder with pictures to be treated");
// List the content of the home folder 
list = getFileList(Dir);
print(Dir);

//loop to browse the content of the folder
for (i=0; i<list.length; i++){
	fichier=list[i];
	name =Dir+fichier;
	
	run("Clear Results");
	setBatchMode(true);
	if(File.isDirectory(name)==1){
			list2 = getFileList(name);
			for (g=0;g<list2.length;g++){
				file = list2[g];
				fich = name+file;
				Analyse();
			};
		};
	else{
		fich = name;
		file = fichier;
		Analyse();
	};
};
	waitForUser("Analysis Completed");
//EOF
