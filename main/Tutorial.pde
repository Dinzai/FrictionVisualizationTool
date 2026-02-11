import java.util.ArrayDeque; //used for tracking states for reversal


class TutorialState //only things that are neccesary for keeping trakc of the state of the tutorial
{

  TutorialState(Box b, float v, float t, boolean m, boolean s)
  {
    boxX = b.shape.get(0).x;
    boxY = b.shape.get(0).y;

    velocity = v;
    timer = t;

    canMove = m;
    canShowSecondText = s;
  }

  float boxX;
  float boxY;
  float velocity;
  float timer;

  boolean canMove;
  boolean canShowSecondText;
}




class Tutorial implements Drawable, Interactable
{

  Tutorial()
  {
    Add();
  }

  void Add()
  {
    windowBox = new Box();
    windowBox.MakeBox(650, 480);
    windowBox.SetColour(135, 135, 135);
    windowBox.Translate(80, 40);

    demenstrationBox = new Box();
    demenstrationBox.MakeBox(30, 30);
    demenstrationBox.SetColour(255, 100, 100);
    demenstrationBox.Translate(200, 435);

    demenstrationBoxTwo = new Box();
    demenstrationBoxTwo.MakeBox(30, 30);
    demenstrationBoxTwo.SetColour(100, 100, 255);
    demenstrationBoxTwo.Translate(300, 465);

    demenstrationBoxThree = new Box();
    demenstrationBoxThree.MakeBox(30, 30);
    demenstrationBoxThree.SetColour(100, 255, 100);
    demenstrationBoxThree.Translate(210, 260);

    demenstrationBoxFour = new Box();
    demenstrationBoxFour.MakeBox(30, 30);
    demenstrationBoxFour.SetColour(255, 100, 100);
    demenstrationBoxFour.Translate(525, 260);

    demenstrationBoxFive = new Box();
    demenstrationBoxFive.MakeBox(30, 30);
    demenstrationBoxFive.SetColour(100, 100, 255);
    demenstrationBoxFive.Translate(300, 450);

    demenstrationBoxFloor = new Box();
    demenstrationBoxFloor.MakeBox(560, 30);
    demenstrationBoxFloor.SetColour(100, 255, 100);
    demenstrationBoxFloor.Translate(100, 480);

    nextTextButton = new Button("Next");
    nextTextButton.SetSize(21);
    nextTextButton.SetTextOffsetCheck(30);
    nextTextButton.SetPosition(750, 580);
    nextTextButton.SetOriginalColour(0, 0, 0);

    reverseTextButton = new Button("Previous");
    reverseTextButton.SetSize(21);
    reverseTextButton.SetTextOffsetCheck(70);
    reverseTextButton.SetPosition(20, 580);
    reverseTextButton.SetOriginalColour(0, 0, 0);

    backTextButton = new Button("Back");
    backTextButton.SetSize(21);
    backTextButton.SetTextOffsetCheck(30);
    backTextButton.SetPosition(750, 20);
    backTextButton.SetOriginalColour(0, 0, 0);

    forceButton = new Button();
    forceButton.SetSize(60, 20);
    forceButton.SetPosition(200, 350);
    forceButton.SetOriginalColour(110, 110, 110);

    //wind mill part

    windBladeUp = new Box();
    windBladeUp.MakeRotBox(20, 150);
    windBladeUp.SetColour(180, 180, 220);
    windBladeUp.Translate(windmillPositionX, windmillPositionY);

    windBladeRight = new Box();
    windBladeRight.MakeRotBox(150, 20);
    windBladeRight.SetColour(180, 180, 220);
    windBladeRight.Translate(windmillPositionX, windmillPositionY);

    windBladeDown = new Box();
    windBladeDown.MakeRotBox(20, 150);
    windBladeDown.SetColour(180, 180, 220);
    windBladeDown.Rotate(40);
    windBladeDown.Translate(windmillPositionX, windmillPositionY);

    windBladeLeft = new Box();
    windBladeLeft.MakeRotBox(150, 20);
    windBladeLeft.SetColour(180, 180, 220);
    windBladeLeft.Rotate(45);
    windBladeLeft.Translate(windmillPositionX, windmillPositionY);

    windMillTower = new Box();
    windMillTower.MakeBox(40, 100);
    windMillTower.SetColour(190, 150, 130);
    windMillTower.Translate(windmillPositionX - 20, windmillPositionY);

    windButton = new Button();
    windButton.SetSize(60, 20);
    windButton.SetPosition(200, 350);
    windButton.SetOriginalColour(110, 110, 110);
  }

  void SaveState()
  {

    if (history.size() > 300)
    {
      history.removeFirst();
    }

    history.addLast(new TutorialState(demenstrationBox, realVelocity, resetTimer, true, false));
  }

