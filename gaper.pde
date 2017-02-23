class Gaper extends Enemy
{
  private int fireRate;
  private int interval;
  
  private float y;
  
  Gaper(PVector _pos, float _speed, PVector _size, float _health, float _damage, int _fireRate)
  {
    super(_pos, _speed, _size, _health, _damage, "gaper.obj", new PVector(3, 3, 3));
    
    y = _pos.y;
    fireRate = _fireRate;
  }

  void move(PVector _target)
  { 
    dir = PVector.sub(_target, pos);
    
    dir.normalize();
    dir.mult(super.speed);
    
    pos.add(dir);
    
    pos.y = y;
  }
  
  void shoot(PVector _target)
  { 
    if(interval < millis())
    {
      b.add(new Bullet(pos, _target, 7.5, 500, 10, 1));
      
      interval = millis();
      interval += fireRate;
    }
    
    for(int i = 0; i < b.size(); i++)
    {
     b.get(i).update(); 
    }
    
    player.checkIfShot(this);
  }
}