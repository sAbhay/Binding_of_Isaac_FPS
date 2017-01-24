class Item
{
  private PShape item;
  private PVector pos;
  public String name;
  private int select;
  private float rot;

  private ItemOutline[] o = new ItemOutline[numItems];

  private int frame;
  private boolean picked;

  Item(PVector _pos, int _select)
  {
    pos = _pos;

    o[0] = new ItemOutline("Transcendence", 40, 0, 0, 0, 0);
    o[1] = new ItemOutline("Dinner", 40, 1, 2, 0, 0);
    o[2] = new ItemOutline("Blood_of_the_Martyr", 40, 2, 1, 0, 0);
    o[3] = new ItemOutline("Sad_Onion", 35, 3, 100, 0, 0);
    o[4] = new ItemOutline("Torn_Photo", 40, 3, 100, 4, 2);
    o[5] = new ItemOutline("Growth_Hormones", 10, 4, 1, 2, 1);

    select = _select;
    name = o[select].name;

    item = loadShape(name + ".obj");
    item.scale(o[select].scale);

    rot = 0;
  }

  private void display()
  {
    if ((player.pos.x - player.size.x/2 >= pos.x - 40 || player.pos.x + player.size.x/2 >= pos.x - 40) && (player.pos.x- player.size.x/2 <= pos.x + 40 || player.pos.x <= pos.x + 40) && (player.pos.z + player.size.z/2 >= pos.z - 40 || player.pos.z - player.size.z/2 >= pos.z - 40) && (player.pos.z - player.size.z/2 <= pos.z + 40 || player.pos.z + player.size.z/2 <= pos.z + 40))
    {
      picked = true;
    }
    
    pushMatrix();

    translate(pos.x, pos.y, pos.z);
    rotateX(PI);

    rot++;
    rotateY(radians(rot));

    shape(item);

    popMatrix();
  }

  public void changeStat()
  {
    switch(o[select].statSelect)
    {
    case 1: // heart containers
      float mh = player.getMaxHealth();
      mh += o[select].change;
      player.setMaxHealth(mh);
      break;

    case 2: // damage and tear size
      float d = player.getDamage();
      d += o[select].change;
      player.setDamage(d);

      float ts = player.getTearSize();
      ts += o[select].change/2;
      player.setTearSize(ts);
      break;

    case 3: // tears
      float t = player.getTears();
      t -= o[select].change;
      player.setTears(t);
      break;

    case 4: // shot speed
      float ss = player.getShotSpeed();
      ss += o[select].change;
      player.setShotSpeed(ss);
      break;

    case 5: // speed
      float s = player.getSpeed();
      s += o[select].change;
      player.setSpeed(s);
      break;
    }

    switch(o[select].secondary)
    {
    case 1: // heart containers
      float mh = player.getMaxHealth();
      mh += o[select].secondaryChange;
      player.setMaxHealth(mh);
      break;

    case 2: // damage and tear size
      float d = player.getDamage();
      d += o[select].secondaryChange;
      player.setDamage(d);

      float ts = player.getTearSize();
      ts += o[select].secondaryChange/2;
      player.setTearSize(ts);
      break;

    case 3: // tears
      float t = player.getTears();
      t -= o[select].secondaryChange;
      player.setTears(t);
      break;

    case 4: // shot speed
      float ss = player.getShotSpeed();
      ss += o[select].secondaryChange;
      player.setShotSpeed(ss);
      break;

    case 5: // speed
      float s = player.getSpeed();
      s += o[select].secondaryChange;
      player.setSpeed(s);
      break;
    }
  }

  public void name()
  {    
    frame++;

    if (frame < frameRate*2)
    {
      cam.beginHUD();

      fill(0);
      rect(width/2, height/2, width, height/10);
      textSize(height/20);

      String n = name;

      n = n.replaceAll("_", " ");

      fill(255);
      text(n, width/2, height/2 + height/40);

      cam.endHUD();
    }
  }
  
  public int getFrame()
  {
   return frame; 
  }
}