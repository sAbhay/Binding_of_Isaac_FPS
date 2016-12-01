class Enemy // base enemy class
{
  PVector pos;
  PVector dir;
  PVector start;
  PVector target;

  float speed;

  PVector size;

  PShape enemy;
  boolean killed = false;
  
  float health;
  float damage;

  Enemy(PVector _pos, float _speed, PVector _size, int _textureNo, float _health, float _damage)
  {
    start = _pos;
    pos = _pos;
    
    dir = new PVector();
    
    speed = _speed;

    size = _size;

    enemy = createShape(BOX, size.x, size.y, size.z);
    enemy.setTexture(texture[_textureNo]);
    
    health = _health;
    damage = _damage;
  }

  void display()
  {
    pushMatrix();

    translate(pos.x, pos.y, pos.z);
    shape(enemy);

    popMatrix();
  }

  void checkIfShot()
  {
    for (int i = 0; i < player.b.size(); i++)
    {
      if (player.b.get(i).pos.z >= pos.z - size.z/2 && player.b.get(i).pos.z <= pos.z + size.z/2 && player.b.get(i).pos.x >= pos.x - size.x/2 && player.b.get(i).pos.x <= pos.x + size.x/2 && player.b.get(i).pos.y >= pos.y - size.y/2 && player.b.get(i).pos.y <= pos.y + size.y/2)
      {
        player.b.remove(i);
        health--;
      }
    }
    
    if(health <= 0)
    {
     killed = true; 
    }
  }

  void checkBoundaries()
  {
    if (pos.x < -roomSize.x/2 || pos.x > roomSize.x/2 || pos.z > roomSize.z/2 || pos.z < -roomSize.x/2 || pos.y < -roomSize.y/2 || pos.y > roomSize.z/2) // checks whether its position lies outside the space
    {
      dir.mult(-1);
    }
  }

  void update()
  {
    display();
    checkIfShot();
    checkBoundaries();
  }
}