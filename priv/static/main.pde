
Control myControl = new Control();

void setup(){
	size(0,0);
	frameRate(30);
	resizeMap();
}

void keyPressed() { myControl.keyPressed(key, keyCode); }
void keyReleased() { myControl.keyReleased(key, keyCode); }

Map myMap = new Map('Test');

void draw(){
	background(0);
	pushMatrix();
	cursor(ARROW);
	translate(myControl.TRANSLATE_X, myControl.TRANSLATE_Y);
	scale(myControl.SCALE);
	myControl.viewLoop();
	myMap.draw();
	myControl.printStatus();
	String s = "Scale: " + str(myControl.SCALE.toFixed(2));
	text(s, 10, 10, 200, 100);
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