  void ReverseStep()
  {
    if (history.isEmpty()) return;

    TutorialState s = history.removeLast();

    canMove = s.canMove;
    canShowSecondText = s.canShowSecondText;
    velocity = s.velocity;
    timer = s.timer;

    float curX = demenstrationBox.shape.get(0).x;
    float curY = demenstrationBox.shape.get(0).y;

    float dx = s.boxX - curX;
    float dy = s.boxY - curY;

    demenstrationBox.Translate(dx, dy);
  }

  void drawArrow(float x1, float y1, float x2, float y2)
  {
    // Draw main line
    line(x1, y1, x2, y2);

    // Arrow head size
    float arrowSize = 10;

    // Direction angle
    float angle = atan2(y2 - y1, x2 - x1);

    // Arrow head points
    float x3 = x2 - arrowSize * cos(angle - PI/6);
    float y3 = y2 - arrowSize * sin(angle - PI/6);

    float x4 = x2 - arrowSize * cos(angle + PI/6);
    float y4 = y2 - arrowSize * sin(angle + PI/6);

    // Draw arrow head
    line(x2, y2, x3, y3);
    line(x2, y2, x4, y4);
  }


  void Click()
  {

    if (windButton.b.canClick)
    {
      windForce += 200 * deltaTime;
    }

    if (forceButton.b.canClick)
    {
      boxFiveForce += 57.5;
    }

    if (nextTextButton.textSystem.canClick)
    {
      stateStepCounter++;
      canMove = true;
    }

    if (reverseTextButton.textSystem.canClick)
    {
      stateStepCounter--;
      canReverse = true;
    } else
    {
      canReverse = false;
    }

    if (backTextButton.textSystem.canClick)
    {
      sim.tScreen.isTitle = true;
      sim.tScreen.isTut = false;
    }
  }

  void Reset()
  {
    if (backTextButton.textSystem.canClick)
    {
      backTextButton.textSystem.canClick = false;
    }
  }

  void Update()
  {
    //wind
    if (stateStepCounter == 4)
    {
      windTimer += deltaTime;
      windTimerCountDown -= deltaTime;
      if (windTimerCountDown <= 0)
      {
        windTimerCountDown = 4;
      }
      if (windTimer >= 4)
      {
        showSecond = true;
      }
      if (windTimer >= 8)
      {
        showSecond = false;
        showThird = true;
      }
      if (windTimer >= 12)
      {
        canSeeWindMill = true;
        showThird = false;
      }

      windMillSpeed = windForce;

      if (windMillSpeed >= 5)
      {
        canMoveWindmill = true;
      }

      if (canMoveWindmill)
      {
        if (windForce > 0)
        {
          windForce -= 10 * deltaTime;
          canMoveWindmill = false;
        }

        windBladeUp.Rotate(windMillSpeed * deltaTime);
        windBladeRight.Rotate(windMillSpeed * deltaTime);
        windBladeDown.Rotate(windMillSpeed * deltaTime);
        windBladeLeft.Rotate(windMillSpeed * deltaTime);
      }
    }
    //user friction
    if (stateStepCounter == 3)
    {
      if (!boxFiveCanMove)
      {
        boxFiveSpeed = boxFiveForce;
      }
      if (boxFiveForce >= 30)
      {
        boxFiveCanMove = true;
      }
      if (boxFiveCanMove)
      {
        if (demenstrationBoxFive.posX < 630)
        {
          if (boxFiveSpeed > 2)
          {
            boxFiveSpeed -= 5 * deltaTime;
            demenstrationBoxFive.Translate(boxFiveSpeed * deltaTime, 0);
          } else
          {
            boxFiveForce = 0;
            boxFiveSpeed = 0;
          }
        }
      }
    }

    //static kinetic explanation
    if (stateStepCounter == 2)
    {
      timer += deltaTime;
      if (timer >= 5)
      {
        direction *= -1;
        timer = 0;
      }
      if (boxThreeSpeed > 0)
      {
        boxThreeSpeed -= 7 * deltaTime;
        demenstrationBoxThree.Translate(boxThreeSpeed * direction * deltaTime, 0);
      }

      if (!boxFourCanMove)
      {
        force += 10 * deltaTime;
        boxFourSpeed = force;
        if (force >= 30)
        {
          boxFourCanMove = true;
        }
      } else if (boxFourCanMove)
      {
        boxFourSpeed -= 5 * deltaTime;
        if (boxFourSpeed > 2)
        {
          demenstrationBoxFour.Translate(boxFourSpeed * deltaTime, 0);
        } else if (boxFourSpeed <= 1.5)
        {
          boxFourSpeed = 0;
        }
      }
    }

    demenstrationBox.UpdateBounds();
    demenstrationBox.CalculateNormals();

    demenstrationBoxTwo.UpdateBounds();
    demenstrationBoxTwo.CalculateNormals();

    if (canReverse)
    {

      amount = 34;
      phraseLocationX = 300;
      phrase = "What is Friction?";
      ReverseStep();
      return;
    }

    if (timer >= 3)
    {
      amount = 21;
      phraseLocationX = 200;
      phrase = "Friction slows Down objects that touch! ";
      canShowSecondText = true;
      canMove = false;
    }

    if (canMove)
    {
      SaveState();

      timer+= deltaTime;
      if (velocity > 0)
      {
        velocity -= frictionAmount * deltaTime;
        demenstrationBox.Translate(velocity * deltaTime, 0);
      }
    }

    if (demenstrationBox.Collision(demenstrationBoxTwo))
    {
      demenstrationBox.Resolution(demenstrationBoxTwo);
    }
  }

