class RedFly extends Enemy
{
  RedFly(PVector _pos, float _speed, PVector _size, float _health, float _damage, String _model)
  {
    super(_pos, _speed, _size, _health, _damage, _model, 1.5);
  }

  void move(PVector _target)
  { 
    dir = PVector.sub(_target, pos);
    
    dir.normalize();
    dir.mult(speed);
    
    pos.add(dir);
  }
}