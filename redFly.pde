class RedFly extends Enemy
{
  RedFly(PVector _pos, float _speed, PVector _size, int _textureNo, int _health)
  {
    super(_pos, _speed, _size, _textureNo, _health);
  }

  void move(PVector _target)
  { 
    dir = PVector.sub(_target, pos);
    
    dir.normalize();
    dir.mult(speed);
    
    pos.add(dir);
  }
}