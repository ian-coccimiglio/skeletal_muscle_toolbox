/* This macro loops through the all the possible Selection colors using "q" as a keyboard shortcut */
 var cIdx;
 
macro "Change Selection Color [q]" {
	select=selectionType();
	if (select != -1) {
  		color= newArray("red", "green", "blue","pink", "cyan", "orange", "gray", "white");
  		Roi.setFillColor(color[cIdx++]);
  		if (cIdx==color.length) cIdx= 0;
  			roiManager("update");
	} else {
		showMessage("Please select region.");
	}
}