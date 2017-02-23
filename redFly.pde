class RedFly extends Enemy
{
  RedFly(PVector _pos, float _speed, PVector _size, float _health, float _damage)
  {
    super(_pos, _speed, _size, _health, _damage, "fly.obj", new PVector(1.5, 1.5, 1.5));
  }

  void move(PVector _target)
  { 
    dir = PVector.sub(_target, pos);
    
    dir.normalize();
    dir.mult(super.speed);
    
    pos.add(dir);
  }
}