import queasycam.*;

QueasyCam cam;

Player player;

PVector target;

Room room;

void setup() 
{
  fullScreen(P3D);
  strokeWeight(2);

  cam = new QueasyCam(this);
  player = new Player(100, 0, 0, 0, 0, 0, 0);

  cam.speed = 1;
  
  target = new PVector();
  room = new Room();
}

void draw() 
{ 
  background(0);

  cam.position.y = player.pos.y;
  
  target = PVector.add(cam.position, cam.getForward());
  
  room.display();
  
  player.update();
}

void mousePressed()
{
  player.shoot();
}