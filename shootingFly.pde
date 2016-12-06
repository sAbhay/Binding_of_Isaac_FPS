class Pooter extends Enemy
{
  int fireRate;
  int interval;
  
  Pooter(PVector _pos, float _speed, PVector _size, float _health, float _damage, int _fireRate, String _model)
  {
    super(_pos, _speed, _size, _health, _damage, _model);
    
    fireRate = _fireRate;
    
    interval = millis();
  }

  void shoot(PVector _target)
  { 
    if(interval < millis())
    {
      b.add(new Bullet(pos, _target, 7.5, 400, 10, 2));
      
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