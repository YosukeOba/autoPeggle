import java.awt.PointerInfo;
import java.awt.MouseInfo;
import java.awt.event.InputEvent;
import java.awt.*;
import java.awt.Robot.*;

Robot robot;
Color c;

Boolean [] pegs = new Boolean [96];

int [] pegsCoordinateX = {208, 190, 208, 190, 208, 190, 208, 186};
int [] pegsCoordinateY = {247, 283, 319, 355, 391, 427, 463, 498};

int [] trial = new int [5];

int [] bestTrial = new int [10];

int ball = 0;
int trials = 0;

Boolean start = true;

Boolean end = false;

int lastStartTime = 0;
int waitTime = 30000;

//input the X coordinate of Peggle window's left-upper.
int windowX = 1112;
int windowY = 4;

void setup() {
  
  delay(3000);

  size(600, 1000);

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

  //println(sx + "," + sy);
  //println(robot.getPixelColor(1562, 291).getBlue());

  fill(0);

  for (int i = 0; i < pegsCoordinateY.length; i++) {
    for (int j = 0; j < 12; j++) {
      c = robot.getPixelColor(windowX+pegsCoordinateX[i]+36*j, windowY+pegsCoordinateY[i]);
      if (c.getRed() > 220 && c.getBlue() < 200) {
            fill(255,0,0);
          } else if (c.getBlue() > 220 && c.getRed() < 200){
            fill(0,0,255);
          } else {
            fill(0);
          }
      text(c.getRed() + ",\n" + c.getBlue(), 0 + 30 * j, 40 * i + 30);
    }
  }
  
  fill(0);

  text("start="+str(start), 50, 380);

  text("ball="+str(ball), 50, 410);

  text("trials="+str(trials), 50, 440);

  text("lastST="+str(lastStartTime), 50, 470);

  text("millis="+millis(), 50, 500);

  for (int i = 0; i < trial.length; i++) {
    text("trial["+i+"]="+str(trial[i]), 380, 30*i+30);
  }

  for (int i = 0; i < bestTrial.length; i++) {
    text("bestTrial["+i+"]="+str(bestTrial[i]), 450, 30*i+30);
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

    println("check");
    start = false;
  } else {

    if (millis()-lastStartTime > waitTime*ball + waitTime) {
      //if(end == true){
      //  end = false;

      for (int i = 0; i < pegs.length; i++) {
        pegs[i] = true;
      }

      for (int i = 0; i < pegsCoordinateY.length; i++) {
        for (int j = 0; j < 12; j++) {
          c = robot.getPixelColor(windowX+pegsCoordinateX[i]+36*j, windowY+pegsCoordinateY[i]);

          if (c.getRed() > 220 && c.getBlue() < 200) {
            pegs[i*12+j] = false;
            fill(255,0,0);
          } else if (c.getBlue() > 220 && c.getRed() < 200){
            pegs[i*12+j] = false;
            fill(0,0,255);
          } else {
            pegs[i*12+j] = true;
            fill(0);
          }
          text(c.getRed() + ",\n" + c.getBlue(), 0 + 30 * j, 40 * i + 30);
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
        if (ball >= 10) {
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
