void drawBox(){
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
}