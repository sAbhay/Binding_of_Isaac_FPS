import queasycam.*;

Camera cam;

Player player;

boolean upPressed, downPressed, leftPressed, rightPressed;

PVector target;

void setup() 
{
  fullScreen(P3D);
  strokeWeight(2);

  cam = new Camera(this);
  player = new Player();
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
}

void keyPressed()
{
  if (key == 't')
  {
    upPressed = true;
  }

  if (key == 'f')
  {
    leftPressed = true;
  }

  if (key == 'g')
  {
    downPressed = true;
  }

  if (key == 'h')
  {
    rightPressed = true;
  }
}

void keyReleased()
{
  if (key == 't')
  {
    upPressed = false;
  }

  if (key == 'f')
  {
    leftPressed = false;
  }

  if (key == 'g')
  {
    downPressed = false;
  }

  if (key == 'h')
  {
    rightPressed = false;
  }
}

void playerMove()
{
  if (upPressed) player.forward();
  if (downPressed) player.back();
  if (leftPressed) player.left();
  if (rightPressed) player.right();
}