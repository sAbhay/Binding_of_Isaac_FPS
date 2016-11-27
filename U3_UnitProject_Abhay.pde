import queasycam.*;

QueasyCam cam;

Player player;

PVector target;

ArrayList<Bullet> b = new ArrayList<Bullet>();

void setup() 
{
  fullScreen(P3D);
  strokeWeight(2);

  cam = new QueasyCam(this);
  player = new Player();

  cam.speed = 1;
  
  target = new PVector();
}

void draw() 
{ 
  background(0);

  stroke(255);
  noFill();
  box(200);

  cam.position.y = player.pos.y;
  
  target = cam.getForward();

  pushMatrix();

  translate(target.x, target.y, target.z);
  sphere(75);

  popMatrix();

  for (int i = 0; i < b.size(); i++)
  {
    b.get(i).update();
  }
}

void mousePressed()
{
  b.add(new Bullet(cam.position, target, 10, color(255, 0, 0)));
}