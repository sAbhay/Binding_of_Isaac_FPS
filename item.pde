class Item
{
  private PShape item;
  private PVector pos;
  public String name;

  private Outline[] outlines = new Outline[5];

  Item(PVector _pos, int select)
  {
    pos = _pos;

    outlines[0] = new Outline("Transcendence", 0, 0, 0, 0);
    outlines[1] = new Outline("Snack", 1, 1, 0, 0);
    outlines[2] = new Outline("Blood of the Martyr", 2, 1, 0, 0);
    outlines[3] = new Outline("Sad Onion", 3, 100, 0, 0);
    outlines[4] = new Outline("Torn Photo", 3, 100, 4, 2);

    name = outlines[select].name;
    
    item = loadShape(name + ".obj");
    item.scale(40);
  }

  public boolean pick()
  {
    if ((player.pos.x - player.size.x/2 >= pos.x - 40 || player.pos.x + player.size.x/2 >= pos.x - 40) && (player.pos.x- player.size.x/2 <= pos.x + 40 || player.pos.x <= pos.x + 40) && (player.pos.z + player.size.z/2 >= pos.z - 40 || player.pos.z - player.size.z/2 >= pos.z - 40) && (player.pos.z - player.size.z/2 <= pos.z + 40 || player.pos.z + player.size.z/2 <= pos.z + 40))
    {
      return true;
    }

    return false;
  }

  private void display()
  {
    pushMatrix();

    translate(pos.x, pos.y, pos.z);
    rotateX(PI);
    shape(item);

    popMatrix();
  }

  public void changeStat()
  {
    for (Outline o : outlines)
    {
      switch(o.statSelect)
      {
      case 0:
        float mh = player.getMaxHealth();
        mh += o.change;
        player.setMaxHealth(mh);
        break;

      case 1:
        float d = player.getDamage();
        d += o.change;
        player.setDamage(d);

        float ts = player.getTearSize();
        ts += o.change/2;
        player.setTearSize(ts);
        break;

      case 2:
        float t = player.getTears();
        t -= o.change;
        player.setTears(t);
        break;

      case 3:
        float ss = player.getShotSpeed();
        ss -= o.change;
        player.setShotSpeed(ss);
        break;
      }
      
      switch(o.secondary)
      {
      case 0:
        float mh = player.getMaxHealth();
        mh += o.secondaryChange;
        player.setMaxHealth(mh);
        break;

      case 1:
        float d = player.getDamage();
        d += o.secondaryChange;
        player.setDamage(d);

        float ts = player.getTearSize();
        ts += o.secondaryChange/2;
        player.setTearSize(ts);
        break;

      case 2:
        float t = player.getTears();
        t -= o.secondaryChange;
        player.setTears(t);
        break;

      case 3:
        float ss = player.getShotSpeed();
        ss -= o.secondaryChange;
        player.setShotSpeed(ss);
        break;
      }
    }
  }

  public void giveFlight(boolean _flight)
  {
    flying = _flight;
  }
}