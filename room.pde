class Room
{
  PVector pos;

  PShape[] fw = new PShape[3]; // floors and walls

  int indexUp, indexSide;

  Door[] d = new Door[4];

  ArrayList<RedFly> rf = new ArrayList<RedFly>();

  Room(PVector _pos, int _indexUp, int _indexSide)
  {
    pos = _pos;
    indexUp = _indexUp;
    indexSide = _indexSide;

    fw[0] = createShape(BOX, roomSize.x, 2, roomSize.z);
    fw[1] = createShape(BOX, roomSize.x, roomSize.y, 2);
    fw[2] = createShape(BOX, 2, roomSize.y, roomSize.z);

    d[0] = new Door(new PVector(0, roomSize.y/4, roomSize.z/2), 0);
    d[1] = new Door(new PVector(0, roomSize.y/4, -roomSize.z/2), 1);
    d[2] = new Door(new PVector(-roomSize.x/2, roomSize.y/4, 0), 2);
    d[3] = new Door(new PVector(roomSize.x/2, roomSize.y/4, 0), 3);

    for (int i = 0; i < fw.length; i++)
    {
      fw[i].setTexture(roomTexture[0]);
    }

    for (int i = 0; i < (int) random(5, 10); i++)
    {
      rf.add(new RedFly(new PVector(random(-roomSize.x/2, roomSize.x/2), random(-roomSize.y/2, roomSize.y/2), random(-roomSize.z/2, roomSize.z/2)), 2, new PVector(20, 20, 20), 0, 2, 1));
    }
  }

  void display()
  { 
    noFill();
    stroke(255);

    pushMatrix();

    translate(pos.x, pos.y, pos.z);
    box(roomSize.x, roomSize.y, roomSize.z);

    popMatrix();

    pushMatrix();

    translate(pos.x, pos.y + roomSize.y/2, pos.z);
    shape(fw[0]);

    popMatrix();

    pushMatrix();

    translate(pos.x, pos.y - roomSize.y/2, pos.z);
    shape(fw[0]);

    popMatrix();

    pushMatrix();

    translate(pos.x, pos.y, pos.z - roomSize.z/2);
    shape(fw[1]);

    popMatrix();

    pushMatrix();

    translate(pos.x, pos.y, pos.z + roomSize.z/2);
    shape(fw[1]);

    popMatrix();

    pushMatrix();

    translate(pos.x - roomSize.x/2, pos.y, pos.z);
    shape(fw[2]);

    popMatrix();

    pushMatrix();

    translate(pos.x + roomSize.x/2, pos.y, pos.z);
    shape(fw[2]);

    popMatrix();

    for (int i = 0; i < d.length; i++)
    {
      if (rf.size() <= 0)
      {
        d[i].open = true;
      }

      if (d[i].isActive)
      {
        d[i].display();
      }
      
      if (d[i].isActive && d[i].open)
      {
        d[i].update();
      }
    }

    text(indexSide + ", " + indexUp, pos.x, pos.y, pos.z);

    for (int i = 0; i < rf.size(); i++)
    { 
      rf.get(i).move(player.getPos());
      rf.get(i).update();

      if (rf.get(i).killed) rf.remove(i);

      if (rf.size() != 0 && i != rf.size()) player.hit(rf.get(i));
    }
  }

  boolean playerInside()
  {
    if (pru == indexUp && prs == indexSide)
    {
      return true;
    }
    return false;
  }
}