import java.awt.PointerInfo;
import java.awt.MouseInfo;
import java.awt.*;
import java.awt.Robot.*;

Robot robot;
Color c;

Boolean [] pegs = new Boolean [25];

int [] pegsCoordinateY = {540,528,515,501,487,474,460,445,433,421,403,391,377,364,352,333,320,306,294,278,265,254,238,224,213};

int [][] trial = new int [10][5];

Boolean start = true;

void setup(){
  
  size(300,1000);
  
  try {
    robot = new Robot();
  } catch(AWTException e){
    e.printStackTrace();
  }
  
  c = new Color(0,0,0);
  
  for(int i = 0; i < pegs.length; i++){
    pegs[i] = false;
  }
  
  for(int i = 0; i < trial.length; i++){
    for(int j = 0; j < trial[i].length; j++){
      trial[i][j] = 0;
    }
  }
}

void draw(){
  background(255);
  
  PointerInfo pi = MouseInfo.getPointerInfo();
  
  int sx = (int)pi.getLocation().getX();
  int sy = (int)pi.getLocation().getY();
  
  
  fill(0);
  
  
  if(start){
    
    delay(1000);
    
    robot.keyPress(UP);
    delay(5000);
    robot.keyRelease(UP);
    delay(100);
    
    robot.keyPress(ENTER);
    delay(100);
    robot.keyRelease(ENTER);
    
  } else {
    for(int i = 0; i < pegsCoordinateY.length; i++){
      c = robot.getPixelColor(1897,pegsCoordinateY[i]);
      text(c.getRed(),0, 30 * i);
      if(c.getRed() > 200){
        pegs[i] = true;
      }
    }
  }
  
}
