class RedFly extends Enemy
{
  RedFly(PVector _pos, float _speed, PVector _size, int _textureNo, float _health, float _damage)
  {
    super(_pos, _speed, _size, _textureNo, _health, _damage);
  }

  void move(PVector _target)
  { 
    dir = PVector.sub(_target, pos);
    
    dir.normalize();
    dir.mult(speed);
    
    pos.add(dir);
  }
}