class Rock
{
  PVector pos;

  PShape rock;

  Rock(PVector _pos)
  {
    pos = _pos;
    
    rock = loadShape("rock.obj");
    rock.scale(30);
  }

  void display()
  {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    rotateY(radians(3*PI));
    shape(rock);
    noFill();
    box(90);
    popMatrix();
  }
}