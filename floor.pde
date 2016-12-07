class Floor
{
  int map[][] = {{0, 2, 0, 0, 1}, 
    {1, 3, 1, 1, 1}, 
    {0, 1, 0, 0, 1}, 
    {1, 1, 0, 1, 1}, 
    {0, 1, 1, 1, 0}};

  ArrayList<Room> r = new ArrayList<Room>();

  void create()
  {
    for (int i = 0; i < map.length; i++)
    {
      for (int j = 0; j < map[i].length; j++)
      {
        if (map[i][j] != 0)
        {
          r.add(new Room(i, j, map[i][j]));
        }
      }
    }
  }

  void update()
  {
    floorMap();

    for (int i = 0; i < r.size(); i++)
    {
      if (r.get(i).playerInside()) r.get(i).display();

      if (r.get(i).indexUp == prs && r.get(i).indexSide == pru)
      {
        if (prs > 0)
        {
          if (map[prs-1][pru] != 0)
          {
            r.get(i).d[0].isActive = true;
          }
        }

        if (prs < map.length - 1)
        {
          if (map[prs+1][pru] != 0)
          {
            r.get(i).d[1].isActive = true;
          }
        }

        if (pru > 0)
        {
          if (map[prs][pru-1] != 0)
          {
            r.get(i).d[2].isActive = true;
          }
        }

        if (pru < map[0].length - 1)
        {
          if (map[prs][pru+1] != 0)
          {
            r.get(i).d[3].isActive = true;
          }
        }
      }
    }
  }

  void floorMap()
  {
    for (int i = 0; i < map.length; i++)
    {
      for (int j = 0; j < map[i].length; j++)
      {
        if (map[i][j] != 0)
        {
          PVector mapPos = new PVector();
          mapPos = PVector.add(cam.position, cam.getForward());

          pushMatrix();

          translate(mapPos.x, mapPos.y, mapPos.z);

          rotateZ(radians(cam.tilt));

          pushMatrix();

          translate(i*0.05 + 0.5, j*0.05 - 0.4, 0);

          fill(100, 128);

          for (Room room : r)
          {
            if (room.indexSide == i && room.indexUp == j && room.cleared)
            {
              fill(200, 128);
            }
          }
          
          if (prs == j && pru == i)
          {
            fill(255, 200);
          }

          box(0.05);

          popMatrix();

          popMatrix();
        }
      }
    }
  }
}