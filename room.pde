class Room
{
  void display()
  {
    noFill();
    stroke(255);
    
    box(roomSize.x, roomSize.y, roomSize.z);
  }
}