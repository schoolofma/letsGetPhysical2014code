import processing.dxf.*;

// an ArrayList is similar to an array, but it is dynamically sized,
// so it's easy to add and remove elements (whereas an array is fixed
// at whatever size it was set up to be).

// the syntax for creating an ArrayList is:
// ArrayList < data type > name;
// another example would be:
// ArrayList <int> myListOfNumbers;
// but here we're using PVector as a data type and i'm calling it "vertices".
ArrayList <PVector> vertices;

boolean didSave;

void setup(){
  size(600,600,P3D);
   stroke(255);
   // commenting out the noFill() function allows for DXF export of mesh surfaces
   //noFill(); 
   didSave = false;
    
   // create a new PVector ArrayList, the empty parentheses are because
   // we're not telling it any particular size to start off at.
   vertices = new ArrayList<PVector>();
   

}

void draw(){
  
  background(0);
  
  if(didSave == true){
   beginRaw(DXF, "test_01.dxf"); 
  }
 
   beginShape(TRIANGLE_STRIP);
   // here, instead of the "i" iterator controlling the X or Y coordinates of
   // the mesh, we're just referencing back to stored data points at the "i"
   // position within the ArrayList.
   
   // because ArrayLists are dynamic and variable in size, you can find their
   // current size by using the function name.size() where name is the variable
   // name of the ArrayList.
    for(int i = 0; i < vertices.size(); i++){
      
      // here's a temporary variable to hold the current position information
      // this variable is local because we don't need to use it anywhere else
      PVector curVertex = vertices.get(i);
      // vertices.get(i) is the syntax for accessing the "i" position in the
      // vertices ArrayList, similar to vertices[i] in a standard array.      
      vertex(curVertex.x, curVertex.y, curVertex.z);
    }
  endShape();
  
  if(didSave == true){
    endRaw();
    didSave = false;
  }
  
}

void mousePressed(){
  
  // when we click, add two new PVectors into the vertices ArrayList
  vertices.add(new PVector(mouseX,mouseY));
  
  // the second vertex is again just a vertical offset to give some Y-depth
  // to the mesh.  try uncommenting this and just placing points by click to see
  // the difference -- or try adding in Z values based on randomness or some
  // condition within the sketch!
  vertices.add(new PVector(mouseX, mouseY + 150));
  
  
}

void keyPressed(){
  
  if(key == 'e'){
    didSave = true;
  }
  
}


