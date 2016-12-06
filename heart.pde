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
    
    switch(type)
    {
     case 0:
     heart = loadShape("half_heart.obj");
     break;
     
     case 1:
     heart = loadShape("heart.obj");
     break;
     
     case 2:
     heart = loadShape("heart_bundle.obj");
     break;
    }
    
    heart.scale(30);
  }
  
  void take()
  {
    if(player.pos.x >= -40 && player.pos.x <= 40 && player.pos.z >= -40 && player.pos.z <= 40)
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