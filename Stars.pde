PImage sprite;  

int npartTotal = 40;
float partSize = 20;

PVector positions[];

int fcount, lastm;
float frate;
int fint = 3;

void setup() {
  size(800, 600, P3D);
  frameRate(120);
  
  sprite = loadImage("sprite.png");

  initPositions();

  // Writing to the depth buffer is disabled to avoid rendering
  // artifacts due to the fact that the particles are semi-transparent
  // but not z-sorted.
  hint(DISABLE_DEPTH_MASK);
} 

PVector vect= new PVector(0,0,0);


void draw () {
  background(0);
  

  translate(width/2, height/2);
  //rotateY(mouseX/100.0);
  //rotateX(mouseY/100.0);
  float ang = (mouseX/float(width))*3.14159*2;
  float ang2 = (mouseY/float(height))*3.14159;
  float eyeX,eyeY,eyeZ,distance =0;
  eyeX = sin(ang)*300*sin(ang2);
  eyeY = cos(ang)*300*sin(ang2);
  eyeZ = cos(ang2)*300;
    camera( eyeX, eyeY, eyeZ,
         0.0, 0.0, 0.0, // centerX, centerY, centerZ
         0.0, 0.0, 1.0); // upX, upY, upZ
  stroke(color(255,0,0));
  //for (int n = 0; n < npartTotal; n++){
  line(-100, 0, 0, 100, 0, 0);
  line(0, -100, 0, 0, 100, 0);
  line(0, 0, -100, 0, 0, 100);
  distance = sqrt(pow(eyeX,2)+pow(eyeY,2)+pow(eyeZ,2));
  
  vect= new PVector(eyeX/distance,eyeY/distance,eyeZ/distance);
  println(vect);
 
  for (int n = 0; n < npartTotal; n++) {
    drawParticle(positions[n],vect,partSize);
  }
  
  fcount += 1;
  int m = millis();
  if (m - lastm > 1000 * fint) {
    frate = float(fcount) / fint;
    fcount = 0;
    lastm = m;
    println("fps: " + frate); 
  }
  textSize(32);
  text(frate, 10, 30); 
}

void drawParticle(PVector center,PVector dir,float size) {
  beginShape(QUAD);
  noStroke();
  tint(255,127);
  //texture(sprite);
  normal(0, 1, 1);
  float wd = size/2;
  float inscribed = sqrt((dir.x*dir.x)+(dir.y*dir.y));
  float rot = atan(dir.y/dir.x)*57.3;
  float inclination = -atan(dir.z/inscribed)*57.3;
  println(inclination);
  
  //float z = sin((inclination-90)/57.3)*wd;
  //float x = -sin(rot/57.3)*wd;
  //float y = -cos(rot/57.3)*wd;
  
  float z = inscribed*wd;
  float x = dir.y*wd/inscribed;
  float y = dir.x*wd/inscribed;
  println("X:"+str(x)+" Y:"+str(y)+" Z:"+str(z));
  
  vertex(center.x - x, center.y + y, center.z+z, 0, 0);
  vertex(center.x + x, center.y - y, center.z+z, sprite.width, 0);
  vertex(center.x + x, center.y - y, center.z-z, sprite.width, sprite.height);
  vertex(center.x - x, center.y + y, center.z-z, 0, sprite.height);
  
  //vertex(center.x - size, center.y - wd, center.z, 0, 0);
  //vertex(center.x + size, center.y - wd, center.z, sprite.width, 0);
  //vertex(center.x + size, center.y + wd, center.z, sprite.width, sprite.height);
  //vertex(center.x - size, center.y + wd, center.z, 0, sprite.height);
  
  
  //vertex(center.x - wd, center.y - wd, center.z, 0, 0);
  //vertex(center.x + wd, center.y - wd, center.z, sprite.width, 0);
  //vertex(center.x + wd, center.y + wd, center.z, sprite.width, sprite.height);
  //vertex(center.x - wd, center.y + wd, center.z, 0, sprite.height);
  
  //vertex(center.x, center.y - wd, center.z - wd, 0, 0);
  //vertex(center.x, center.y - wd, center.z + wd, sprite.width, 0);
  //vertex(center.x, center.y + wd, center.z + wd, sprite.width, sprite.height);
  //vertex(center.x, center.y + wd, center.z - wd, 0, sprite.height);   
  
  //vertex(center.x - wd, center.y, center.z - wd, 0, 0);
  //vertex(center.x - wd, center.y, center.z + wd, sprite.width, 0);
  //vertex(center.x + wd, center.y, center.z + wd, sprite.width, sprite.height);
  //vertex(center.x + wd, center.y, center.z - wd, 0, sprite.height);   
  endShape();  
}

void initPositions() {
  positions = new PVector[npartTotal];
  for (int n = 0; n < positions.length; n++) {
    positions[n] = new PVector(random(-70, +70), random(-70, +70), random(-70, +70));
  }  
}