  void DrawToScreen()
  {

    windowBox.Draw();

    if (stateStepCounter == 4)
    {
      if (!canSeeWindMill)
      {
        pushMatrix();
        fill(0, 0, 0);
        textSize(windTextSize);
        text("Word Timer: " + (int)windTimerCountDown, 100, 100);
        if (!showSecond && !showThird)
        {
          text(windMillText, 300, 200);
        }
        if (showSecond)
        {
          text(windMillTextTwo, 300, 200);
        }
        if (showThird)
        {
          text(windMillTextThree, 200, 200);
        }
        popMatrix();
      }

      if (canSeeWindMill)
      {
        pushMatrix();
        fill(0, 0, 0);
        textSize(windTextSize);
        text("Wind Force: " + (int)windForce, 100, 100);
        popMatrix();

        pushMatrix();
        fill(0, 0, 0);
        textSize(windTextSize);
        text("Now its your turn! ", 100, 200);
        popMatrix();

        pushMatrix();
        fill(0, 0, 0);
        textSize(windTextSize);
        text("Tap the button to add wind! ", 100, 300);
        popMatrix();

        pushMatrix();
        stroke(0);
        strokeWeight(5);
        windMillTower.Draw();
        popMatrix();
        pushMatrix();
        noStroke();
        windBladeUp.Draw();
        windBladeRight.Draw();
        windBladeDown.Draw();
        windBladeLeft.Draw();
        popMatrix();
        windButton.Draw();

        drawArrow(windMillTower.posX + 50, windMillTower.posY + 15, windMillTower.posX + 30, windMillTower.posY + 15);
        drawArrow(windMillTower.posX - 30, windMillTower.posY + 15, windMillTower.posX, windMillTower.posY + 15);
      }
    }


    if (stateStepCounter == 3)
    {

      demenstrationBoxFive.Draw();
      demenstrationBoxFloor.Draw();
      forceButton.Draw();

      //box five
      pushMatrix();
      fill(0, 0, 0);
      textSize(frictionTypesTextSizeSmall);
      text("kf = 30", demenstrationBoxFive.posX + 45, demenstrationBoxFive.posY + 10);
      text("force = " + (int)boxFiveSpeed + " ", demenstrationBoxFive.posX - 90, demenstrationBoxFive.posY + 10);
      popMatrix();

      drawArrow(demenstrationBoxFive.posX + 50, demenstrationBoxFive.posY + 15, demenstrationBoxFive.posX + 30, demenstrationBoxFive.posY + 15);
      drawArrow(demenstrationBoxFive.posX - 30, demenstrationBoxFive.posY + 15, demenstrationBoxFive.posX, demenstrationBoxFive.posY + 15);

      pushMatrix();
      fill(0, 0, 0);
      textSize(frictionTypesTextSizeSmall);
      text(phraseThree, fPhraseLocationX - 100, fPhraseLocationY);
      popMatrix();

      pushMatrix();
      fill(0, 0, 0);
      textSize(frictionTypesTextSizeSmall);
      text(phraseFour, fPhraseLocationX - 100, fPhraseLocationY + 100);
      popMatrix();
    }

    if (stateStepCounter == 2)
    {
      demenstrationBoxThree.Draw();
      demenstrationBoxFour.Draw();

      //box three
      pushMatrix();
      fill(0, 0, 0);
      textSize(frictionTypesTextSizeSmall);
      text("kf = 30", demenstrationBoxThree.posX + 45, demenstrationBoxThree.posY + 10);
      text("force = " + (int)boxThreeSpeed + " ", demenstrationBoxThree.posX - 90, demenstrationBoxThree.posY + 10);
      popMatrix();

      drawArrow(demenstrationBoxThree.posX + 50, demenstrationBoxThree.posY + 15, demenstrationBoxThree.posX + 30, demenstrationBoxThree.posY + 15);
      drawArrow(demenstrationBoxThree.posX - 30, demenstrationBoxThree.posY + 15, demenstrationBoxThree.posX, demenstrationBoxThree.posY + 15);

      //box four
      pushMatrix();
      fill(0, 0, 0);
      textSize(frictionTypesTextSizeSmall);
      if (!boxFourCanMove)
      {
        text("sf = 30", demenstrationBoxFour.posX + 45, demenstrationBoxFour.posY + 10);
      } else
      {
        text("kf = 20", demenstrationBoxFour.posX + 45, demenstrationBoxFour.posY + 10);
        text("After overcomming Static Friction", 300, 320);
        text("Kinetic Friction takes over! ", 300, 420);
      }
      text("force = " + (int)boxFourSpeed + " ", demenstrationBoxFour.posX - 90, demenstrationBoxFour.posY + 10);
      popMatrix();

      drawArrow(demenstrationBoxFour.posX + 50, demenstrationBoxFour.posY + 15, demenstrationBoxFour.posX + 30, demenstrationBoxFour.posY + 15);
      drawArrow(demenstrationBoxFour.posX - 30, demenstrationBoxFour.posY + 15, demenstrationBoxFour.posX, demenstrationBoxFour.posY + 15);

      pushMatrix();
      fill(0, 0, 0);
      textSize(frictionTypesTextSize);
      text(frictionTypes, fPhraseLocationX, fPhraseLocationY);
      text(kineticFrictionPhrase, fPhraseLocationX - 50, fPhraseLocationY + 50);
      text(staticFrictionPhrase, fPhraseLocationX + 250, fPhraseLocationY + 50);
      popMatrix();
    }

    if (stateStepCounter < 2)
    {
      pushMatrix();
      fill(0, 0, 0);
      textSize(amount);
      text(phrase, phraseLocationX, phraseLocationY);
      if (canShowSecondText)
      {
        text(phraseTwo, phraseLocationTwoX, phraseLocationTwoY);
      }
      popMatrix();

      pushMatrix();
      fill(0, 0, 0);
      textSize(frictionTypesTextSizeSmall);
      text("f", demenstrationBox.posX + 45, demenstrationBox.posY + 10);
      popMatrix();

      drawArrow(demenstrationBox.posX + 50, demenstrationBox.posY + 15, demenstrationBox.posX + 30, demenstrationBox.posY + 15);
      demenstrationBox.Draw();
      demenstrationBoxTwo.Draw();
      demenstrationBoxFloor.Draw();
    }
    nextTextButton.Draw();
    reverseTextButton.Draw();
    backTextButton.Draw();
  }
  //part one
  Box windowBox;

