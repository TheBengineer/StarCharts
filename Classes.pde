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

class Star{
  int seed = 0;
  Float luminocity = 0.0;
  Float temperature = 0.0;
  color col;
  Body[] bodies;
  Star(){
    
  }
}

class Sector{
   int seed;
   float density;
   PVector size;
   float volume;
   int numStars;
   float[][] starDataList;
   System[] systems;
   System[] gen(int seed,int numStars,PVector size){
     //starDataList = genStars(7,numStars,seed);
     System[] systems = new System[numStars];
     MersenneTwisterFast sectorLocalMT = new MersenneTwisterFast();
     sectorLocalMT.setSeed(seed);
     println(numStars);
     println(systems.length);
     for (int i = 0;i< numStars;i++){
       println(i);
       int tmpseed = int(sectorLocalMT.nextFloat()*1000000);
       println("asdf");
       systems[i] = new System(tmpseed,size);
       println("asdf");
     }
     return systems;
   }
   Sector(int seed,float density, PVector size){
     density = density;
     size = size;
     volume = size.x*size.y*size.z;
     numStars = int(volume*density); //todo adjust this for multiple stars in system
     systems = gen(seed,numStars,size);
   }
}


class Body{
  int seed = 0;
  int type = 0;
  float size = 0.0;
  float orbitRadius = 0.0;// In Au
  int moonsNum = 0;
  Body[] moons;
  Body(){
    
  }
}


class System{
  int seed;
  PVector position;
  int systemType; // How many stars are in the system.
  int planetsNum;
  Star[] Stars;
  Body[] Planets;
  int gen(PVector size){
    MersenneTwisterFast systemLocalMT = new MersenneTwisterFast();
    systemLocalMT.setSeed(seed);// the order of what happens next is important.
    position.x = systemLocalMT.nextFloat()*size.x;
    position.y = systemLocalMT.nextFloat()*size.y;
    position.z = systemLocalMT.nextFloat()*size.z;
    systemType = int(systemLocalMT.nextFloat()*3);// proportion needs to change
    /*for (int i = 0; i< systemType;i++){
      
    }
    */
    return 0;
  }
  System(int seed,PVector size){
    seed = seed;
    gen(size);
  }
}


/*
System
  Stars  
    Planets
  Planets
    Moons
    
*/
