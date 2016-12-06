QueasyCam cam; //<>//

Player player;

Room room;

boolean shooting;

PVector roomSize = new PVector(1000, 500, 1000);

PImage texture[] = new PImage[2];
PImage roomTexture[] = new PImage[1];
PImage doorTexture[] = new PImage[2];

Floor floor;

int prs = 0; // player room up, determines which the first value of the room the player is in in the 2D array map
int pru = 1; // player room side, determines which the second value of the room the player is in in the 2D array map

int time;

void setup() 
{
  fullScreen(P3D);
  noStroke();

  cam = new QueasyCam(this, 0.01f, 1415f);
  player = new Player(new PVector(100, 200, 100), 1, 2, 10, 500, 750, 5, 6);

  cam.speed = player.speed;

  texture[0] = loadImage("tear.png");
  texture[1] = loadImage("bloodTear.png");

  roomTexture[0] = loadImage("floor.png");

  doorTexture[0] = loadImage("closedDoor.png");
  doorTexture[1] = loadImage("openDoor.png");

  floor = new Floor();

  floor.create();

  time = millis();

  noCursor();
}

void draw() 
{ 
  background(0);

  cam.position.y = player.size.y/3;

  player.pos = cam.position;

  floor.update();

  player.update();

  println(prs + ", ", pru);

  if (player.health <= 0) background(255, 0, 0);

  for (int i = 0; i < player.health; i++)
  {
    PVector forward = player.getTarget();

    pushMatrix();

    translate(forward.x, forward.y, forward.z);
    
    pushMatrix();
    
    translate(i*0.1 - 0.5, -0.4, 0);
    
    fill(255, 0, 0, 100);
    noStroke();
    box(0.06);

    popMatrix();
    
    popMatrix();
  }

  fill(255);

  if (time < millis())
  {
    if (shooting)
    {
      player.shoot();
    }

    float delay = player.getTears();

    time += delay;
  }
}

void mousePressed()
{
  shooting = true;

  time = millis();
}

void mouseReleased()
{
  shooting = false;
}