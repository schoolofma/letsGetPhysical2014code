// for just one vertex, of data type PVector
PVector myVertex;

// for an array of 8 vertices, of data type PVector
PVector[] vertices = new PVector[8];

void setup(){
  size(600,600);
    
  // set up a single PVector vertex; we have to format the coordinate
  // data to the PVector type first
  myVertex = new PVector(0,0,0);
  
  // a PVector contains the (X,Y,Z) coordinates of a point
  // On myVertex, you can call the following properties:
  // myVertex.x = the X coordinate
  // myVertex.y = the Y coordinate
  // myVertex.z = the Z coordinate
  
  // set up the full array of PVectors by looping through the "i" iterator
  // in this case we're using the "i" value to offset the X coordinate
  // the Y coordinate in this case is staying constant at 0
  for(int i = 0; i < 8; i++){
    vertices[i] = new PVector(i * 20, 0);
  }
}

void draw(){
  
  pushMatrix();
  //move down and right into the center of the view window
  translate(width/2, height/2);
  
  // the calls to beginShape() and endShape() are outside the for loop
  // so that everything inside the loop is connected rather than made
  // into separate meshes
  beginShape(TRIANGLE_STRIP);
   for(int i = 0; i < 8; i++){ // loop through the same number of values that you initialized earlier
      vertex(vertices[i].x, vertices[i].y);
      vertex(vertices[i].x, vertices[i].y + 100); // the second set of vertices are to extend the "mesh strip" in the 
                                                  // Y dimension so that it creates triangles instead of lines
   }
   endShape();
   
   popMatrix();
  
}
