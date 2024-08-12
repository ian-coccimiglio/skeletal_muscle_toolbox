## Distribution of Open-CSAM macro
## Presented as-is from the Open-CSAM publication https://skeletalmusclejournal.biomedcentral.com/articles/10.1186/s13395-018-0186-6
## Original by Thibaut Desgeorges, 2019.
## Redistribution by Ian Coccimiglio, 2024.
## Licensed under Creative Commons Public Domain (CC0)
##########################################################################

// Initialisation
roiManager("Reset");
setBackgroundColor(0, 0, 0);
run("Close All");
if (isOpen("Summary")) {
selectWindow("Summary");
run("Close");
}
if (isOpen("Results")) {
selectWindow("Results");
run("Close");
}

// Open muscle section image
open();
run("Set Scale...", "distance=1 known=0.645 unit=μm");
original = getImageID();
run("Duplicate...", " ");
mask = getImageID();

setAutoThreshold("Huang");

setOption("BlackBackground", false);
run("Convert to Mask");
run("Options...", "iterations=2 count=1 do=Open");
run("Fill Holes");

run("Set Measurements...", "area shape feret's area_fraction
display add redirect=None decimal=3");
run("Analyze Particles...", "size=100-Infinity circularity=0.4-
1.00 show=Masks display exclude summarize add in_situ");

roiManager("Show All");
selectImage(original);
run("Enhance Contrast", "saturated=0.35");
roiManager("Show All")
