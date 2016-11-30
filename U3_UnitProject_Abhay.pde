import queasycam.*;

QueasyCam cam;

Player player;

Room room;

boolean shooting;

PVector roomSize = new PVector(1000, 500, 1000);

ArrayList<RedFly> rf = new ArrayList<RedFly>();

PImage texture[] = new PImage[2];

void setup() 
{
  fullScreen(P3D);
  noStroke();

  cam = new QueasyCam(this);
  player = new Player(new PVector(100, 200, 100), 0, 0, 0, 0, 1000, 0);

  cam.speed = 1;

  texture[0] = loadImage("redfly.png");
  texture[1] = loadImage("blueTear.png");

  //cam.

  room = new Room();

  for (int i = 0; i < 5; i++)
  {
    rf.add(new RedFly(new PVector(random(-roomSize.x/2, roomSize.x/2), random(-roomSize.y/2, roomSize.y/2), random(-roomSize.z/2, roomSize.z/2)), 2, new PVector(20, 20, 20), 0, 2));
  }
}

void draw() 
{ 
  //keeping the player inside the room
  if (cam.position.x <= -roomSize.x/2) cam.position.x = -roomSize.x/2;
  if (cam.position.x >= roomSize.x/2) cam.position.x = roomSize.x/2;
  if (cam.position.y <= -roomSize.y/2) cam.position.y = -roomSize.x/2;
  if (cam.position.y >= roomSize.y/2) cam.position.y = roomSize.x/2;
  if (cam.position.z <= -roomSize.z/2) cam.position.z = -roomSize.x/2;
  if (cam.position.z >= roomSize.z/2) cam.position.z = roomSize.x/2;

  background(0);

  cam.position.y = player.size.y/3;

  player.pos = cam.position;

  room.display();

  player.update();

  for (int i = 0; i < rf.size(); i++)
  { 
    rf.get(i).move(player.getPos());
    rf.get(i).update();

    if (rf.get(i).killed) rf.remove(i);
  }

  if (rf.size() == 0)
  {
    for (int i = 0; i < 5; i++)
    {
      rf.add(new RedFly(new PVector(random(-roomSize.x/2, roomSize.x/2), random(-roomSize.y/2, roomSize.y/2), random(-roomSize.z/2, roomSize.z/2)), 2, new PVector(20, 20, 20), 0, 2));
    }
  }
}

void mousePressed()
{
  player.shoot();
}