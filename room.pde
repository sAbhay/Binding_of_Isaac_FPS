class Room
{ 
  PShape[] fw = new PShape[3]; // floors and walls

  int indexUp, indexSide;

  Door[] d = new Door[4];

  ArrayList<RedFly> rf = new ArrayList<RedFly>();
  ArrayList<Pooter> p = new ArrayList<Pooter>();

  int enemyCount;

  ArrayList<Heart> h = new ArrayList<Heart>();

  int type;
  int drop;

  Room(int _indexUp, int _indexSide, int _type)
  {
    indexUp = _indexUp;
    indexSide = _indexSide;

    type = _type;

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

    switch(type)
    {
    case 1:
      enemyCount = (int) random(5, 10);

      drop = (int) random(20);
      if (drop < 6) 
      {
        h.add(new Heart(0));
      } else if (drop > 6 && drop <= 9) 
      {
        h.add(new Heart(1));
      } else if (drop == 10) 
      {
        h.add(new Heart(2));
      }
      break;

    case 2:
      enemyCount = 0;
      break;
    }

    float ratio = random(0.33, 0.66);
    int nrf = (int) (ratio * enemyCount); // number of red flies
    int np = (int) ((1 - ratio) * enemyCount);

    for (int i = 0; i < nrf; i++)
    {
      rf.add(new RedFly(new PVector(random(-roomSize.x/2, roomSize.x/2), random(-roomSize.y/2, roomSize.y/2), random(-roomSize.z/2, roomSize.z/2)), 2, new PVector(30, 30, 30), 0, 2, 1));
    }

    for (int i = 0; i < np; i++)
    {
      p.add(new Pooter(new PVector(random(-roomSize.x/2, roomSize.x/2), random(-roomSize.y/2, 0), random(-roomSize.z/2, roomSize.z/2)), 2, new PVector(40, 40, 40), 3, 2, 1, 2000));
    }
  }

  void display()
  { 
    noFill();
    stroke(255);

    box(roomSize.x, roomSize.y, roomSize.z);

    pushMatrix();

    translate(0, roomSize.y/2, 0);
    shape(fw[0]);

    popMatrix();

    pushMatrix();

    translate(0, -roomSize.y/2, 0);
    shape(fw[0]);

    popMatrix();

    pushMatrix();

    translate(0, 0, -roomSize.z/2);
    shape(fw[1]);

    popMatrix();

    pushMatrix();

    translate(0, 0, roomSize.z/2);
    shape(fw[1]);

    popMatrix();

    pushMatrix();

    translate(-roomSize.x/2, 0, 0);
    shape(fw[2]);

    popMatrix();

    pushMatrix();

    translate(roomSize.x/2, 0, 0);
    shape(fw[2]);

    popMatrix();

    enemyCount = rf.size() + p.size();

      for (int i = 0; i < d.length; i++)
      {
        if (enemyCount <= 0)
        {
          d[i].open = true;
          
          for(int j = 0; j < h.size(); j++)
          {
            h.get(j).isActive = true; 
          }
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

    for (int i = 0; i < h.size(); i++)
    {
      if(h.get(i).picked == false && h.get(i).isActive) h.get(i).update();

      if (h.get(i).picked()) h.remove(i);
    }

    for (int i = 0; i < rf.size(); i++)
    { 
      rf.get(i).move(player.getPos());
      rf.get(i).update();

      if (rf.get(i).killed) rf.remove(i);

      if (rf.size() != 0 && i != rf.size()) player.hit(rf.get(i));
    }

    for (int i = 0; i < p.size(); i++)
    { 
      if (dist(player.pos.x, player.pos.y, player.pos.z, p.get(i).pos.x, p.get(i).pos.y, p.get(i).pos.z) < 500) p.get(i).shoot(player.getPos());
      p.get(i).update();

      if (p.get(i).killed) p.remove(i);
    }
  }

  boolean playerInside()
  {
    if (prs == indexUp && pru == indexSide)
    {
      return true;
    }
    return false;
  }
}