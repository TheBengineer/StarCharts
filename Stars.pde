PImage sprite;  

int npartTotal = 40000;
float partSize = 4.5;

PVector positions[];

float CamDistance = 3000;
cell[][] cells;
//cells = (cell[][]) new cell[84][104];
int fcount, lastm;
float frate;
int fint = 3;

MersenneTwisterFast MT = new MersenneTwisterFast();

PVector vect= new PVector(0,0,0);
float[] offsets = new float[5];
float[][] starlist;

int cs = 10;

Sector universe;


void setup() {
  size(1000, 800, P3D);
  frameRate(120);
  int seed = 1;
  println("Generating Stars");
  starlist = genStars(7,40000,seed);
  println("Done Generating Stars");
  sprite = loadImage("Star.png");
  PVector test = new PVector(100,100,100);
  universe = new Sector(1,.04,test);
  print("Number of systems in Sector: ");
  println(universe.numSystems);
  println("Calculating Distances:");
  //PrintWriter Distances1 = createWriter("Distances1.csv");
  //PrintWriter Distances2 = createWriter("Distances2.csv");
  PrintWriter close = createWriter("Closest.csv");
  float distance = 0;
  float leastdistance = 0;
  for (int i = 0; i< universe.numSystems; i++){
    println("%"+str(((i+.001)/universe.numSystems)*100).substring(0,4)+" "+str(i));
    leastdistance = 100.0;
    for (int j = 0; j< universe.numSystems; j++){
      if (j != i){
        distance = sqrt(pow(universe.systems[i].position.x-universe.systems[j].position.x,2)+pow(universe.systems[i].position.y-universe.systems[j].position.y,2)+pow(universe.systems[i].position.z-universe.systems[j].position.z,2));
        if (distance < leastdistance){
          leastdistance = distance;
        }
      }
      close.println(str(leastdistance)+","+str(i));
    }
    close.flush();
    //Distances1.flush();
    //Distances2.flush();
  }
  
  positions = initPositions(seed,starlist);
  // Writing to the depth buffer is disabled to avoid rendering
  // artifacts due to the fact that the particles are semi-transparent
  // but not z-sorted.
  hint(DISABLE_DEPTH_MASK);
} 

void keyPressed()
{
  if(key == 'W' || key == 'w') {
    partSize += partSize/20;
    println("New Particle Size: "+str(partSize)); 
  }
  if(key == 'S' || key == 's') {
    partSize -= partSize/10;
    println("New Particle Size:"+str(partSize));
  }
  if(key == 'A' || key == 'a') {
    cs += 1;
    println("Civilization Size: "+str(cs)); 
  }
  if(key == 'D' || key == 'd') {
    cs -= 1;
    println("Civilization Size: "+str(cs)); 
  }
  if(key == 'R' || key == 'r') {
    sprite = loadImage("Star.png");
  }
}

float at = 0;
void draw () {
  background(0);
  translate(width/2, height/2);
  //rotateY(mouseX/100.0);
  //rotateX(mouseY/100.0);
  at += .0001;
  float ang = ((mouseX/float(width))*3.14159*2)+at;
  float ang2 = (-mouseY/float(height))*3.14159;
  float eyeX,eyeY,eyeZ,distance =0;
  eyeX = sin(ang)*CamDistance*sin(ang2);
  eyeY = cos(ang)*CamDistance*sin(ang2);
  eyeZ = cos(ang2)*CamDistance;
    camera( eyeX, eyeY, eyeZ,
         0.0, 0.0, 0.0, // centerX, centerY, centerZ // where it is aiming
         0.0, 0.0, -1.0); // upX, upY, upZ
  
  drawBox();
  
  distance = sqrt(pow(eyeX,2)+pow(eyeY,2)+pow(eyeZ,2));
  
  vect= new PVector(eyeX/distance,eyeY/distance,eyeZ/distance);
  
  stroke(color(0,0,255));
  for (int n = 100; n < 100+cs; n++) {
    line(positions[n].x,positions[n].y,positions[n].z,positions[n-1].x,positions[n-1].y,positions[n-1].z);
  }
  stroke(color(127,255,0));
  for (int n = 200; n < 200+cs; n++) {
    line(positions[n].x,positions[n].y,positions[n].z,positions[n-1].x,positions[n-1].y,positions[n-1].z);
  }
  stroke(color(255,0,255));
  for (int n = 300; n < 300+cs; n++) {
    line(positions[n].x,positions[n].y,positions[n].z,positions[n-1].x,positions[n-1].y,positions[n-1].z);
  }
  

  float zHeight = sqrt((vect.x*vect.x)+(vect.y*vect.y));
  float inclination = -atan(vect.z/zHeight)*57.3;
  float oftmx = (vect.x/zHeight)*sin(-inclination/57.3);
  float oftmy = (vect.y/zHeight)*sin(-inclination/57.3);
  for (int n = 0; n < npartTotal; n++) {
    float particleWidth = pow(starlist[n][0]/10,1/3.0)*partSize;
    if (particleWidth > 2){
      offsets[2] = zHeight*particleWidth;
      offsets[0] = vect.y*particleWidth/zHeight;
      offsets[1] = vect.x*particleWidth/zHeight;
      offsets[3] = oftmx*particleWidth;
      offsets[4] = oftmy*particleWidth;
      drawParticle(positions[n],offsets,Ktemp(int(starlist[n][1])));
    } 
  }
  
  fcount += 1;
  int m = millis();
  if (m - lastm > 1000 * fint) {
    frate = float(fcount) / fint;
    fcount = 0;
    lastm = m;
    //println("fps: " + frate); 
  }
  textSize(32);
  text(frate, 10, 30); 
}

void drawParticle(PVector center,float[] offsets,color col) {
  beginShape(QUAD);
  noStroke();
  tint(col,255);
  texture(sprite);
  normal(0, 1, 1);
  
  vertex(center.x - offsets[0] - offsets[3], center.y + offsets[1] - offsets[4], center.z+offsets[2], 0, 0);
  vertex(center.x + offsets[0] - offsets[3], center.y - offsets[1] - offsets[4], center.z+offsets[2], sprite.width, 0);
  vertex(center.x + offsets[0] + offsets[3], center.y - offsets[1] + offsets[4], center.z-offsets[2], sprite.width, sprite.height);
  vertex(center.x - offsets[0] + offsets[3], center.y + offsets[1] + offsets[4], center.z-offsets[2], 0, sprite.height);
  
  endShape();  
}

void mouseWheel(MouseEvent event) {
  float e = event.getAmount();
  CamDistance += (CamDistance/20)*e;
}


