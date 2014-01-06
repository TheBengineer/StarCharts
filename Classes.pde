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
  int gen(){
    MersenneTwisterFast MT = new MersenneTwisterFast();
    MT.setSeed(seed);// the order of what happens next is important.
    position.x = MT.nextFloat()*1000;
    position.y = MT.nextFloat()*1000;
    position.z = MT.nextFloat()*1000;
    systemType = int(MT.nextFloat()*3);// proportion needs to change
    for (int i = 0; i< systemType;i++){
      
    }
    return 0;
  }
  System(int seed){
    seed = seed;
    gen();
  }
}


/*
System
  Stars  
    Planets
  Planets
    Moons
    
*/
