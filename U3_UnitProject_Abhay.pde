import damkjer.ocd.*;

Camera cam;

float range = 10000; // z-length of the space

float[] target; // tracks camera's target in the form of a float array: [0] = x, [1] = y, [2] = z
float[] camPos; // tracks camera's position in the form of a float array: [0] = x, [1] = y, [2] = z

PVector bulletTarget = new PVector(); // crosshair position, camera's target
PVector playerPos = new PVector();

ArrayList<Bullet> b = new ArrayList<Bullet>();

void setup()
{
  fullScreen(P3D);
  noStroke();
  rectMode(CENTER);

  noCursor();

  cam = new Camera(this, width/2, height/2, 0, width/2, height/2, -range);

  textAlign(CENTER);
}

void draw()
{
  background(0);

  //noCursor();

  target = cam.target();
  camPos = cam.position();

  cam.feed();
  mouseLook();

  // sets player position to camera position 

  playerPos.x = camPos[0];
  playerPos.y = camPos[1];
  playerPos.z = camPos[2];

  bulletTarget.x = target[0];
  bulletTarget.y = target[1];
  bulletTarget.z = target[2];

  //bulletTarget = new PVector(target[0], target[1], target[2]);

  pushMatrix();
  translate(width/2, height/2, -range/2);
  noFill();
  stroke(255);
  box(width, height, range);
  popMatrix();

  noStroke();
  fill(255, 0, 0);
  pushMatrix();
  translate(target[0], target[1], target[2]);
  sphere(30); // crosshair, aiming reticule
  strokeWeight(5);
  stroke(0, 255, 0);
  noFill();
  fill(255);
  textSize(200);
  popMatrix();

  strokeWeight(1);
  noStroke();
  fill(255);

  for (int i = 0; i < b.size(); i++)
  {
    b.get(i).update();
  }
}

void mousePressed() // add bullet when mousePressed
{ 
  b.add(new Bullet(playerPos, bulletTarget, 100, color(0, 255, 0)));
}