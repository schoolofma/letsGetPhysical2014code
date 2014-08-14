import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.volume.*;
import toxi.processing.*;

VolumetricSpace volume;
VolumetricBrush brush;
IsoSurface surface;
TriangleMesh mesh;
ToxiclibsSupport gfx;

void setup() {
  size(800, 800, P3D);
  noStroke();
  fill(255);

  Vec3D SCALE = new Vec3D(width/2, width/2, width/2);

  gfx = new ToxiclibsSupport(this);
  volume = new VolumetricSpaceArray(SCALE, 64, 64, 64);
  brush = new RoundBrush(volume, 10);
  surface = new ArrayIsoSurface(volume);
  mesh = new TriangleMesh();
}

void draw() {
  background(50);
  translate(width/2, height/2, 0);
  rotateY(frameCount * 0.01);
  directionalLight(255, 220, 200, 1, 1, 1);
  directionalLight(200, 220, 255, -1, -1, -1);

  float t = millis() * 0.001;
  float k = width * 0.2;
  Vec3D pos = new Vec3D(k*sin(t), k*sin(t*1.2), k*sin(t*1.5));
  brush.setSize(6+5*sin(t));

  brush.drawAtAbsolutePos(pos, 0.5);
  volume.closeSides();  
  surface.reset();
  surface.computeSurfaceMesh(mesh, 0.1);

  gfx.mesh(mesh);
}
