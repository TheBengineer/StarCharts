


float[][] genStars(float cellSize,int starsMin,int seed){ //Counts up how many stars are in the image, groups them, and prints the data to a file.
  MersenneTwisterFast MT = new MersenneTwisterFast();
  MT.setSeed(seed);
  int cols = 84;
  int rows = 109;
  cell[][] cells;
  cells = (cell[][]) new cell[cols][rows];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      cells[i][j] = new cell("",0,color(255));
    }
  }
  Table Cells = new Table();
  float drift = 0;
  Cells = loadTable("data/Cells.csv","header");
  for (TableRow tr : Cells.rows()){
    cells[tr.getInt("X")][tr.getInt("Y")].label = tr.getString("Label");
    cells[tr.getInt("X")][tr.getInt("Y")].col = tr.getInt("Color");
    cells[tr.getInt("X")][tr.getInt("Y")].stars = tr.getInt("Stars");
  }
  float px, py,luminocity,temperature,radius = 0;
  float[][] starlist = new float[0][3];
  float[] tempstar = new float[3];
  int star = 0;
  while (star < starsMin){
    for (int i = 0;i<=cells.length-1;i++){// Loop through Rows
      for (int j = 0;j<=cells[0].length-1;j++){//Loop through Columns
        if (cells[i][j].stars>=1){
          drift = (6/(cells[i][j].stars))*cellSize;
          for (int k = 0; k<cells[i][j].stars;k++){//Loop through Stars
            px = (i*cellSize)+(cells.length*cellSize)+(MT.nextFloat()*(cellSize+drift))-(drift/2);
            py = (j*cellSize)+(MT.nextFloat()*(cellSize+drift))-(drift/2);
            luminocity = pow(10,(375-py)/63);
            temperature = pow(((px%(cells.length*cellSize))),-.53869)*95750;
            radius = pow(10,(px - ((py/253.0)*435) - 163)/128);
            starlist = (float[][])append(starlist,new float[3]);
            starlist[star][0] = luminocity;
            starlist[star][1] = temperature;
            starlist[star][2] = radius;
            star += 1;
          }
        }
      }
      println("%"+str(((i+.001)/84.0)*100).substring(0,4)+" "+str(star));
    }
  }
  return starlist;
}

PVector[] initPositions(int seed,float[][] starlist) {
  MT.setSeed(seed);//set the starting state of the Mersenne Twister algorithm
  PVector[] newPositions = new PVector[npartTotal];
  float x = 0;
  float y = 0;
  float z = 0;
  for (int n = 0; n < newPositions.length; n++) {
    x = (MT.nextFloat()*2000)-1000;
    y = (MT.nextFloat()*2000)-1000;
    z = (MT.nextFloat()*2000)-1000;
    newPositions[n] = new PVector(x,y,z);
  }
  return newPositions;
}

color Ktemp(int temp){
  color col ;
  float Red = 0;
  float Green = 0;
  float Blue = 0;
  temp = temp / 85;
  //Red
  if (temp <= 66){
    Red = 255;
  }
  else{
    Red = temp -60;
    Red = 329.698727446 * pow(Red,  -0.1332047592);
    if (Red < 0)    { Red = 0;}
    if (Red > 255)  { Red = 255;}
  }
  
  //Green
  if (temp <= 66){
    Green = temp;
    Green = 99.4708025861 * log(Green) - 161.1195681661;
    if (Green < 0)    { Green = 0;}
    if (Green > 255)  { Green = 255;}
  }
  else{
    Green = temp -60;
    Green = 288.1221695283 * pow(Green , -0.0755148492);
    if (Green < 0)    { Green = 0;}
    if (Green > 255)  { Green = 255;}
  }
  
  //Blue
  if (temp >= 66){
    Blue = 255;
  }
  else{
    if (temp <= 19){
      Blue = 0;
    }
    else{
      Blue = temp -10;
      Blue = 138.5177312231 * log(Blue) - 305.0447927307;
      if (Green < 0)    { Green = 0;}
      if (Green > 255)  { Green = 255;}
    }
  }
  col = color(Red,Green,Blue);
  return col;
}
