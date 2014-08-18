import processing.dxf.*;

// Use PVector as a unit which holds an (x,y,z) position
// This allows us to access each point in 3D space without requiring
// separate x, y, and z variable

// The PVector variables are stored in a two-dimensional array here
// to match the structure of the two-dimensional "for" loop later
PVector[][] vertices = new PVector [10][10];
boolean export = false;

void setup(){
  size(600,600,P3D);
  stroke(255); // this will export curves in the DXF file
  noFill(); // without a fill, a solid mesh will not be exported
  
  for(int j = 0; j < 10; j++){
    for(int i=0; i < 10; i++){
      //fill in our vertices with initial information
      //here, the 'i' and 'j' values are offset by 40 to give them some more spacing
      vertices[i][j] = new PVector((i*40), (j*40), random(-10,10));
      
      
      // uncomment this line instead to apply some randomized 
      //variation onto the points as you're setting them up
      // vertices[i][j] = new PVector((i*40)+random(-10,10), (j*40)+random(-10,10), random(-10,10));
    }
  }
}

void draw(){
  
  if(export == true){
     beginRaw(DXF, "meshTest.dxf"); 
  }
  
  background(0);
  
  translate(width/4, height/4); // move the 0,0 point down into the window
  rotateY(map(mouseX,0,width,-PI,PI));
    
  // loop through the Y values first so that we create horizontal "strips"  
  for(int j=0; j<9; j++){
    beginShape(TRIANGLE_STRIP);
    for(int i=0; i<10; i++){
      
      // the first vertex at each X position is just the X,Y,Z coordinates 
      // of that specific PVector in the 2D array of vertices
      vertex( vertices[i][j].x, vertices[i][j].y, vertices[i][j].z);
      
      // the second vertex uses the X,Y,Z coordinates of the current PVector
      // in the X position (the "inside" for-loop), but the coordinates of the
      // NEXT PVector in the Y position.  this ensures that the strips will always
      // meet and share vertices.
  
      // compare to the way we were making meshes previously, 
      // where the two sets of points looked something like this:
      // vertex(i, 0);
      // vertex(i, 50);
      
      // now, instead of using an arbitrary Y offset, we're using the next
      // position in the array which we already gave an offset of 40 in setup().
      
      vertex( vertices[i][j+1].x, vertices[i][j+1].y, vertices[i][j+1].z);
      
      // NOTE: this is also why we only loop through 9 instead of 10 on the outer
      // for-loop.  if we were looping until j<10 instead of j<9, then the condition
      // of "j+1" on the last loop would be looking for a j value of 10. in
      // setup we only created j positions in the array until "less than 10", so there's
      // no 10th value and this would cause an error.
      
    }
    endShape();
  }
  
  if(export == true){
      endRaw();
      export = false;
  }
  
}

void keyPressed(){
   if(key == 'e'){
      export = true;
   } 
}
