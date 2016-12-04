class Room
{ 
  PShape[] fw = new PShape[3]; // floors and walls

  int indexUp, indexSide;

  Door[] d = new Door[4];

  ArrayList<RedFly> rf = new ArrayList<RedFly>();
  ArrayList<Pooter> p = new ArrayList<Pooter>();
  
  int enemyCount;

  Room(int _indexUp, int _indexSide)
  {
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

    int numberOfEnemies = (int) random(5, 15);
    
    enemyCount = numberOfEnemies;
    
    int nrf = (int) random(5, 10); // number of red flies
    int np = numberOfEnemies - nrf;
    
    for (int i = 0; i < nrf; i++)
    {
      rf.add(new RedFly(new PVector(random(-roomSize.x/2, roomSize.x/2), random(-roomSize.y/2, roomSize.y/2), random(-roomSize.z/2, roomSize.z/2)), 2, new PVector(20, 20, 20), 0, 2, 1));
    }
    
    for (int i = 0; i < np; i++)
    {
      p.add(new Pooter(new PVector(random(-roomSize.x/2, roomSize.x/2), random(-roomSize.y/2, roomSize.y/2), random(-roomSize.z/2, roomSize.z/2)), 2, new PVector(20, 20, 20), 3, 2, 1, 2000));
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

    for (int i = 0; i < rf.size(); i++)
    { 
      rf.get(i).move(player.getPos());
      rf.get(i).update();

      if (rf.get(i).killed) rf.remove(i);

      if (rf.size() != 0 && i != rf.size()) player.hit(rf.get(i));
    }
    
    for (int i = 0; i < p.size(); i++)
    { 
      if(dist(player.pos.x, player.pos.y, player.pos.z, p.get(i).pos.x, p.get(i).pos.y, p.get(i).pos.z) < 500) p.get(i).shoot(player.getPos());
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