  Box demenstrationBox;
  Box demenstrationBoxTwo;

  Box demenstrationBoxThree;
  Box demenstrationBoxFour;

  Box demenstrationBoxFive;

  Box demenstrationBoxFloor;

  Button nextTextButton;
  Button reverseTextButton;

  Button backTextButton;


  Button forceButton;

  int amount = 34;

  float timer = 0;

  float resetTimer = 0;

  float velocity = 30;
  float realVelocity = 30;
  float frictionAmount = 10;

  float boxThreeSpeed = 50;
  float boxFourSpeed = 0;

  float boxFiveSpeed = 0;
  float boxFiveForce = 0;

  int direction = 1;

  String phrase = "What is Friction?";
  String phraseTwo = "The block stopped from the ground's friction!";

  int frictionTypesTextSize = 34;
  int frictionTypesTextSizeSmall = 21;
  float fPhraseLocationX = 250;
  float fPhraseLocationY = 200;
  String frictionTypes = "Two Types of Friction! ";

  String kineticFrictionPhrase = "Kinetic!";
  String staticFrictionPhrase = "Static!";

  String phraseThree = "Now it's Your Turn!";
  String phraseFour = "Click the button bellow to add a force!";

  int stateStepCounter = 0;

  float phraseLocationX = 300;
  float phraseLocationY = 200;
  float phraseLocationTwoX = 200;
  float phraseLocationTwoY = 250;

  boolean canMove = false;
  boolean canShowSecondText = false;
  boolean canReverse = false;

  boolean boxFourCanMove = false;
  boolean boxFiveCanMove = false;

  float force = 0;

  ArrayDeque<TutorialState> history = new ArrayDeque<>();
  //part two Drag

  int windTextSize = 21;
  String windMillText = "Friction also works in the air!";
  String windMillTextTwo = "This is called Drag!";
  String windMillTextThree = "Think about fans slowing down when they turn off!";

  boolean canSeeWindMill = false;
  boolean canMoveWindmill = false;

  boolean showSecond = false;
  boolean showThird = false;

  float windTimer = 0;
  float windTimerCountDown = 4;
  float windTimerMax = 4;

  float windForce = 0;
  float windMillSpeed = 0;

  Button windButton;

  float windmillPositionX = 420;
  float windmillPositionY = 250;

  Box windBladeUp;
  Box windBladeRight;
  Box windBladeDown;
  Box windBladeLeft;
  Box windMillTower;
}
