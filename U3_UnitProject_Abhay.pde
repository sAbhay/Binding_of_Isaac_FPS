import queasycam.*;

QueasyCam cam;

Player player;

Room room;

boolean shooting;

PVector roomSize = new PVector(1000, 500, 1000);

ArrayList<RedFly> rf = new ArrayList<RedFly>();

PImage texture[] = new PImage[2];

PImage roomTexture[] = new PImage[2];

Floor floor;

int pru = 0; // player room up, determines which the first value of the room the player is in in the 2D array map
int prs = 0; // player room side, determines which the second value of the room the player is in in the 2D array map

void setup() 
{
  fullScreen(P3D);
  noStroke();

  cam = new QueasyCam(this);
  player = new Player(new PVector(100, 200, 100), 0, 0, 0, 0, 1000, 0, 6);

  cam.speed = 10;

  texture[0] = loadImage("redfly.png");
  texture[1] = loadImage("blueTear.png");

  roomTexture[0] = loadImage("floor.png");
  
  //cam.

  //room = new Room(new PVector(0, 0, 0));
  
  floor = new Floor();
  
  floor.create();
}

void draw() 
{ 
  background(0);

  cam.position.y = player.size.y/3;

  player.pos = cam.position;

  floor.update();

  player.update();

  for (int i = 0; i < rf.size(); i++)
  { 
    rf.get(i).move(player.getPos());
    rf.get(i).update();

    if (rf.get(i).killed) rf.remove(i);
    
    if(rf.size() != 0 && i != rf.size()) player.hit(rf.get(i));
  }

  if (rf.size() == 0)
  {
    for (int i = 0; i < 5; i++)
    {
      //rf.add(new RedFly(new PVector(random(-roomSize.x/2, roomSize.x/2), random(-roomSize.y/2, roomSize.y/2), random(-roomSize.z/2, roomSize.z/2)), 2, new PVector(20, 20, 20), 0, 2, 1));
    }
  }
  
  println(player.health);
  
  if(player.health <= 0) background(255, 0, 0);
  
  for(int i = 0; i < player.health; i++)
  {
    PVector forward = player.getTarget();
    
    pushMatrix();
    
    translate(forward.x, forward.y, forward.z);
    fill(255, 0, 0, 20);
    noStroke();
    box(i * 0.01, i * 0.01, i * 0.01);
    
    popMatrix();
  }
  
  fill(255);
}

void mousePressed()
{
  player.shoot();
}