class Floor
{
  int map[][] = {{1, 0, 0}, 
    {1, 1, 1}, 
    {0, 1, 0}};

  ArrayList<Room> r = new ArrayList<Room>();

  void create()
  {
    for (int i = 0; i < map.length; i++)
    {
      for (int j = 0; j < map[i].length; j++)
      {
        if (map[i][j] == 1)
        {
          r.add(new Room(new PVector(0, 0, 0), j, i));
        }
      }
    }
  }

  void update()
  {
    for (int i = 0; i < r.size(); i++)
    {
      if (r.get(i).playerInside()) r.get(i).display();

      if (r.get(i).indexUp == pru && r.get(i).indexSide == prs)
      {
        if (pru > 0)
        {
          if (map[pru-1][prs] == 1)
          {
            r.get(i).d[0].isActive = true;
          }
        }
        
        if (pru < 3)
        {
          if (map[pru+1][prs] == 1)
          {
            r.get(i).d[1].isActive = true;
          }
        }
        
        if (prs > 0)
        {
          if (map[pru][prs-1] == 1)
          {
            r.get(i).d[2].isActive = true;
          }
        }
        
        if (prs < 3)
        {
          if (map[pru][prs + 1] == 1)
          {
            r.get(i).d[3].isActive = true;
          }
        }
      }
    }
  }
}