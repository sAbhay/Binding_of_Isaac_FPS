class Item
{
  private PShape item;
  private PVector pos;

  public String name;
  private String n;

  private int selectPassive;
  private int selectActive;
  private float rot;

  private ItemOutline[] o = new ItemOutline[numItems];

  private int frame;
  private boolean picked;

  Item(PVector _pos, int _selectPassive, int _selectActive)
  {
    pos = _pos;

    o[0] = new ItemOutline("Transcendence", 40, 0, 0, 0, 0);
    o[1] = new ItemOutline("Dinner", 40, 1, 2, 0, 0);
    o[2] = new ItemOutline("Blood_of_the_Martyr", 40, 2, 1, 0, 0);
    o[3] = new ItemOutline("Sad_Onion", 35, 3, 2, 0, 0);
    o[4] = new ItemOutline("Torn_Photo", 40, 3, 2, 4, 0.15);
    o[5] = new ItemOutline("Growth_Hormones", 10, 5, 0.2, 2, 1);

    selectPassive = _selectPassive;
    selectActive = _selectActive;
    name = o[selectPassive].name;

    item = loadShape(name + ".obj");
    item.scale(o[selectPassive].scale);

    rot = 0;
  }

  private void display()
  {
    if ((player.pos.x - player.size.x/2 >= pos.x - 40 || player.pos.x + player.size.x/2 >= pos.x - 40) && (player.pos.x- player.size.x/2 <= pos.x + 40 || player.pos.x <= pos.x + 40) && (player.pos.z + player.size.z/2 >= pos.z - 40 || player.pos.z - player.size.z/2 >= pos.z - 40) && (player.pos.z - player.size.z/2 <= pos.z + 40 || player.pos.z + player.size.z/2 <= pos.z + 40))
    {
      picked = true;

      n = name;

      n = n.replaceAll("_", " ");
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
    switch(o[selectPassive].statSelect)
    {
    case 1: // heart containers
      float mh = player.getMaxHealth();
      mh += o[selectPassive].change;
      player.setMaxHealth(mh);
      break;

    case 2: // damage and tear size
      float d = player.getDamage();
      d += o[selectPassive].change;
      player.setDamage(d);

      float ts = player.getTearSize();
      ts += o[selectPassive].change/2;
      player.setTearSize(ts);
      break;

    case 3: // tears
      float t = player.getTears();
      t -= o[selectPassive].change;
      player.setTears(t);
      break;

    case 4: // shot speed
      float ss = player.getShotSpeed();
      ss += o[selectPassive].change;
      player.setShotSpeed(ss);
      break;

    case 5: // speed
      float s = player.getSpeed();
      s += o[selectPassive].change;
      player.setSpeed(s);
      break;
    }

    switch(o[selectPassive].secondary)
    {
    case 1: // heart containers
      float mh = player.getMaxHealth();
      mh += o[selectPassive].secondaryChange;
      player.setMaxHealth(mh);
      break;

    case 2: // damage and tear size
      float d = player.getDamage();
      d += o[selectPassive].secondaryChange;
      player.setDamage(d);

      float ts = player.getTearSize();
      ts += o[selectPassive].secondaryChange/2;
      player.setTearSize(ts);
      break;

    case 3: // tears
      float t = player.getTears();
      t -= o[selectPassive].secondaryChange;
      player.setTears(t);
      break;

    case 4: // shot speed
      float ss = player.getShotSpeed();
      ss += o[selectPassive].secondaryChange;
      player.setShotSpeed(ss);
      break;

    case 5: // speed
      float s = player.getSpeed();
      s += o[selectPassive].secondaryChange;
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

      fill(255);
      text(n, width/2, height/2 + height/40);

      textAlign(LEFT);
      textSize(20);

      String p;
      String s;
      color f;

      if (o[selectPassive].change < 0) 
      {
        if (o[selectPassive].statSelect != 3) p = " - ";
        else p = " + ";
        
        f = color(255, 0, 0);
      } else 
      {
        if (o[selectPassive].statSelect != 3) p = " + ";
        else p = " - ";
        
        f = color(0, 255, 0);
      }

      if (o[selectPassive].secondaryChange < 0) 
      {
        if (o[selectPassive].secondary != 3) s = " - ";
        else s = " + ";
        
        f = color(255, 0, 0);
      } else 
      {
        if (o[selectPassive].secondary != 3) s = " + ";
        else s = " - ";
        
        f = color(0, 255, 0);
      }

      fill(f);

      switch(o[selectPassive].statSelect)
      {
      case 2: // damage and tear size
        text(p + o[selectPassive].change, width/7.2, height/3);
        break;

      case 3: // tears
        text(p + o[selectPassive].change, width/7.2, height/2);
        break;

      case 4: // shot speed
        text(p + o[selectPassive].change, width/7.2, height/1.714285);
        break;

      case 5: // speed
        text(p + o[selectPassive].change, width/7.2, height/2.4);
        break;
      }

      switch(o[selectPassive].secondary)
      {
      case 2: // damage and tear size
        text(s + o[selectPassive].secondaryChange, width/7.2, height/3);
        break;

      case 3: // tears
        text(s + o[selectPassive].secondaryChange, width/7.2, height/2);
        break;

      case 4: // shot speed
        text(s + o[selectPassive].secondaryChange, width/7.2, height/1.714285);
        break;

      case 5: // speed
        text(s + o[selectPassive].secondaryChange, width/7.2, height/2.4);
        break;
      }

      fill(0);

      cam.endHUD();
    }
  }

  public int getFrame()
  {
    return frame;
  }

  public void active()
  {
    switch(selectActive)
    {
    case 1:
      break;
    }
  }
}