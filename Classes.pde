class cell{
  String label = "Star";
  int stars = 0;
  color col = color(255,255,255);
  cell(String label,int stars,color col){
    label = label;
    stars = stars;
    col = col;
  }
}


class Sector{
   int seed;
   float density;
   PVector size;
   float volume;
   int numSystems;
   float[][] starDataList;
   System[] systems;
   System[] gen(int seed,int numSystems,PVector size){
     //starDataList = genStars(7,numStars,seed);
     System[] systems = new System[numSystems];
     MersenneTwisterFast sectorLocalMT = new MersenneTwisterFast();
     sectorLocalMT.setSeed(seed);
     println(numSystems);
     println(systems.length);
     for (int i = 0;i< numSystems;i++){
       int tmpseed = int(sectorLocalMT.nextFloat()*1000000);
       print("tmp seed:");
       println(tmpseed);
       systems[i] = new System(tmpseed,size);
     }
     return systems;
   }
   Sector(int seed,float density, PVector size){
     density = density;
     size = size;
     volume = size.x*size.y*size.z;
     numSystems = int(volume*density); //todo adjust this for multiple stars in system
     systems = gen(seed,numSystems,size);
   }
}


class Body{
  int seed = 0;
  int type = 0;
  /*
  0 = Star
  1 = planet
  2 = moon
  3 = Asteroid
  */
  float size = 0.0;
  float orbitRadius = 0.0;// In Au
  int moonsNum = 0;
  Body[] moons;
  Body(){
    
  }
}

class Star extends Body{
  int seed = 0;
  Float luminocity = 0.0;
  Float temperature = 0.0;
  color col;
  Body[] bodies;
  Star(){
    
  }
}

class System{
  int seed;
  PVector position = new PVector(0,0,0);
  int systemType; // How many stars are in the system.
  int planetsNum;
  Star[] Stars;
  Body[] Planets;
  int gen(PVector size,int seed){
    MersenneTwisterFast systemLocalMT = new MersenneTwisterFast();
    systemLocalMT.setSeed(seed);// the order of what happens next is important.
    position.x = systemLocalMT.nextFloat()*size.x;
    position.y = systemLocalMT.nextFloat()*size.y;
    position.z = systemLocalMT.nextFloat()*size.z;
    systemType = int(systemLocalMT.nextFloat()*3);// proportion needs to change
    planetsNum = int(systemLocalMT.nextFloat()*10);// proportion needs to change
    /*Stars = new Star(numStars);
    Planets = new (numStars);
    for (int i = 0; i< systemType;i++){
      
    }
    for (int i = 0; i< planetsNum;i++){
      
    }*/
    return 0;
  }
  System(int seed,PVector size){
    seed = seed;
    int test = gen(size,seed);
  }
}


/*
System
  Stars  
    Planets
  Planets
    Moons
    
*/
