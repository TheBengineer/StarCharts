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
            tempstar[0] = luminocity;
            tempstar[1] = temperature;
            tempstar[2] = radius;
            starlist = (float[][])append(starlist,tempstar);
            star += 1;
          }
        }
        println("%"+str(((i+.001)/84.0)*100).substring(0,4)+" "+str(star));
      }
    }
  }
  return starlist;
}
