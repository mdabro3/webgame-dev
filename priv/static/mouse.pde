ArrayList points;

ArrayList getPoints() { return points; }

int TRANSLATE_X = 0;
int TRANSLATE_Y = 0;
int TRANSLATE_RATE = 7;
double SCALE = 1.0;
double SCALE_RATE = 0.1;


  boolean[] locked = new boolean[256];
  boolean[] keyDown = new boolean[256];
  int[] keyCodes = {};

  // if pressed, and part of our known keyset, mark key as "down"
  private void setIfTrue(int mark, int target) {
    if(!locked[target]) {
      if(mark==target) {
        keyDown[target] = true; }}}

  // if released, and part of our known keyset, mark key as "released"
  private void unsetIfTrue(int mark, int target) {
    if(mark==target) {
      locked[target] = false;
      keyDown[target] = false; }}

  // lock a key so that it cannot be triggered repeatedly
  protected void ignore(char key) {
    int keyCode = int(key);
    locked[keyCode] = true;
    keyDown[keyCode] = false; }

  // add a key listener
  protected void handleKey(char key) {
    int keyCode = int(key),
        len = keyCodes.length;
    int[] _tmp = new int[len+1];
    arrayCopy(keyCodes,0,_tmp,0,len);
    _tmp[len] = keyCode;
    keyCodes = _tmp;
  }

  // check whether a key is pressed or not
  protected boolean isKeyDown(char key) {
    int keyCode = int(key);
    return keyDown[keyCode];
  }
  
  protected boolean noKeysDown() {
    for(boolean b: keyDown) { if(b) return false; }
    for(boolean b: locked) { if(b) return false; }
    return true;
  }

  // handle key presses
  void myKeyPressed(char key, int keyCode) {
    for(int i: keyCodes) {
      setIfTrue(keyCode, i); }}

  // handle key releases
  void myKeyReleased(char key, int keyCode) {
    for(int i: keyCodes) {
      unsetIfTrue(keyCode, i); }}

void keyPressed() { myKeyPressed(key, keyCode); }
void keyReleased() { myKeyReleased(key, keyCode); }


void setup(){
	size(0,0);
	points = new ArrayList();
	//noLoop();
	strokeWeight( 2 );
	frameRate( 30 );
	resizeMap();
	handleKey('W');
	handleKey('A');
	handleKey('S');
	handleKey('D');
}

void draw(){
	background(0);
	pushMatrix();
	translate(TRANSLATE_X, TRANSLATE_Y);
	scale(SCALE);
	if (keyPressed) {
		if (isKeyDown('W')) {
			TRANSLATE_Y += TRANSLATE_RATE;
		}
		if (isKeyDown('S')) {
			TRANSLATE_Y -= TRANSLATE_RATE;
		}
		if (isKeyDown('D')) {
			TRANSLATE_X += TRANSLATE_RATE;
		}
		if (isKeyDown('A')) {
			TRANSLATE_X -= TRANSLATE_RATE;
		}
	}
	for(int p=0, end=points.size(); p<end; p++){
		Point pt = (Point)points.get(p);
		if(p <end-1){
			Point next = (Point)points.get(p+1);
			stroke(255,0,0);
			line(pt.x,pt.y,next.x,next.y);
		}
		pt.draw();
	}
	popMatrix();
}

	
void mouseScrolled() {
  if (mouseScroll > 0) {
    // scroll up
	SCALE += SCALE_RATE;
  } else if (mouseScroll < 0) {
    // scroll down
	SCALE -= SCALE_RATE;
  }
}


void mouseClicked() {
//	points.add(new Point(mouseX,mouseY));
	newPoint(mouseX - TRANSLATE_X, mouseY - TRANSLATE_Y);
//	addPoint(x, y);
	redraw();
}

class Point {
	int x,y;
	Point(int x, int y){ this.x = x; this.y=y; }
	void draw(){ stroke(0); fill(255,0,0); ellipse(x,y,10,10); }
}

point addPoint(int x, int y) {
	Point pt = new Point(x,y);
	points.add(pt);
	pt.draw();
	redraw();
	return(pt);
}

void clearPoints() {
	points = new ArrayList();
	resizeMap();
	redraw();
}

