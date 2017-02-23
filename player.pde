class Player
{
  private PVector pos;

  public PVector size;
  private float damage;
  private float speed;
  private float shotSpeed;
  private float tears;
  private float range;
  private float tearSize;

  private PVector target;

  public ArrayList<Bullet> b = new ArrayList<Bullet>();

  public float health;

  private float maxHealth;

  private boolean hit;
  private int frame = 0;

  Player(PVector _size, float _damage, float _speed, float _shotSpeed, float _tears, float _range, float _tearSize, float _health)
  {
    size = _size;
    damage = _damage;
    speed = _speed;
    shotSpeed = _shotSpeed;
    tears = _tears;
    range = _range;
    tearSize = _tearSize;

    health = _health;
    maxHealth = 6;

    pos = new PVector(0, size.y/2, 0);
  }

  void shoot()
  {
    b.add(new Bullet(cam.position, target, 10 * shotSpeed, range, tearSize, 0));
  }

  void update()
  {
    checkBoundaries();
    checkHealth();

    target = PVector.add(cam.position, cam.getForward());

    for (int i = 0; i < b.size(); i++)
    {
      b.get(i).update();

      if (b.get(i).outOfRange() || b.get(i).outOfBounds())
      {
        b.remove(i);
      }
    }
  }

  void hit(Enemy enemy)
  {
    if (pos.x >= enemy.pos.x - enemy.size.x/2 && pos.x <= enemy.pos.x + enemy.size.x/2 && pos.y >= enemy.pos.y - enemy.size.y/2 && pos.y <= enemy.pos.y + enemy.size.y/2 && pos.z >= enemy.pos.z - enemy.size.z/2 && pos.z <= enemy.pos.z + enemy.size.z/2)
    {
      if (!hit) health -= enemy.damage;

      hit = true;
    }

    if (hit)
    {
      frame++;

      if (frame < frameRate/2)
      {
        cam.beginHUD();

        fill(255, 0, 0, 100);
        rect(width/2, height/2, width, height);

        cam.endHUD();
      }

      if (frame < frameRate*2)
      {
        cam.beginHUD();

        fill(255, 50);
        rect(width/2, height/2, width, height);

        cam.endHUD();
      }

      if (frame >= frameRate*2)
      {
        hit = false;
        frame = 0;
      }
    }
  }

  void checkBoundaries()
  {
    //keeping the player inside the room
    if (cam.position.x <= -roomSize.x/2 + 10) cam.position.x = -roomSize.x/2 + 10;
    if (cam.position.x >= roomSize.x/2 - 10) cam.position.x = roomSize.x/2 - 10;
    if (cam.position.y <= -roomSize.y/2 + 10) cam.position.y = -roomSize.x/2 + 10;
    if (cam.position.y >= roomSize.y/2 - 10) cam.position.y = roomSize.x/2 - 10;
    if (cam.position.z <= -roomSize.z/2 + 10) cam.position.z = -roomSize.x/2 + 10;
    if (cam.position.z >= roomSize.z/2 - 10) cam.position.z = roomSize.x/2 - 10;
  }

  void checkIfShot(Enemy enemy)
  {
    for (int i = 0; i < enemy.b.size(); i++)
    {
      if (enemy.b.get(i).pos.z >= pos.z - size.z/2 && enemy.b.get(i).pos.z <= pos.z + size.z/2 && enemy.b.get(i).pos.x >= pos.x - size.x/2 && enemy.b.get(i).pos.x <= pos.x + size.x/2 && enemy.b.get(i).pos.y >= pos.y - size.y/2 && enemy.b.get(i).pos.y <= pos.y + size.y/2)
      {
        enemy.b.remove(i);
        if (!hit) health -= enemy.damage;

        hit = true;
      }
    }

    if (hit)
    {
      frame++;

      if (frame < frameRate/2)
      {
        cam.beginHUD();

        fill(255, 0, 0, 50);
        rect(width/2, height/2, width, height);

        cam.endHUD();
      }

      if (frame < frameRate*2)
      {
        cam.beginHUD();

        fill(255, 50);
        rect(width/2, height/2, width, height);

        cam.endHUD();
      }

      if (frame >= frameRate*2)
      {
        hit = false;
        frame = 0;
      }
    }
  }

  void checkHealth()
  {
    if (health > maxHealth)
    {
      health = maxHealth;
    }
  }

  void checkRocks(Rock rock)
  {
    /*if((pos.x + size.x/2 >= rock.pos.x - rock.size/2 || pos.x - size.x/2 >= rock.pos.x - rock.size/2) && (pos.x + size.x/2 <= rock.pos.x + rock.size/2 || pos.x - size.x/2 <= rock.pos.x + rock.size/2) && pos.y + size.y/2 >= rock.pos.y - rock.size/2 && pos.y + size.y/2 <= rock.pos.y + rock.size/2 && (pos.z + size.z/2 >= rock.pos.z - rock.size/2 || pos.z - size.z >= rock.pos.z - rock.size/2) && (pos.z + size.z/2 <= rock.pos.z + rock.size/2 || pos.z + size.z <= rock.pos.z + rock.size/2))
     {
     // do something
     }*/

    if (pos.y + size.y/2 >= rock.pos.y - rock.size/2 && pos.y <= rock.pos.y + rock.size/2)
    {
      //if(dist(pos.x + pos.))
    }
  }

  PVector getPos()
  {
    return pos;
  }

  PVector getTarget()
  {
    return target;
  }

  float getTears()
  {
    return tears;
  }

  void setTears(float _tears)
  {
    tears = _tears;
  }

  float getMaxHealth()
  {
    return maxHealth;
  }

  float getHealth()
  {
    return health;
  }

  void setMaxHealth(float _maxHealth)
  {
    maxHealth = _maxHealth;
  }

  float getDamage()
  {
    return damage;
  }

  void setDamage(float _damage)
  {
    damage = _damage;
  }

  float getTearSize()
  {
    return tearSize;
  }

  void setTearSize(float _tearSize)
  {
    tearSize = _tearSize;
  }

  float getShotSpeed()
  {
    return shotSpeed;
  }

  void setShotSpeed(float _shotSpeed)
  {
    shotSpeed = _shotSpeed;
  }

  float getSpeed()
  {
    return speed;
  }
  
  float getRange()
  {
    return range;
  }

  void setSpeed(float _speed)
  {
    speed = _speed;
    cam.speed = 2 * speed;
  }
}