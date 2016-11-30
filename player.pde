class Player
{
  private PVector pos;

  public PVector size;
  private float damage;
  private float speed;
  private float shotSpeed;
  public float tears;
  private float range;
  private float tearSize;

  private PVector target;

  public ArrayList<Bullet> b = new ArrayList<Bullet>();

  Player(PVector _size, float _damage, float _speed, float _shotSpeed, float _tears, float _range, float _tearSize)
  {
    size = _size;
    damage = _damage;
    speed = _speed;
    shotSpeed = _shotSpeed;
    tears = _tears;
    range = _range;
    tearSize = _tearSize;

    pos = new PVector(0, size.y/2, 0);
  }

  void shoot()
  {
    b.add(new Bullet(cam.position, target, 10, color(255, 0, 0), range, 5, 1));
  }

  void update()
  {
    target = PVector.add(cam.position, cam.getForward());

    for (int i = 0; i < b.size(); i++)
    {
      b.get(i).update();

      if (b.get(i).outOfRange() || b.get(i).outOfBounds())
      {
        b.remove(i);
      }
    }
  }

  PVector getPos()
  {
    return pos;
  }

  ArrayList getTears()
  {
    return b;
  }
}