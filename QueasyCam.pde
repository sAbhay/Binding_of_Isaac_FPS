import java.awt.MouseInfo;
import java.awt.Point;
import java.awt.Robot;
import java.awt.GraphicsEnvironment;
import java.util.HashMap;
import processing.core.*;
import processing.event.KeyEvent;

public class QueasyCam {
  public final static String VERSION = "##library.prettyVersion##";

  public boolean controllable;
  public float speed;
  public float sensitivity;
  public PVector position;
  public float pan;
  public float tilt;
  public PVector velocity;
  public float friction;

  private PApplet applet;
  private Robot robot;
  private PVector center;
  private PVector up;
  private PVector right;
  private PVector forward;
  private Point mouse;
  private Point prevMouse;
  private HashMap<Character, Boolean> keys;
  
  private final PMatrix3D originalMatrix;

  public QueasyCam(PApplet applet, float near, float far){
    this.applet = applet;
    applet.registerMethod("draw", this);
    applet.registerMethod("keyEvent", this);
    this.originalMatrix = applet.getMatrix((PMatrix3D)null);
    
    try {
      robot = new Robot();
    } catch (Exception e){}

    controllable = true;
    speed = 3f;
    sensitivity = 2f;
    position = new PVector(0f, 0f, 0f);
    up = new PVector(0f, 1f, 0f);
    right = new PVector(1f, 0f, 0f);
    forward = new PVector(0f, 0f, 1f);
    velocity = new PVector(0f, 0f, 0f);
    pan = 0f;
    tilt = 0f;
    friction = 0.75f;
    keys = new HashMap<Character, Boolean>();

    applet.perspective(PConstants.PI/3f, (float)applet.width/(float)applet.height, near, far);
  }

  public void draw(){
    if (!controllable) return;
    
    mouse = MouseInfo.getPointerInfo().getLocation();
    if (prevMouse == null) prevMouse = new Point(mouse.x, mouse.y);
    
    int w = GraphicsEnvironment.getLocalGraphicsEnvironment().getMaximumWindowBounds().width;
    int h = GraphicsEnvironment.getLocalGraphicsEnvironment().getMaximumWindowBounds().height;
    
    if (mouse.x < 1 && (mouse.x - prevMouse.x) < 0){
      robot.mouseMove(w-2, mouse.y);
      mouse.x = w-2;
      prevMouse.x = w-2;
    }
        
    if (mouse.x > w-2 && (mouse.x - prevMouse.x) > 0){
      robot.mouseMove(2, mouse.y);
      mouse.x = 2;
      prevMouse.x = 2;
    }
    
    if (mouse.y < 1 && (mouse.y - prevMouse.y) < 0){
      robot.mouseMove(mouse.x, h-2);
      mouse.y = h-2;
      prevMouse.y = h-2;
    }
    
    if (mouse.y > h-1 && (mouse.y - prevMouse.y) > 0){
      robot.mouseMove(mouse.x, 2);
      mouse.y = 2;
      prevMouse.y = 2;
    }
    
    pan += PApplet.map(mouse.x - prevMouse.x, 0, applet.width, 0, PConstants.TWO_PI) * sensitivity;
    tilt += PApplet.map(mouse.y - prevMouse.y, 0, applet.height, 0, PConstants.PI) * sensitivity;
    tilt = clamp(tilt, -PConstants.PI/2.01f, PConstants.PI/2.01f);
    
    if (tilt == PConstants.PI/2) tilt += 0.001f;

    forward = new PVector(PApplet.cos(pan), PApplet.tan(tilt), PApplet.sin(pan));
    forward.normalize();
    right = new PVector(PApplet.cos(pan - PConstants.PI/2), 0, PApplet.sin(pan - PConstants.PI/2));
    
    prevMouse = new Point(mouse.x, mouse.y);
    
    if (keys.containsKey('a') && keys.get('a')) velocity.add(PVector.mult(right, speed));
    if (keys.containsKey('d') && keys.get('d')) velocity.sub(PVector.mult(right, speed));
    if (keys.containsKey('w') && keys.get('w')) velocity.add(PVector.mult(forward, speed));
    if (keys.containsKey('s') && keys.get('s')) velocity.sub(PVector.mult(forward, speed));
    if (keys.containsKey('q') && keys.get('q')) velocity.add(PVector.mult(up, speed));
    if (keys.containsKey('e') && keys.get('e')) velocity.sub(PVector.mult(up, speed));

    velocity.mult(friction);
    position.add(velocity);
    center = PVector.add(position, forward);
    applet.camera(position.x, position.y, position.z, center.x, center.y, center.z, up.x, up.y, up.z);
  }
  
  public void keyEvent(KeyEvent event){
    char key = event.getKey();
    
    switch (event.getAction()){
      case KeyEvent.PRESS: 
        keys.put(Character.toLowerCase(key), true);
        break;
      case KeyEvent.RELEASE:
        keys.put(Character.toLowerCase(key), false);
        break;
    }
  }
  
  private float clamp(float x, float min, float max){
    if (x > max) return max;
    if (x < min) return min;
    return x;
  }
  
  public PVector getForward(){
    return forward;
  }
  
  public PVector getUp(){
    return up;
  }
  
  public PVector getRight(){
    return right;
  }
  
  public PVector getPos(){
    return position;
  }
  
  public void setSensitivity(float s)
  {
    sensitivity = s;
  }
  
  public void beginHUD()
  {
   g.pushMatrix();
   g.hint(DISABLE_DEPTH_TEST);
   g.resetMatrix();
   g.applyMatrix(originalMatrix);
  }
  
  public void endHUD()
  {
    g.hint(ENABLE_DEPTH_TEST);
    g.popMatrix();
  }
}