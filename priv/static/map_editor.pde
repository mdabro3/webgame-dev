
Control myControl = new Control();

void setup(){
	size(0,0);
	frameRate(30);
	resizeMap();
}

Map myMap = new Map('Test');

void draw(){
	background(0);
	pushMatrix();
	cursor(ARROW);
	translate(myControl.TRANSLATE_X, myControl.TRANSLATE_Y);
	scale(myControl.SCALE);
	myControl.viewLoop();
	myMap.draw();
	popMatrix();
}

void mouseScrolled() {
	if (mouseScroll > 0) {
		myControl.scale_up();
	}
	if (mouseScroll < 0) {
		myControl.scale_down();
	}
}
