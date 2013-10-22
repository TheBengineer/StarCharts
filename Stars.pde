PImage sprite;  

int npartTotal = 40000;
float partSize = 2;

PVector positions[];

int fcount, lastm;
float frate;
int fint = 3;

void setup() {
  size(800, 600, P3D);
  frameRate(60);
  
  sprite = loadImage("sprite.png");

  initPositions();

  // Writing to the depth buffer is disabled to avoid rendering
  // artifacts due to the fact that the particles are semi-transparent
  // but not z-sorted.
  hint(DISABLE_DEPTH_MASK);
} 

void draw () {
  background(0);
  

  translate(width/2, height/2);
  //rotateY(mouseX/100.0);
  //rotateX(mouseY/100.0);
  float ang = (mouseX/float(width))*3.14159;
    camera(sin(ang)*300, cos(ang)*300, (mouseY-(height/2))*-1.0, // eyeX, eyeY, eyeZ
         0.0, 0.0, 0.0, // centerX, centerY, centerZ
         0.0, 0.0, 1.0); // upX, upY, upZ
  stroke(color(255,0,0));
  //for (int n = 0; n < npartTotal; n++){
  line(-100, 0, 0, 100, 0, 0);
  line(0, -100, 0, 0, 100, 0);
  line(0, 0, -100, 0, 0, 100);
 
 
  for (int n = 0; n < npartTotal; n++) {
    drawParticle(positions[n]);
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

void drawParticle(PVector center) {
  beginShape(QUAD);
  noStroke();
  tint(255);
  texture(sprite);
  normal(0, 0, 1);
  //vertex(center.x - partSize/2, center.y - partSize/2, center.z, 0, 0);
  //vertex(center.x + partSize/2, center.y - partSize/2, center.z, sprite.width, 0);
  //vertex(center.x + partSize/2, center.y + partSize/2, center.z, sprite.width, sprite.height);
  //vertex(center.x - partSize/2, center.y + partSize/2, center.z, 0, sprite.height);
  
  vertex(center.x, center.y - partSize/2, center.z - partSize/2, 0, 0);
  vertex(center.x, center.y - partSize/2, center.z + partSize/2, sprite.width, 0);
  vertex(center.x, center.y + partSize/2, center.z + partSize/2, sprite.width, sprite.height);
  vertex(center.x, center.y + partSize/2, center.z - partSize/2, 0, sprite.height);   
  
  vertex(center.x - partSize/2, center.y, center.z - partSize/2, 0, 0);
  vertex(center.x - partSize/2, center.y, center.z + partSize/2, sprite.width, 0);
  vertex(center.x + partSize/2, center.y, center.z + partSize/2, sprite.width, sprite.height);
  vertex(center.x + partSize/2, center.y, center.z - partSize/2, 0, sprite.height);   
  endShape();  
}

void initPositions() {
  positions = new PVector[npartTotal];
  for (int n = 0; n < positions.length; n++) {
    positions[n] = new PVector(random(-70, +70), random(-70, +70), random(-70, +70));
  }  
}

