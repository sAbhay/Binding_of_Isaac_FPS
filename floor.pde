class Floor
{
  private int map[][] = 
    {{0, 3, 0, 0, 1}, 
    {1, 2, 1, 1, 1}, 
    {0, 1, 0, 0, 1}, 
    {1, 1, 1, 1, 1}, 
    {1, 0, 0, 1, 0},
    {1, 2, 1, 1, 1},
    {0, 1, 0, 1, 0}};

  private ArrayList<Room> r = new ArrayList<Room>();

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
    PVector mapPos = new PVector();
    mapPos = PVector.add(cam.position, cam.getForward());

    pushMatrix();

    translate(mapPos.x, mapPos.y, mapPos.z);

    rotateZ(radians(cam.tilt));

    for (Room room : r)
    {
      pushMatrix();

      translate(room.getIndexSide() * 0.05 + 0.4, room.getIndexUp() * 0.05 - 0.4, 0);

      fill(100, 128);

      if (room.cleared)
      {
        if (room.hearts())
        {
          fill(255, 0, 0);
          box(0.025);
        }

        if (room.type == 2)
        {
          fill(255, 255, 0);
          box(0.03);
        }

        fill(200, 128);
      }

      if (room.playerInside())
      {
        fill(255, 200);
      }

      box(0.05);

      popMatrix();
    }

    popMatrix();
  }
}