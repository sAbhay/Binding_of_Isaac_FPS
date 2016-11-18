class Player
{
  PVector pos;
  
  Player()
  {
    pos = new PVector(0, 0, 0);
  }
  
  void right()
  {
      pos.x += 2;
  }

  void left()
  {
      pos.x -= 2;
  }

  void forward()
  {
      pos.z -= 2;
  }

  void back()
  {
      pos.z += 2;
  }
}