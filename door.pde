class Door
{
  PVector pos;
  int type;
  boolean open;
  boolean isActive;

  PShape door[] = new PShape[4];

  Door(PVector _pos, int _type)
  {
    pos = _pos;
    type = _type;

    door[0] = createShape(BOX, roomSize.x/5, 9*roomSize.y/10, 20);
    door[1] = createShape(BOX, roomSize.x/5, 9*roomSize.y/10, 20);

    door[2] = createShape(BOX, 20, 9*roomSize.y/10, roomSize.z/5);
    door[3] = createShape(BOX, 20, 9*roomSize.y/10, roomSize.z/5);

    door[0].setTexture(doorTexture[0]);
    door[1].setTexture(doorTexture[1]);

    door[2].setTexture(doorTexture[0]);
    door[3].setTexture(doorTexture[1]);
  }

  void display()
  {
    switch(type)
    {
    case 0:

      pushMatrix();
      translate(pos.x, pos.y, pos.z);

      if (open) 
      {
        shape(door[1]);
      } else 
      {
        shape(door[0]);
      }

      popMatrix();

      break;

    case 1:

      pushMatrix();
      translate(pos.x, pos.y, pos.z);

      if (open) 
      {
        shape(door[1]);
      } else 
      {
        shape(door[0]);
      }

      popMatrix();

      break;

    case 2:

      pushMatrix();
      translate(pos.x, pos.y, pos.z);

      if (open)
      {
        shape(door[3]);
      } else
      {
        shape(door[2]);
      }

      popMatrix();

      break;

    case 3:

      pushMatrix();
      translate(pos.x, pos.y, pos.z);
      
      if (open)
      {
        shape(door[3]);
      } else
      {
        shape(door[2]);
      }
      
      popMatrix();

      break;
    }
  }

  void update()
  {
    switch(type)
    {
    case 0:

      if (player.pos.x >= pos.x - roomSize.x/5 && player.pos.x <= pos.x + roomSize.x/5 && player.pos.z >= pos.z - 10 && player.pos.z <= pos.z + 10)
      {
        prs--;

        player.pos.z = -roomSize.z/2 + player.size.z;
      }

      break;

    case 1:

      if (player.pos.x >= pos.x - roomSize.x/5 && player.pos.x <= pos.x + roomSize.x/5 && player.pos.z >= pos.z - 10 && player.pos.z <= pos.z + 10)
      {
        prs++;

        player.pos.z = roomSize.z/2 + player.size.z;
      }

      break;

    case 2:

      if (player.pos.z >= pos.z - roomSize.z/5 && player.pos.z <= pos.z + roomSize.z/5 && player.pos.x >= pos.x - 10 && player.pos.x <= pos.x + 10)
      {
        pru--;

        player.pos.x = 0;
        player.pos.x = roomSize.x/2 - player.size.x;
      }

      break;

    case 3:

      if (player.pos.z >= pos.z - roomSize.z/5 && player.pos.z <= pos.z + roomSize.z/5 && player.pos.x >= pos.x - 10 && player.pos.x <= pos.x + 10)
      {
        pru++;

        player.pos.x = -roomSize.x/2 + player.size.x;
      }

      break;
    }
  }
}