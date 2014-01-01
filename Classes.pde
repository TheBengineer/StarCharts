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
  int systemType = 1; // How many stars are in the system.
  int planetsNum = 0;
  Star[] Stars;
  Body[] Planets;
  System(){
    
  }
}


/*
System
  Stars  
    Planets
  Planets
    Moons
    
*/
