class Floor
{
  int map[][] = {{0, 1, 0}, 
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
          //r.add(new Room(new PVector(-i*roomSize.x, 0, j*roomSize.z), j, i));
          r.add(new Room(j, i));
        }
      }
    }
  }

  void update()
  {
    for (int i = 0; i < r.size(); i++)
    {
      if (r.get(i).playerInside()) r.get(i).display();
      //r.get(i).display();

      if (r.get(i).indexUp == pru && r.get(i).indexSide == prs)
      {
        if (pru > 0)
        {
          if (map[pru-1][prs] == 1)
          {
            r.get(i).d[0].isActive = true;
          }
        }
        
        if (pru < map.length - 1)
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
        
        if (prs < map[0].length - 1)
        {
          if (map[pru][prs+1] == 1)
          {
            r.get(i).d[3].isActive = true;
          }
        }
      }
    }
  }
}