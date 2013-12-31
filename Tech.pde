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


float[][] genStars(float cellSize,int starsMin){ //Counts up how many stars are in the image, groups them, and prints the data to a file.
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
  float px, py,luminocity,temperature = 0;
  float[][] starlist = new float[starsMin+10][2];
  int star = 0;
  cellFile.println("CellSize:"+str(cellSize)+",");
  cellFile.println("X,Y,Stars,Label,Col,");
  positionsFile.println("Luminocity,Temperature,Label,");
  fill(255,0);
  stroke(255,127);
  for (int i = 0;i<=cells.length-1;i++){// Loop through Rows
    for (int j = 0;j<=cells[0].length-1;j++){//Loop through Columns
      cellFile.println(str(i)+","+str(j)+","+str(cells[i][j].stars)+","+cells[i][j].label+","+str(cells[i][j].col)+",");
      if (cells[i][j].stars>=1){
        drift = (6/(cells[i][j].stars))*cellSize;
        ellipse(i*cellSize+(cellSize/2),j*cellSize+(cellSize/2),cellSize+drift,cellSize+drift);
        for (int k = 0; k<cells[i][j].stars;k++){//Loop through Stars
          px = (i*cellSize)+(cells.length*cellSize)+random(cellSize+drift)-(drift/2);
          py = (j*cellSize)+random(cellSize+drift)-(drift/2);
          luminocity = pow(10,(375-py)/63);
          temperature = pow(((px%(cells.length*cellSize))),-.53869)*95750;
          positionsFile.println(str(luminocity)+","+str(temperature)+","+cells[i][j].label+",");
          starlist[star][0] = px;
          starlist[star][1] = py;
          star += 1;
        }
      }
    }
  }
  return starlist;
}
