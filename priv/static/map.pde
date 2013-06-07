class Map {
        ArrayList tiles;
	int x;
	int y;
	int hex_size;

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
				temp = new Hex(offset + (i * 3 * hex_size), j * sin(radians(60))*hex_size, color(0, i * (255/x), j * (255/y)), hex_size);
		                tiles.add(temp);
			}
		}
        }

        void save() {}

        void draw() {
                for (int i=0; i < tiles.size(); i++) {
                        Tile next = (Tile)tiles.get(i);
                        next.draw();
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

	Hex(int x, int y, color c_fill, float size){
		super(x, y, c_fill);
		c = size;
		a = c/2;
		b = sin(radians(60))*c;
	}

	void draw() {
		pushMatrix();
		translate(x, y);
		scale(size);
		fill(c_fill);
		beginShape();
		vertex(0,b);
		vertex(a,0);
		vertex(a+c,0);
		vertex(2*c,b);
		vertex(a+c,2*b);
		vertex(a,2*b);
		endShape(CLOSE);
		popMatrix();
	}

	static float x_offset(float size){
		return 1.5 * size;
	}

	static float y_offset(float size){
		return sin(radians(60))*size;
	}
		
}


class Vertex {
        int x, y;
        Vertex(int x, int y){ this.x = x; this.y = y;}
        double distance(int x, int y) {
                return sqrt( sq(this.x - x) + sq(this.y - y));
        }
}


