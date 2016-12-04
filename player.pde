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

  public float health;

  Player(PVector _size, float _damage, float _speed, float _shotSpeed, float _tears, float _range, float _tearSize, float _health)
  {
    size = _size;
    damage = _damage;
    speed = _speed;
    shotSpeed = _shotSpeed;
    tears = _tears;
    range = _range;
    tearSize = _tearSize;

    health = _health;

    pos = new PVector(0, size.y/2, 0);
  }

  void shoot()
  {
    b.add(new Bullet(cam.position, target, shotSpeed, range, 5, 1));
  }

  void update()
  {
    checkBoundaries();

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

  void hit(Enemy enemy)
  {
    if (pos.x >= enemy.pos.x - enemy.size.x/2 && pos.x <= enemy.pos.x + enemy.size.x/2 && pos.y >= enemy.pos.y - enemy.size.y/2 && pos.y <= enemy.pos.y + enemy.size.y/2 && pos.z >= enemy.pos.z - enemy.size.z/2 && pos.z <= enemy.pos.z + enemy.size.z/2)
    {
      pos.x += enemy.size.x*4;
      pos.y += enemy.size.y*4;
      pos.z += enemy.size.z*4;

      health -= enemy.damage;
    }
  }

  void checkBoundaries()
  {
    //keeping the player inside the room
    if (cam.position.x <= -roomSize.x/2 + 10) cam.position.x = -roomSize.x/2 + 10;
    if (cam.position.x >= roomSize.x/2 - 10) cam.position.x = roomSize.x/2 - 10;
    if (cam.position.y <= -roomSize.y/2 + 10) cam.position.y = -roomSize.x/2 + 10;
    if (cam.position.y >= roomSize.y/2 - 10) cam.position.y = roomSize.x/2 - 10;
    if (cam.position.z <= -roomSize.z/2 + 10) cam.position.z = -roomSize.x/2 + 10;
    if (cam.position.z >= roomSize.z/2 - 10) cam.position.z = roomSize.x/2 - 10;
  }

  void checkIfShot(Enemy enemy)
  {
    for (int i = 0; i < enemy.b.size(); i++)
    {
      if (enemy.b.get(i).pos.z >= pos.z - size.z/2 && enemy.b.get(i).pos.z <= pos.z + size.z/2 && enemy.b.get(i).pos.x >= pos.x - size.x/2 && enemy.b.get(i).pos.x <= pos.x + size.x/2 && enemy.b.get(i).pos.y >= pos.y - size.y/2 && enemy.b.get(i).pos.y <= pos.y + size.y/2)
      {
        enemy.b.remove(i);
        health -= enemy.damage;
      }
    }
  }

  PVector getPos()
  {
    return pos;
  }

  PVector getTarget()
  {
    return target;
  }

  float getTears()
  {
    return tears;
  }
}