class Camera extends QueasyCam 
{
  Camera(PApplet applet)
  {
    super(applet);
  }
  
  void setPosition(PVector pos)
  {
    position = pos;
        cam.velocity  = new PVector(0,0);
  }
  
  
}