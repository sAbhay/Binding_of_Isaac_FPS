class Bullet
{
  public PVector pos;
  private PVector dir;

  float speed;
  float size;

  color colour;

  float range;

  PVector start;

  boolean isAlive;

  Bullet(PVector _start, PVector _target, float _speed, color _colour, float _range, float _tearSize)
  {
    size = _tearSize; 
    speed = _speed;

    pos = new PVector(_start.x, _start.y, _start.z); // _start determines the spawn point
    dir = new PVector(_target.x, _target.y, _target.z); // _target determines target

    dir = PVector.sub(_start, _target); // causes the bullet to move at angle based on its target's relative position from the spawn point

    dir.normalize();
    dir.mult(-speed);

    colour = _colour;

    range = _range;

    start = _start;
  }

  void display()
  {
    pushMatrix();

    translate(pos.x, pos.y, pos.z); // draws bullets at pos
    noStroke();
    fill(colour);
    sphere(size);

    popMatrix();
  }

  void move()
  {
    pos.add(dir); // causes the bullet to move towards the target every tick
  }

  void update()
  {
    display();
    move();
  }

  boolean outOfRange()
  {
    if (dist(start.x, start.y, start.z, pos.x, pos.y, pos.z) > range)
    {
      return true;
    }

    return false;
  }

  boolean hitEnemy()
  {
    return false;
  }

  boolean outOfBounds()
  {
    if (pos.x < -roomSize.x/2 || pos.x > roomSize.x/2 || pos.z > roomSize.z/2 || pos.z < -roomSize.x/2 || pos.y < -roomSize.y/2 || pos.y > roomSize.z/2) // checks whether its position lies outside the space
    {
      return true;
    }

    return false;
  }
}