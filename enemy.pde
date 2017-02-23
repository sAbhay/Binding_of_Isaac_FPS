class Enemy // base enemy class
{
  public PVector pos;
  public PVector dir;

  private float speed;

  public PVector size;

  private PShape enemy;
  public boolean killed = false;
  
  private float health;
  public float damage;
  
  private PVector forward;
  
  public ArrayList<Bullet> b = new ArrayList<Bullet>();

  Enemy(PVector _pos, float _speed, PVector _size, float _health, float _damage, String model, PVector _scale)
  {
    pos = _pos;
    //forward = 
    
    dir = new PVector();
    
    speed = _speed;

    size = _size;
    
    enemy = loadShape(model);
    enemy.scale(size.x/(_scale.x), size.y/(_scale.y), size.z/(_scale.z));
    
    health = _health;
    damage = _damage;
  }

  void display()
  {
    pushMatrix();

    translate(pos.x, pos.y, pos.z);
    rotateX(PI);
    shape(enemy);
    
    //noFill();
    //stroke(255);
    //box(size.x, size.y, size.z);

    popMatrix();
  }

  void checkIfShot()
  {
    for (int i = 0; i < player.b.size(); i++)
    {
      if (player.b.get(i).pos.z >= pos.z - size.z/2 && player.b.get(i).pos.z <= pos.z + size.z/2 && player.b.get(i).pos.x >= pos.x - size.x/2 && player.b.get(i).pos.x <= pos.x + size.x/2 && player.b.get(i).pos.y >= pos.y - size.y/2 && player.b.get(i).pos.y <= pos.y + size.y/2)
      {
        player.b.remove(i);
        health -= player.damage;
        
        dir.mult(50);
        pos.sub(dir);
        
        dir.normalize();
        dir.mult(speed);
        pos.add(dir);
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