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
    for (Room room : r)
    {
      //for (int i = 0; i < prss.size(); i++)
      //{
      //for (int j = 0; j < prus.size(); j++)
      //{
      //if ((room.getIndexSide() == prus.get(i) + 1 && room.getIndexUp() == prus.get(j)) || (room.getIndexSide() == prus.get(i) - 1 && room.getIndexUp() == prss.get(j)) || (room.getIndexSide() == prus.get(i) && room.getIndexUp() == prss.get(j) + 1) || (room.getIndexSide() == prus.get(i) && room.getIndexUp() == prss.get(j) - 1) || (room.getIndexSide() == prus.get(i) && room.getIndexUp() == prss.get(j)))
      //{
      fill(100, 128);

      if (room.cleared)
      {
        if (room.hearts())
        {
          fill(255, 0, 0);
          rect(room.getIndexSide() * 25 + width - map[0].length * 25 - 37.5, room.getIndexUp() * 25 + 37.5, 10, 10);
        }

        if (room.getType() == 2)
        {
          fill(255, 255, 0);
          rect(room.getIndexSide() * 25 + width - map[0].length * 25 - 37.5, room.getIndexUp() * 25 + 37.5, 10, 10);
        }

        fill(200, 128);
      }

      if (room.playerInside())
      {
        fill(255, 200);
      }

      rect(room.getIndexSide() * 25 + width - map[0].length * 25 - 37.5, room.getIndexUp() * 25 + 37.5, 25, 25);
    //}
    //}
    //}
    }
  }
}