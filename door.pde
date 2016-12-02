class Door
{
  PVector pos;
  int type;
  boolean open;
  boolean isActive;

  Door(PVector _pos, int _type)
  {
    pos = _pos;
    type = _type;
  }

  void display()
  {
    switch(type)
    {
    case 0:

      pushMatrix();
      translate(pos.x, pos.y, pos.z);
      box(roomSize.x/5, roomSize.y/2, 20);
      popMatrix();

      break;

    case 1:

      pushMatrix();
      translate(pos.x, pos.y, pos.z);
      box(roomSize.x/5, roomSize.y/2, 20);
      popMatrix();

      break;

    case 2:

      pushMatrix();
      translate(pos.x, pos.y, pos.z);
      box(20, roomSize.y/2, roomSize.z/5);
      popMatrix();

      break;

    case 3:

      pushMatrix();
      translate(pos.x, pos.y, pos.z);
      box(20, roomSize.y/2, roomSize.z/5);
      popMatrix();
      
      break;
    }
  }

  void update()
  {
    switch(type)
    {
    case 0:

      if (player.pos.x >= pos.x - roomSize.x/5 && player.pos.x <= pos.x + roomSize.x/5 && player.pos.y >= pos.y - roomSize.y/5 && player.pos.y <= pos.y + roomSize.y/5 && player.pos.z >= pos.z - 10 && player.pos.z <= pos.z + 10)
      {
        pru--;

        player.pos.z = -roomSize.z/2 + player.size.z;
      }

      break;

    case 1:

      if (player.pos.x >= pos.x - roomSize.x/5 && player.pos.x <= pos.x + roomSize.x/5 && player.pos.y >= pos.y - roomSize.y/5 && player.pos.y <= pos.y + roomSize.y/5 && player.pos.z >= pos.z - 10 && player.pos.z <= pos.z + 10)
      {
        pru++;

        player.pos.z = roomSize.z/2 + player.size.z;
      }

      break;

    case 2:

      if (player.pos.z >= pos.z - roomSize.z/5 && player.pos.z <= pos.z + roomSize.z/5 && player.pos.y >= pos.y - roomSize.y/5 && player.pos.y <= pos.y + roomSize.y/5 && player.pos.x >= pos.x - 10 && player.pos.x <= pos.x + 10)
      {
        prs--;

        player.pos.x = 0;
        player.pos.x = roomSize.x/2 - player.size.x;
      }

      break;

    case 3:

      if (player.pos.z >= pos.z - roomSize.z/5 && player.pos.z <= pos.z + roomSize.z/5 && player.pos.y >= pos.y - roomSize.y/5 && player.pos.y <= pos.y + roomSize.y/5 && player.pos.x >= pos.x - 10 && player.pos.x <= pos.x + 10)
      {
        prs++;

        player.pos.x = -roomSize.x/2 + player.size.x;
      }

      break;
    }
  }
}