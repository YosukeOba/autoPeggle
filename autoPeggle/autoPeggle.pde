import java.awt.PointerInfo;
import java.awt.MouseInfo;
import java.awt.event.InputEvent;
import java.awt.*;
import java.awt.Robot.*;

Robot robot;
Color c;

Boolean [] pegs = new Boolean [25];

int [] pegsCoordinateY = {540, 528, 515, 501, 487, 474, 460, 445, 433, 421, 403, 391, 377, 364, 352, 333, 320, 306, 294, 278, 265, 254, 238, 224, 213};

int [] trial = new int [2];

int [] bestTrial = new int [10];

int ball = 0;
int trials = 0;

Boolean start = true;

Boolean end = false;

int lastStartTime = 0;
int waitTime = 30000;

//input the X coordinate of Peggle window's left-upper.
int windowX = 1118;

void setup() {

  size(400, 1000);

  try {
    robot = new Robot();
  } 
  catch(AWTException e) {
    e.printStackTrace();
  }

  c = new Color(0, 0, 0);

  for (int i = 0; i < pegs.length; i++) {
    pegs[i] = false;
  }

  for (int i = 0; i < trial.length; i++) {
    trial[i] = 0;
  }

  for (int i = 0; i < bestTrial.length; i++) {
    bestTrial[i] = 0;
  }
}

void draw() {
  background(255);

  PointerInfo pi = MouseInfo.getPointerInfo();

  int sx = (int)pi.getLocation().getX();
  int sy = (int)pi.getLocation().getY();

  println(sx + "," + sy);
  println(robot.getPixelColor(1562, 291).getBlue());

  fill(0);

  for (int i = 0; i < pegsCoordinateY.length; i++) {
    c = robot.getPixelColor(windowX+779, pegsCoordinateY[i]);
    text(c.getRed(), 0, 30 * i + 30);
  }

  text("start="+str(start), 50, 30);

  text("ball="+str(ball), 50, 60);

  text("trials="+str(trials), 50, 90);

  text("lastST="+str(lastStartTime), 50, 120);

  text("millis="+millis(), 50, 150);

  for (int i = 0; i < trial.length; i++) {
    text("trial["+i+"]="+str(trial[i]), 150, 30*i+30);
  }

  for (int i = 0; i < bestTrial.length; i++) {
    text("bestTrial["+i+"]="+str(bestTrial[i]), 230, 30*i+30);
  }


  if (start) {

    lastStartTime = millis();

    delay(1000);

    for (int i = 0; i < ball; i++) {

      robot.keyPress(UP);
      delay(5000);
      robot.keyRelease(UP);
      delay(100);

      robot.keyPress(DOWN);
      delay((4000/(trial.length-1))*bestTrial[i]);
      robot.keyRelease(DOWN);
      delay(100);

      robot.keyPress(ENTER);
      delay(100);
      robot.keyRelease(ENTER);
      delay(100);
      
      //robot.keyPress(UP);
      //delay(5000);
      //robot.keyRelease(UP);
      //delay(100);

      //while(end==false){
      //  if(robot.getPixelColor(1562, 291).getBlue() > 100){
      //    end = true;
      //  }
      //}
      //end = false;
      
      delay(waitTime);
    }

    robot.keyPress(UP);
    delay(5000);
    robot.keyRelease(UP);
    delay(100);

    robot.keyPress(DOWN);
    delay((4000/(trial.length-1))*trials);
    robot.keyRelease(DOWN);
    delay(100);

    robot.keyPress(ENTER);
    delay(100);
    robot.keyRelease(ENTER);
    
    //robot.keyPress(UP);
    //  delay(5000);
    //  robot.keyRelease(UP);
    //  delay(100);
      
     //while(end==false){
     //   if(robot.getPixelColor(1562, 291).getBlue() > 100){
     //     end = true;
     //   }
     // }

    start = false;
  } else {

    if (millis()-lastStartTime > waitTime*ball + waitTime) {
      //if(end == true){
      //  end = false;

      for (int i = 0; i < pegs.length; i++) {
        pegs[i] = false;
      }

      for (int i = 0; i < pegsCoordinateY.length; i++) {
        c = robot.getPixelColor(windowX+779, pegsCoordinateY[i]);
        text(c.getRed(), 0, 30 * i + 30);
        if (c.getRed() > 200) {
          pegs[i] = true;
        }
      }

      int count = 0;

      for (int i = 0; i < pegs.length; i++) {
        if (pegs[i] == true) {
          count++;
        }
      }

      trial[trials] = count;

      trials++;

      int max = 0;
      int maxTrial = 0;

      if (trials >= trial.length) {
        for (int i = 0; i < trial.length; i++) {
          if (max < trial[i]) {
            max = trial[i];
            maxTrial = i;
          }
          trial[i] = 0;
        }

        bestTrial[ball] = maxTrial;
        ball++;
        if(ball >= 10){
          exit();
        }
        trials=0;
      }

      restartLevel();

      start = true;
    }
  }
}

void restartLevel() {
  robot.mouseMove(1156, 591);
  delay(100);
  robot.mousePress(InputEvent.BUTTON1_MASK);
  delay(100);
  robot.mouseRelease(InputEvent.BUTTON1_MASK);
  delay(100);
  robot.mouseMove(1615, 441);
  delay(100);
  robot.mousePress(InputEvent.BUTTON1_MASK);
  delay(100);
  robot.mouseRelease(InputEvent.BUTTON1_MASK);
  delay(100);
  robot.mouseMove(1440, 446);
  delay(100);
  robot.mousePress(InputEvent.BUTTON1_MASK);
  delay(100);
  robot.mouseRelease(InputEvent.BUTTON1_MASK);
}
