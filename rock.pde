class Rock
{
  PVector pos;
  int size;

  PShape rock;

  Rock(PVector _pos)
  {
    pos = _pos;
    size = (int) (roomSize.x/10 + roomSize.z/10)/2;
    
    rock = loadShape("rock.obj");
    rock.scale(size/3);
  }

  void display()
  {
    pushMatrix();
    translate(pos.x, pos.y + 15, pos.z);
    shape(rock);
    popMatrix();
  }
}