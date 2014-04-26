
ArrayList tiles;

class Map {
//        ArrayList tiles;
	int x;
	int y;
	int hex_size;
	bool orientation = true;

        Map(String name, int x, int y, int hex_size) {
		this.x = x;
		this.y = y*2;
		this.hex_size = hex_size;
                tiles = new ArrayList();
                load();
        }

        void load() {
		Hex temp;
		float offset = 0.0;
		for(int i=0; i<x; i++){
			for(int j=0; j<y; j++){
				if (j%2==0)
					offset = 0.0;
				else
					offset = 1.5 * hex_size;
				int temp_x = offset + (i * 3 * hex_size) + hex_size;
				int temp_y = j * sin(radians(60))*hex_size + hex_size;
				if (!orientation) {
				    int temp = temp_x;
				    temp_x = temp_y;
				    temp_y = temp;
				}
				temp = new Hex(temp_x, temp_y, color(0, i * (255/x), j * (255/y)), hex_size, orientation);
		                tiles.add(temp);
			}
		}
        }

        void save() {}

        void draw() {
                for (int i=0; i < tiles.size(); i++) {
                        Tile next = (Tile)tiles.get(i);
                        next.draw(tiles);
                }
        }
}


class Tile {
	int x;
	int y;
        ArrayList verticies;
        color c_fill;

        Tile(int x, int y, color c_fill) {
		this.x=x;
		this.y=y;	
                this.c_fill = c_fill;
                verticies = new ArrayList();
        }

        void add_vertex(int x, int y) {
                verticies.add(new Vertex(x,y));
       } 

        void draw() {
                pushMatrix();
		translate(x,y);
                fill(c_fill);
                beginShape();
                for (int i=0; i < verticies.size(); i++) {
                        Vertex next = (Vertex)verticies.get(i);
                        vertex(next.x, next.y);
                }
                endShape(CLOSE);
                for (int i=0; i < verticies.size(); i++) {
                        Vertex next = (Vertex)verticies.get(i);
                        stroke(255);
                        noFill();
                        ellipse(next.x, next.y, 5, 5);
                        if (  next.distance(mouseX, mouseY) < 10 ) {
                                cursor(MOVE);
                        }
                }
                popMatrix();
        }
}


class Hex extends Tile {
	float a;
	float b;
	float c;
	bool flat_top;

	Hex(int x, int y, color c_fill, float size, bool flat_top){
		super(x, y, c_fill);
		c = size;
		a = c/2.0;
		b = sin(radians(60))*c;
		this.flat_top = flat_top;
	}

	void draw() {
		pushMatrix();
		translate(x, y);
		if (!flat_top)
		    rotate(PI/2.0);
		if (mouse_over()){
			fill(color(255,0,0));
			tiles.add(new Info(x, y, c_fill));
		}
		else
			fill(c_fill);
		beginShape();
		for (int i=0; i<6; i++){
		    	float angle = 2 * PI / 6 * i;
		    	vertex(c * cos(angle), c * sin(angle));
		}
//		vertex(0,b);
//		vertex(a,0);
//		vertex(a+c,0);
//		vertex(2*c,b);
//		vertex(a+c,2*b);
//		vertex(a,2*b);
		endShape(CLOSE);
		popMatrix();
	}

	bool mouse_over(){
//		if (mouseX < x)
//			return false;
//		if (mouseY < y)
//			return false;
//		if (mouseX > x + 2*a + c)
//			return false;
//		if (mouseY > y + 2*b)
//			return false;
		if (sqrt( sq(x-mouseX) + sq(y-mouseY)) > (c-2))
		    return false;
		return true;
	}

	static float x_offset(float size){
		return 1.5 * size;
	}

	static float y_offset(float size){
		return sin(radians(60))*size;
	}
		
}

class Info extends Tile {
    	
	Info(int x, int y, color c_fill){
		super(x, y, c_fill);
	}

	void draw(){
	    fill(color(50,50,50));
	    rect(x, y-50, 100, 50, 5);
	    fill(color(255,255,255));
	    text("YOLO", x+5, y-40);
	    tiles.remove(this);
	}
}
	


class Vertex {
        int x, y;
        Vertex(int x, int y){ this.x = x; this.y = y;}
        double distance(int x, int y) {
                return sqrt( sq(this.x - x) + sq(this.y - y));
        }
	double distance(Vertex x){
	    	return distance(x.x, x.y);
	}
}


