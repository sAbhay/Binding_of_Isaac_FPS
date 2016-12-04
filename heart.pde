class Heart
{
  PShape heart;
  int type;
  
  boolean isActive;
  boolean picked;
  
  Heart(int _type)
  {
    type = _type;
    heart = createShape(BOX, 40);
    
    heart.setTexture(heartTexture[type]);
  }
  
  void take()
  {
    if(player.pos.x >= -20 && player.pos.x <= 20 && player.pos.z >= -20 && player.pos.z <= 20)
    { 
      picked = true;
      
     switch(type)
     {
       case 0:
       player.health++;
       break;
       
       case 1:
       player.health += 2;
       break;
       
       case 2:
       player.health += 4;
       break;
     }
    }
  }
  
  void display()
  {
    pushMatrix();
    translate(0, roomSize.y/2 - 20, 0);
    shape(heart);
    popMatrix();
  }
  
  void update()
  {
    take();
    display();
  }
  
  boolean picked()
  {
    if(player.pos.x >= -10 && player.pos.x <= 10 && player.pos.z >= -10 && player.pos.z <= 10)
    {
      return true;
    }
    return false;
  }
  
  void setIsActive(boolean _isActive)
  {
    isActive = _isActive;
  }
}