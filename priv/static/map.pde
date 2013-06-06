class Map {
        String name;
        ArrayList tiles;

        Map(String name) {
                this.name = name;
                tiles = new ArrayList();
                load();
        }

        void load() {
                Tile temp = new Tile( color(0, 200, 150));
                temp.add_vertex(10, 20);
                temp.add_vertex(100, 200);
                temp.add_vertex(200, 200);
                temp.add_vertex(200, 20);
                tiles.add(temp);
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
        ArrayList verticies;
        color c_fill;

        Tile(color c_fill) {
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

class Vertex {
        int x, y;
        Vertex(int x, int y){ this.x = x; this.y = y;}
        double distance(int x, int y) {
                return sqrt( sq(this.x - x) + sq(this.y - y));
        }
}


