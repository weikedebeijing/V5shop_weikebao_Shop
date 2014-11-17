currentX = 0;
currentY = 400;  
whichIt = null;           
lastScrollX = 0; 
lastScrollY = 0;
IE = (document.all) ? 1: 0;
function heartBeat() {
    var diffY;
	if(IE) { diffY = document.documentElement.scrollTop; diffX = document.documentElement.scrollLeft; }
	else { diffY = self.pageYOffset; diffX = self.pageXOffset; }
	//alert(diffX);
	if(diffY != lastScrollY) {
		percent = .1 * (diffY - lastScrollY);
		if(percent > 0) 
			percent = Math.ceil(percent);
		else 
			percent = Math.floor(percent);
	    var top = parseInt(document.getElementById("floater").style.top) + percent;
		document.getElementById("floater").style.top = top + "px"; 
		lastScrollY = lastScrollY + percent;
	}
}

action = window.setInterval("heartBeat()",1);    