QueasyCam cam;

Player player;

Room room;

boolean shooting;

PVector roomSize = new PVector(1000, 500, 1000);

PImage texture[] = new PImage[2];
PImage roomTexture[] = new PImage[1];
PImage doorTexture[] = new PImage[2];
PImage statIcon[] = new PImage[5]; 

Floor floor;

int prs = 0; // player room up, determines which the first value of the room the player is in in the 2D array map
int pru = 1; // player room side, determines which the second value of the room the player is in in the 2D array map


IntList prss = new IntList();
IntList prus = new IntList();

int time;

boolean flying = false;

int numItems = 6; // number of items

int screenState;

void setup() 
{
  fullScreen(P3D);
  noStroke();

  rectMode(CENTER);
  textAlign(CENTER);
  imageMode(CENTER);

  cam = new QueasyCam(this, 0.01f, 1415f);
  cam.setSensitivity(1f);
  
  player = new Player(new PVector(50, 75, 50), 3.5, 1, 1, 10, 750, 5, 6);

  cam.speed = 2 * player.speed;

  texture[0] = loadImage("tear.png");
  texture[1] = loadImage("bloodTear.png");

  roomTexture[0] = loadImage("floor.png");

  doorTexture[0] = loadImage("closedDoor.png");
  doorTexture[1] = loadImage("openDoor.png");
  
  statIcon[0] = loadImage("Damage_Stat_Icon.png");
  statIcon[1] = loadImage("Speed_Stat_Icon.png");
  statIcon[2] = loadImage("Tears_Stat_Icon.png");
  statIcon[3] = loadImage("Shot_Speed_Stat_Icon.png");
  statIcon[4] = loadImage("Range_Stat_Icon.png");

  for(int i = 0; i < statIcon.length; i++)
  {
   statIcon[i].resize(50, 50); 
  }

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
  
  fill(128, 128 - (player.getHealth()/player.getMaxHealth()) * 128);
  rect(width/2, height/2, width, height);
  
  fill(255);
  
  textAlign(LEFT);
  textSize(20);
  text(player.getDamage(), width/14.4, height/3);
  text(player.getSpeed(), width/14.4, height/2.4);
  text(player.getTears(), width/14.4, height/2);
  text(player.getShotSpeed(), width/14.4, height/1.714285);
  text(player.getRange(), width/14.4, 2*height/3);
  
  for(int i = 0; i < statIcon.length; i++)
  {
    image(statIcon[i], width/28.8, height/3 + i * 75);
  }
  
  textAlign(CENTER);

  cam.endHUD();

  fill(255);

  if (time < millis())
  {
    if (shooting)
    {
      player.shoot();
    }

    float delay = player.getTears() * 60;

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