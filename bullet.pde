class Bullet
{
  public PVector pos;
  private PVector dir;

  private float speed;
  private float size;

  private float range;

  private PVector start;

  private PShape tear;

  Bullet(PVector _start, PVector _target, float _speed, float _range, float _tearSize, int _textureNo)
  {
    size = _tearSize; 
    speed = _speed;

    pos = new PVector(_start.x, _start.y, _start.z); // _start determines the spawn point
    dir = new PVector(_target.x, _target.y, _target.z); // _target determines target

    dir = PVector.sub(_start, _target); // causes the bullet to move at angle based on its target's relative position from the spawn point

    dir.normalize();
    dir.mult(-speed);

    range = _range;

    start = _start;

    noStroke();
    tear = createShape(SPHERE, size);
    tear.setTexture(texture[_textureNo]);
  }

  void display()
  {
    pushMatrix();

    translate(pos.x, pos.y, pos.z); // draws bullets at pos
    shape(tear);

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

  boolean outOfBounds()
  {
    if (pos.x < -roomSize.x/2 || pos.x > roomSize.x/2 || pos.z > roomSize.z/2 || pos.z < -roomSize.x/2 || pos.y < -roomSize.y/2 || pos.y > roomSize.z/2) // checks whether its position lies outside the space
    {
      return true;
    }

    return false;
  }
}