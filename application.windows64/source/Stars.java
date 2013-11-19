import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Stars extends PApplet {

PImage sprite;  

int npartTotal = 40000;
float partSize = 50;

PVector positions[];

float CamDistance = 3000;

int fcount, lastm;
float frate;
int fint = 3;

PVector vect= new PVector(0,0,0);
float[] offsets = new float[5];



public void setup() {
  size(800, 600, P3D);
  frameRate(120);
  
  sprite = loadImage("Star.png");

  initPositions();

  // Writing to the depth buffer is disabled to avoid rendering
  // artifacts due to the fact that the particles are semi-transparent
  // but not z-sorted.
  hint(DISABLE_DEPTH_MASK);
} 

public void keyPressed()
{
  // If the key is between 'A'(65) to 'Z' and 'a' to 'z'(122)
  if(key == 'W' || key <= 'w') {
    partSize += partSize/20;
    println("New Particle Size: "+str(partSize)); 
  }
  if(key == 'S' || key <= 's') {
    partSize -= partSize/10;
    println("New Particle Size:"+str(partSize));
  }
}


public void draw () {
  background(0);
  translate(width/2, height/2);
  //rotateY(mouseX/100.0);
  //rotateX(mouseY/100.0);
  float ang = (mouseX/PApplet.parseFloat(width))*3.14159f*2;
  float ang2 = (-mouseY/PApplet.parseFloat(height))*3.14159f;
  float eyeX,eyeY,eyeZ,distance =0;
  eyeX = sin(ang)*CamDistance*sin(ang2);
  eyeY = cos(ang)*CamDistance*sin(ang2);
  eyeZ = cos(ang2)*CamDistance;
    camera( eyeX, eyeY, eyeZ,
         0.0f, 0.0f, 0.0f, // centerX, centerY, centerZ // where it is aiming
         0.0f, 0.0f, -1.0f); // upX, upY, upZ
  
  stroke(color(255,0,0));
  line(-1000, -1000, -1000, 1000, -1000, -1000); // bottom
  line(-1000, -1000, -1000, -1000, 1000, -1000);
  line(1000, 1000, -1000, 1000, -1000, -1000);
  line(1000, 1000, -1000, -1000, 1000, -1000);
    
  line(-1000, -1000, 1000, 1000, -1000, 1000);//top
  line(-1000, -1000, 1000, -1000, 1000, 1000);
  line(1000, 1000, 1000, 1000, -1000, 1000);
  line(1000, 1000, 1000, -1000, 1000, 1000);
  
  line(-1000, -1000, -1000, -1000, -1000, 1000);//Verticals
  line(-1000, 1000, -1000, -1000, 1000, 1000);
  line(1000, -1000, -1000, 1000, -1000, 1000);
  line(1000, 1000, -1000, 1000, 1000, 1000);
  
  distance = sqrt(pow(eyeX,2)+pow(eyeY,2)+pow(eyeZ,2));
  
  vect= new PVector(eyeX/distance,eyeY/distance,eyeZ/distance);
  
  float particleWidth = partSize/2;
  float zHeight = sqrt((vect.x*vect.x)+(vect.y*vect.y));
  float inclination = -atan(vect.z/zHeight)*57.3f;
  offsets[2] = zHeight*particleWidth;
  offsets[0] = vect.y*particleWidth/zHeight;
  offsets[1] = vect.x*particleWidth/zHeight;
  offsets[3] = (vect.x/zHeight)*sin(-inclination/57.3f)*particleWidth;
  offsets[4] = (vect.y/zHeight)*sin(-inclination/57.3f)*particleWidth;
  
  for (int n = 0; n < npartTotal; n++) {
    drawParticle(positions[n],offsets,partSize);
  }
  
  fcount += 1;
  int m = millis();
  if (m - lastm > 1000 * fint) {
    frate = PApplet.parseFloat(fcount) / fint;
    fcount = 0;
    lastm = m;
    //println("fps: " + frate); 
  }
  textSize(32);
  text(frate, 10, 30); 
}

public void drawParticle(PVector center,float[] offsets,float size) {
  beginShape(QUAD);
  noStroke();
  tint(255,127);
  texture(sprite);
  normal(0, 1, 1);
  
  vertex(center.x - offsets[0] - offsets[3], center.y + offsets[1] - offsets[4], center.z+offsets[2], 0, 0);
  vertex(center.x + offsets[0] - offsets[3], center.y - offsets[1] - offsets[4], center.z+offsets[2], sprite.width, 0);
  vertex(center.x + offsets[0] + offsets[3], center.y - offsets[1] + offsets[4], center.z-offsets[2], sprite.width, sprite.height);
  vertex(center.x - offsets[0] + offsets[3], center.y + offsets[1] + offsets[4], center.z-offsets[2], 0, sprite.height);
  
  endShape();  
}

public void mouseWheel(MouseEvent event) {
  float e = event.getAmount();
  CamDistance += (CamDistance/20)*e;
}



public void initPositions() {
  positions = new PVector[npartTotal];
  for (int n = 0; n < positions.length; n++) {
    positions[n] = new PVector(random(-1000, +1000), random(-1000, +1000), random(-1000, +1000));
  }  
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Stars" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
