class Room
{
  void display()
  {
    noFill();
    stroke(255);
    
    pushMatrix();
    
    translate(0, -250, 0);
    box(1000, 500, 1000);
    
    popMatrix();
  }
}