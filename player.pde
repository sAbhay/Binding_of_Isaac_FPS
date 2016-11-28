class Player
{
  private PVector pos;

  private float size;
  private float damage;
  private float speed;
  private float shotSpeed;
  private float tears;
  private float range;
  private float tearSize;

  private ArrayList<Bullet> b = new ArrayList<Bullet>();

  Player(float _size, float _damage, float _speed, float _shotSpeed, float _tears, float _range, float _tearSize)
  {
    size = _size;
    damage = _damage;
    speed = _speed;
    shotSpeed = _shotSpeed;
    tears = _tears;
    range = _range;
    tearSize = _tearSize;
    
    pos = new PVector(0, -size, 0);
  }

  void shoot()
  {
    b.add(new Bullet(cam.position, target, 10, color(255, 0, 0), 100, 10));
  }

  void update()
  {
    for (int i = 0; i < b.size(); i++)
    {
      b.get(i).update();

      if (b.get(i).outOfRange())
      {
        b.remove(i);
      }
    }
  }

  PVector getPos()
  {
    return pos;
  }
}