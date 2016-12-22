class Room
{ 
  private PShape[] fw = new PShape[3]; // floors and walls

  private int indexUp;
  private int indexSide;

  private Door[] d = new Door[4];

  private ArrayList<RedFly> rf = new ArrayList<RedFly>();
  private ArrayList<Pooter> p = new ArrayList<Pooter>();

  private int enemyCount;

  private ArrayList<Heart> h = new ArrayList<Heart>();

  private int type;
  private int drop;

  private ArrayList<Rock> r = new ArrayList<Rock>();
  private ArrayList<Item> items = new ArrayList<Item>();

  private boolean cleared;

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

      drop = (int) random(40);
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

      cleared = false;
      break;

    case 2:
      enemyCount = 0;
      cleared = true;

      items.add(new Item(new PVector(0, roomSize.y/12, 0), (int) random(numItems)));
      break;

    case 3:
      enemyCount = 0;
      cleared = true;
      break;
    }

    float ratio = random(0.33, 0.66);
    int nrf = (int) (ratio * enemyCount); // number of red flies
    int np = (int) ((1 - ratio) * enemyCount);

    for (int i = 0; i < nrf; i++)
    {
      rf.add(new RedFly(new PVector(random(-roomSize.x/2, roomSize.x/2), random(-roomSize.y/2, roomSize.y/2), random(-roomSize.z/2, roomSize.z/2)), 2, new PVector(20, 20, 20), 2, 1, "fly.obj"));
    }

    for (int i = 0; i < np; i++)
    {
      p.add(new Pooter(new PVector(random(-roomSize.x/2, roomSize.x/2), random(-roomSize.y/3, 0), random(-roomSize.z/2, roomSize.z/2)), 2, new PVector(30, 30, 30), 3, 1, 2000, "Pooter.obj"));
    }

    for (int i = 0; i < (int) random(10); i++)
    {
      int x = (int) random(-4, 4);
      int z = (int) random(-4, 4);

      if (x == 0 && z == 0)
      {
        x = (int) random(-4, 4);
        z = (int) random(-4, 4);
      }

      r.add(new Rock(new PVector(x * roomSize.x/10, roomSize.y/2 - 40, z * roomSize.z/10)));
    }
  }

  void display()
  {
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
        cleared = true;

        for (int j = 0; j < h.size(); j++)
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
      if (h.get(i).picked == false && h.get(i).isActive) h.get(i).update();

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

    for (int i = 0; i < r.size(); i++)
    {
      r.get(i).display();

      player.checkRocks(r.get(i));
    }

    for (int i = 0; i < items.size(); i++)
    { 
      items.get(i).display();

      if (items.get(i).pick()) 
      {
        items.get(i).changeStat();

        if (items.get(i).name == "Transcendence")
        {
          flying = true;
        }

        items.remove(i);
      }
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

  boolean hearts()
  {
    if(h.size() != 0)
    {
     return true; 
    }
    return false;
  }
  
  int getIndexSide()
  {
   return indexSide;
  }
  
  int getIndexUp()
  {
   return indexUp; 
  }
}