ArrayList points;

ArrayList getPoints() { return points; }

void setup() {
	size(800,600);
	points = new ArrayList();
//	noLoop();
	background(125);
	fill(255);
}

void draw() {
	background(125);
	if(mousePressed == true) {
		points.add(new Point(mouseX,mouseY));
	}
	for(int p=0, end=points.size(); p<end; p++) {
		Point pt = (Point)points.get(p);
		ellipse(pt.x,pt.y,2,2);
	}

}

void mouseClicked() {
	points.add(new Point(mouseX, mouseY));
	redraw();
}

class Point {
	int x,y;
	Point(int x, int y) { this.x=x; this.y=y; }
//	void draw() { ellipse(x,y,10,10); }
}
