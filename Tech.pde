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
  }
  PrintWriter cellFile = createWriter("Cells.csv");
  PrintWriter positionsFile = createWriter("Positions.csv");
  float px, py,luminocity,temperature,radius = 0;
  float[][] starlist = new float[starsMin+10][3];
  int star = 0;
  cellFile.println("CellSize:"+str(cellSize)+",");
  cellFile.println("X,Y,Stars,Label,Col,");
  positionsFile.println("Luminocity,Temperature,Label,");
  fill(255,0);
  stroke(255,127);
  while (star < starsMin){
    for (int i = 0;i<=cells.length-1;i++){// Loop through Rows
      for (int j = 0;j<=cells[0].length-1;j++){//Loop through Columns
        cellFile.println(str(i)+","+str(j)+","+str(cells[i][j].stars)+","+cells[i][j].label+","+str(cells[i][j].col)+",");
        if (cells[i][j].stars>=1){
          drift = (6/(cells[i][j].stars))*cellSize;
          ellipse(i*cellSize+(cellSize/2),j*cellSize+(cellSize/2),cellSize+drift,cellSize+drift);
          for (int k = 0; k<cells[i][j].stars;k++){//Loop through Stars
            px = (i*cellSize)+(cells.length*cellSize)+(MT.nextFloat()*(cellSize+drift))-(drift/2);
            py = (j*cellSize)+(MT.nextFloat()*(cellSize+drift))-(drift/2);
            luminocity = pow(10,(375-py)/63);
            temperature = pow(((px%(cells.length*cellSize))),-.53869)*95750;
            radius = pow(10,(px - ((py/253.0)*435) - 163)/128);
            positionsFile.println(str(luminocity)+","+str(temperature)+","+cells[i][j].label+",");
            starlist[star][0] = px;
            starlist[star][1] = py;
            starlist[star][2] = radius;
            star += 1;
          }
        }
        println(star);
      }
    }
  }
  return starlist;
}
