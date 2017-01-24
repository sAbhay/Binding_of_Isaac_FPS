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

IntList prss = new IntList();
IntList prus = new IntList();

int time;

boolean flying = false;

int numItems = 6; // number of items

void setup() 
{
  fullScreen(P3D);
  noStroke();

  rectMode(CENTER);
  textAlign(CENTER);

  cam = new QueasyCam(this, 0.01f, 1415f);
  player = new Player(new PVector(50, 75, 50), 1, 2, 10, 500, 750, 5, 6);

  cam.speed = player.speed;

  texture[0] = loadImage("tear.png");
  texture[1] = loadImage("bloodTear.png");

  roomTexture[0] = loadImage("floor.png");

  doorTexture[0] = loadImage("closedDoor.png");
  doorTexture[1] = loadImage("openDoor.png");

  prss.append(prs);
  prus.append(pru);

  floor = new Floor();

  floor.create();

  time = millis();

  noCursor();
}

void draw() 
{ 
  background(0);

  if (!flying) 
  {
    cam.position.y = player.size.y/3;
  } else 
  {
    cam.position.y = -player.size.y/2;
  }

  player.pos = cam.position;

  floor.update();

  player.update();

  if (player.health <= 0) background(255, 0, 0);

  cam.beginHUD();

  for (int i = 0; i < player.getMaxHealth(); i++)
  { 
    fill(0, 200);
    rect(i * 50 + 25, 25, 25, 25);
  }

  for (int i = 0; i < player.health; i++)
  { 
    fill(255, 0, 0);
    rect(i * 50 + 25, 25, 25, 25);
  }

  fill(255);
  rect(width/2, height/2, 3, 15);
  rect(width/2, height/2, 15, 3);

  floor.floorMap();

  cam.endHUD();

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
  
  cam.beginHUD();
  
  fill(128, 128 - (player.getHealth()/player.getMaxHealth()) * 128);
  rect(width/2, height/2, width, height);
  
  cam.endHUD();
  
  fill(255);
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