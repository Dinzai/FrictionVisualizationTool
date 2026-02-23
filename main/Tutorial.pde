import java.util.ArrayDeque; //used for tracking states for reversal
//this section helps hold the useable information for a rewind

class TutorialState
{
  TutorialState(Box b, float v, float t, boolean m, boolean s,
    float b3, float b4, float f, boolean b4m, int d)
  {
    boxX = b.shape.get(0).x;
    boxY = b.shape.get(0).y;

    velocity = v;
    timer = t;

    canMove = m;
    canShowSecondText = s;

    boxThreeSpeed = b3;
    boxFourSpeed = b4;
    force = f;
    boxFourCanMove = b4m;
    direction = d;
  }

  float boxX, boxY;
  float velocity, timer;

  boolean canMove;
  boolean canShowSecondText;

  // Step 2 data
  float boxThreeSpeed;
  float boxFourSpeed;
  float force;
  boolean boxFourCanMove;
  int direction;
}


//This object is it's own scene


class Tutorial implements Drawable, Interactable
{

  Tutorial()
  {
    frictionImage = cache.GetTexture(6);
    airImage = cache.GetTexture(7);
    dragImage = cache.GetTexture(8);

    Add();
  }

  void Add()
  {
    
    
    windowBox = new Box();
    windowBox.MakeBox(650, 480);
    windowBox.SetColour(105, 102, 82);
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
    //demenstrationBoxThree.Translate(210, 260);

    demenstrationBoxFour = new Box();
    demenstrationBoxFour.MakeBox(30, 30);
    demenstrationBoxFour.SetColour(255, 100, 100);
    //demenstrationBoxFour.Translate(525, 260);

    demenstrationBoxFive = new Box();
    demenstrationBoxFive.MakeBox(30, 30);
    demenstrationBoxFive.SetColour(100, 100, 255);
    //demenstrationBoxFive.Translate(300, 450);

    demenstrationBoxFloor = new Box();
    demenstrationBoxFloor.MakeBox(560, 30);
    demenstrationBoxFloor.SetColour(100, 255, 100);
    demenstrationBoxFloor.Translate(100, 480);

    nextTextButton = new Button("Next");
    nextTextButton.SetSize(21);
    nextTextButton.SetTextOffsetCheck(30);
    nextTextButton.SetPosition(740, 575);
    nextTextButton.SetOriginalColour(0, 0, 0);

    reverseTextButton = new Button("Previous");
    reverseTextButton.SetSize(21);
    reverseTextButton.SetTextOffsetCheck(70);
    reverseTextButton.SetPosition(20, 575);
    reverseTextButton.SetOriginalColour(0, 0, 0);

    backTextButton = new Button("Back");
    backTextButton.SetSize(21);
    backTextButton.SetTextOffsetCheck(30);
    backTextButton.SetPosition(740, 25);
    backTextButton.SetOriginalColour(0, 0, 0);

    forceButton = new Button();
    forceButton.SetSize(60, 20);
    forceButton.SetPosition(330, 340);
    forceButton.SetOriginalColour(150, 138, 62);

    boxFiveResetButton = new Button();
    boxFiveResetButton.SetSize(60, 20);
    boxFiveResetButton.SetPosition(500, 340);
    boxFiveResetButton.SetOriginalColour(150, 138, 62);

    sliderRail = new Box();
    sliderRail.MakeBox(80, 10);
    sliderRail.SetColour(68, 62, 107);;
    sliderRail.Translate(200, 230);

    sliderButton = new Button();
    sliderButton.SetSize(10, 10);
    sliderButton.SetOriginalColour(150, 138, 62);
    sliderButton.SetPosition(200, 230);

    frictionSliderRail = new Box();
    frictionSliderRail.MakeBox(80, 10);
    frictionSliderRail.SetColour(68, 62, 107);;
    frictionSliderRail.Translate(500, 230);

    frictionSliderButton = new Button();
    frictionSliderButton.SetSize(10, 10);
    frictionSliderButton.SetOriginalColour(150, 138, 62);
    frictionSliderButton.SetPosition(500, 230);



    //wind mill part

    rotBox = new Box();
    rotBox.MakeRotBox(128, 128);
    rotBox.SetColour(180, 180, 220);
    rotBox.Translate(420, 300);
    rotBox.SetType(M_TYPE.FAN);
    
    mainBlade = new Box();
    mainBlade.MakeRotBox(128, 128);
    mainBlade.SetColour(180, 180, 220);
    mainBlade.Translate(windmillPositionX, windmillPositionY + 20);
    mainBlade.m.SetTexture(10);
    mainBlade.m.useTexture = true;
    mainBlade.Rotate(30);

    windMillTower = new Box();
    windMillTower.MakeBox(20, 100);
    windMillTower.SetColour(190, 150, 130);
    windMillTower.Translate(windmillPositionX - 10, windmillPositionY);
    windMillTower.m.SetTexture(1);
    windMillTower.m.useTexture = true;

    windButton = new Button();
    windButton.SetSize(60, 20);
    windButton.SetPosition(200, 350);
    windButton.SetOriginalColour(150, 138, 62);
  }
  //chatgpt helped with the save state logic, I knew a queue could handle the logic i needed, but needed direction on how to store that data
  void SaveState()
  {

    if (history.size() > 300)
    {
      history.removeFirst();
    }

    history.addLast(new TutorialState(
      demenstrationBox,
      velocity,
      timer,
      canMove,
      canShowSecondText,

      // Step 2
      boxThreeSpeed,
      boxFourSpeed,
      force,
      boxFourCanMove,
      direction
      ));
  }

  void ReverseStep()
  {
    if (history.isEmpty()) return;

    TutorialState s = history.removeLast();

    // Restore basic
    canMove = s.canMove;
    canShowSecondText = s.canShowSecondText;
    velocity = s.velocity;
    timer = s.timer;

    // Restore step 2
    boxThreeSpeed = s.boxThreeSpeed;
    boxFourSpeed = s.boxFourSpeed;
    force = s.force;
    boxFourCanMove = s.boxFourCanMove;
    direction = s.direction;

    float curX = demenstrationBox.shape.get(0).x;
    float curY = demenstrationBox.shape.get(0).y;

    float dx = s.boxX - curX;
    float dy = s.boxY - curY;

    demenstrationBox.Translate(dx, dy);
  }


  void Click()
  {

    if (windButton.b.canClick)
    {
      theSounds.PlayRandomUI();
      windForce += 200 * deltaTime;
    }

    if (forceButton.b.canClick)
    {
      theSounds.PlayRandomUI();
      boxFiveSpeed = boxFiveForce;


      boxFiveCanMove = true;
    }

    if (boxFiveResetButton.b.canClick)
    {
      theSounds.PlayRandomUI();
      ResetFive();
    }

    if (sliderButton.b.canClick)
    {
      theSounds.PlayRandomUI();
      sliderIsPressed = true;
    }

    if (frictionSliderButton.b.canClick)
    {
      theSounds.PlayRandomUI();
      frictionSliderIsPressed = true;
    }

    if (nextTextButton.textSystem.canClick)
    {
      theSounds.PlayRandomUI();

      if (stateStepCounter == 1)
      {

        ResetBoxLocation();
      }

      if (stateStepCounter == 2 || stateStepCounter == 3)
      {
        ResetFive();
        stateStepCounter = 4;
        return;
      }

      if (stateStepCounter == 5 || stateStepCounter == 6 || stateStepCounter == 7)
      {
        stateStepCounter = 8;
        skip = true;
        canSeeWindMill = true;
        return;
      }

      stateStepCounter++;
      if (stateStepCounter >= 9)
      {

        theSounds.StopAllUI();
        sim.tScreen.isTut = false;

        sim.tScreen.isTitle = true;
        //stateStepCounter = 0;
        //return;
      }

      canMove = true;
    }

    if (reverseTextButton.textSystem.canClick)
    {
      if (stateStepCounter == 0)
      {

        theSounds.StopAllUI();
        sim.tScreen.isTut = false;
        theSounds.PlayMusic(BACKGROUND_MUSIC.TITLE.ordinal());
        sim.tScreen.isTitle = true;

      }
      theSounds.PlayRandomUI();

      if (stateStepCounter == 5)
      {
        ResetFive();
      }

      if (stateStepCounter == 3)
      {
        stateStepCounter = 1;
      }

      if (stateStepCounter == 4)
      {
        ResetBoxLocation();
        stateStepCounter = 2;
      }

      if (stateStepCounter == 8)
      {
        stateStepCounter = 5;
        windTimer = 0;
        windTimerCountDown = 4;
        skip = false;
        canSeeWindMill = false;
        return;
      }

      stateStepCounter--;


      canReverse = true;
    } else
    {
      canReverse = false;
    }

    if (backTextButton.textSystem.canClick)
    {
      theSounds.StopAllUI();
      theSounds.PlayRandomUI();
      theSounds.PlayMusic(BACKGROUND_MUSIC.TITLE.ordinal());
      sim.tScreen.isTut = false;
      sim.tScreen.isTitle = true;
    }
  }

  void Reset()
  {
    if (sliderIsPressed)
    {
      sliderIsPressed = false;
    }

    if (frictionSliderIsPressed)
    {
      frictionSliderIsPressed = false;
    }

    if (backTextButton.textSystem.canClick)
    {
      backTextButton.textSystem.canClick = false;
    }
  }

  void UpdateSlider()
  {
    if (sliderIsPressed)
    {
      float minSlide = sliderRail.posX;
      float maxSlide = sliderRail.posX + sliderRail.theWidth - sliderButton.b.theWidth;
      float newPositionX = mouseX - sliderButton.b.theWidth / 2;
      if (newPositionX < minSlide)
      {

        newPositionX = minSlide;
      }
      if (newPositionX > maxSlide)
      {

        newPositionX = maxSlide;
      }
      if (mouseY > sliderButton.b.shape.get(0).y && mouseY < sliderButton.b.shape.get(0).y + sliderButton.b.theHeight)
      {

        //lock the magnitude based on the size
        float value = (newPositionX - minSlide) / (maxSlide - minSlide);
        boxFiveForce = value * boxFiveMaxForce;
        sliderButton.b.posX = newPositionX;
      }
    }
  }

  void UpdateFrictionSlider()
  {
    if (frictionSliderIsPressed)
    {
      float minSlide = frictionSliderRail.posX;
      float maxSlide = frictionSliderRail.posX + frictionSliderRail.theWidth - frictionSliderButton.b.theWidth;
      float newPositionX = mouseX - frictionSliderButton.b.theWidth / 2;
      if (newPositionX < minSlide)
      {

        newPositionX = minSlide;
      }
      if (newPositionX > maxSlide)
      {

        newPositionX = maxSlide;
      }
      if (mouseY > frictionSliderButton.b.shape.get(0).y && mouseY < frictionSliderButton.b.shape.get(0).y + frictionSliderButton.b.theHeight)
      {

        //lock the magnitude based on the size
        float value = (newPositionX - minSlide) / (maxSlide - minSlide);
        boxFiveStaticFriction = value * boxFiveMaxFriction;
        frictionSliderButton.b.posX = newPositionX;
      }
    }
  }

  void ResetBoxLocation()//state step counter 2 and 3
  {
    demenstrationBoxThree.SetPosition(0, 0);
    demenstrationBoxFour.SetPosition(0, 0);

    demenstrationBoxThree.Translate(220, 300);
    demenstrationBoxFour.Translate(500, 300);
  }

  void ResetFive()
  {
    boxFiveCanMove = false;
    boxFiveResetButton.b.canClick = false;

    imageSpeed = 100;
    fanImageX = 600;
    dragImageX = 100;
    fanSpeed = 300;


    demenstrationBoxFive.SetPosition(0, 0);
    demenstrationBoxFive.Translate(300, 464);
  }

  void Update()
  {
    //print(stateStepCounter);

    //wind
    if (stateStepCounter >= 5 && stateStepCounter < 9)
    {
      if (!canSeeWindMill && !skip)
      {
        fanImageX -= imageSpeed * deltaTime;
        windTimer += deltaTime;
        windTimerCountDown -= deltaTime;
        if (windTimerCountDown <= 0)
        {
          windTimerCountDown = windTimerMax;
        }
        if (windTimer >= 4)
        {
          imageSpeed -= 25 * deltaTime;
          if (imageSpeed > 0)
          {
            dragImageX += imageSpeed * deltaTime;
          }
          stateStepCounter = 6;
          showSecond = true;
        }
        if (windTimer >= 8)
        {
          fanSpeed -= 85 * deltaTime;
          if (fanSpeed > 0)
          {
            rotBox.Rotate(fanSpeed * deltaTime);
          }
          stateStepCounter = 7;
          showSecond = false;
          showThird = true;
        }

        if (windTimer >= 12)
        {
          stateStepCounter++;
          showThird = false;
          canSeeWindMill = true;
        }
      }

      windMillSpeed = windForce;

      if (windMillSpeed >= 1)
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

        mainBlade.Rotate(windMillSpeed * deltaTime);

      }
    }
    //user friction
    if (stateStepCounter == 4)
    {
      UpdateSlider();
      UpdateFrictionSlider();

      if (boxFiveCanMove)
      {
        if (boxFiveForce < boxFiveStaticFriction)
        {
          boxFiveCanMove = false;
          popUpReminder = true;
        } else
        {
          popUpReminder = false;
        }

        boxFiveSpeed -= boxFiveStaticFriction * deltaTime;
        if (boxFiveSpeed <= 0)
        {
          boxFiveSpeed = 0;
        }
        demenstrationBoxFive.Translate(boxFiveSpeed * deltaTime, 0);
      }
    }
    //static kinetic explanation
    if (stateStepCounter <=3 && stateStepCounter > 1)
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
          stateStepCounter++;
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

    if (stateStepCounter >= 5 && stateStepCounter < 9)
    {
      if (!canSeeWindMill)
      {
        pushMatrix();
        fill(0, 0, 0);
        textSize(windTextSize);
        text("Word Timer: " + (int)windTimerCountDown, 100, 100);
        if (!showSecond && !showThird)
        {
          image(airImage, fanImageX, 300, 128, 128);
          text(windMillText, 250, 200);
        }
        if (showSecond)
        {
          image(dragImage, dragImageX, 300, 128, 128);
          text(windMillTextTwo, 250, 200);
        }
        if (showThird)
        {

          pushMatrix();
          noStroke();
          rotBox.Draw();
          popMatrix();
          text(windMillTextThree, 140, 200);
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
        text("Tap the button to add wind! ", 100, 330);
        popMatrix();

        pushMatrix();
        noStroke();
        windMillTower.Draw();
        mainBlade.Draw();
        popMatrix();

        pushMatrix();
        stroke(0);
        strokeWeight(5);
        windButton.Draw();
        popMatrix();

        pushMatrix();
        fill(0, 0, 0);
        textSize(windTextSize);
        text("Drag", windMillTower.posX + 105, windMillTower.posY + 5);
        text("Wind", windMillTower.posX - 110, windMillTower.posY + 5);
        popMatrix();

        drawArrow(windMillTower.posX + 150, windMillTower.posY + 15, windMillTower.posX + 100, windMillTower.posY + 15);
        drawArrow(windMillTower.posX - 105, windMillTower.posY + 15, windMillTower.posX - 55, windMillTower.posY + 15);
      }
    }


    if (stateStepCounter == 4)
    {

      demenstrationBoxFive.Draw();
      demenstrationBoxFloor.Draw();
      forceButton.Draw();
      sliderRail.Draw();
      sliderButton.Draw();
      frictionSliderRail.Draw();
      frictionSliderButton.Draw();
      //box five
      if (!boxFiveCanMove)
      {
        pushMatrix();
        fill(0, 0, 0);
        textSize(frictionTypesTextSizeSmall);
        text("sf = " + (int)boxFiveStaticFriction, demenstrationBoxFive.posX + 45, demenstrationBoxFive.posY + 10);
        text("Force = " + (int)boxFiveForce + " ", demenstrationBoxFive.posX - 145, demenstrationBoxFive.posY + 10);
        popMatrix();
      } else
      {
        pushMatrix();
        fill(0, 0, 0);
        textSize(frictionTypesTextSizeSmall);
        text("kf = " + (int)boxFiveStaticFriction, demenstrationBoxFive.posX + 45, demenstrationBoxFive.posY + 10);
        text("Force = " + (int)boxFiveForce + " ", demenstrationBoxFive.posX - 145, demenstrationBoxFive.posY + 10);
        popMatrix();

        pushMatrix();
        fill(0, 0, 0);
        textSize(frictionTypesTextSizeTiny);
        text("Reset!", boxFiveResetButton.b.posX + 5, boxFiveResetButton.b.posY - 20);
        boxFiveResetButton.Draw();
        popMatrix();
      }

      pushMatrix();
      fill(0, 0, 0);
      textSize(frictionTypesTextSizeTiny);
      text("Friction Slider", frictionSliderRail.posX + 15, frictionSliderRail.posY + 30);
      text("Force Slider", sliderRail.posX + 15, sliderRail.posY + 30);
      popMatrix();

      if (popUpReminder)
      {
        pushMatrix();
        fill(0, 0, 0);
        textSize(frictionTypesTextSizeSmall);
        text("Starting force must be larger than static friction! ", demenstrationBoxFive.posX - 125, demenstrationBoxFive.posY - 50);
        popMatrix();
      }


      drawArrow(demenstrationBoxFive.posX + 50, demenstrationBoxFive.posY + 15, demenstrationBoxFive.posX + 30, demenstrationBoxFive.posY + 15);
      drawArrow(demenstrationBoxFive.posX - 30, demenstrationBoxFive.posY + 15, demenstrationBoxFive.posX, demenstrationBoxFive.posY + 15);

      pushMatrix();
      fill(0, 0, 0);
      textSize(frictionTypesTextSize);
      text(phraseThree, 250, 100);
      popMatrix();

      pushMatrix();
      fill(0, 0, 0);
      textSize(frictionTypesTextSizeSmall);
      text(phraseFive, fPhraseLocationX - 160, fPhraseLocationY);
      popMatrix();

      pushMatrix();
      fill(0, 0, 0);
      textSize(frictionTypesTextSizeTiny);
      text(phraseFour, fPhraseLocationX - 20, fPhraseLocationY + 100);
      popMatrix();
    }

    if (stateStepCounter <= 3 && stateStepCounter > 1)
    {
      demenstrationBoxThree.Draw();
      demenstrationBoxFour.Draw();

      //box three
      pushMatrix();
      fill(0, 0, 0);
      textSize(frictionTypesTextSizeTiny);
      text("kf = 30", demenstrationBoxThree.posX + 45, demenstrationBoxThree.posY + 10);
      text("force = " + (int)boxThreeSpeed + " ", demenstrationBoxThree.posX - 95, demenstrationBoxThree.posY + 10);
      popMatrix();

      drawArrow(demenstrationBoxThree.posX + 50, demenstrationBoxThree.posY + 15, demenstrationBoxThree.posX + 30, demenstrationBoxThree.posY + 15);
      drawArrow(demenstrationBoxThree.posX - 30, demenstrationBoxThree.posY + 15, demenstrationBoxThree.posX, demenstrationBoxThree.posY + 15);

      //box four
      pushMatrix();
      fill(0, 0, 0);
      textSize(frictionTypesTextSizeTiny);
      if (!boxFourCanMove)
      {
        text("sf = 30", demenstrationBoxFour.posX + 45, demenstrationBoxFour.posY + 10);
      } else
      {

        text("kf = 20", demenstrationBoxFour.posX + 45, demenstrationBoxFour.posY + 10);
        text("After overcomming Static Friction", 300, 380);
        text("Kinetic Friction takes over! ", 300, 420);
      }
      text("force = " + (int)boxFourSpeed + " ", demenstrationBoxFour.posX - 87, demenstrationBoxFour.posY + 10);
      popMatrix();

      drawArrow(demenstrationBoxFour.posX + 50, demenstrationBoxFour.posY + 15, demenstrationBoxFour.posX + 30, demenstrationBoxFour.posY + 15);
      drawArrow(demenstrationBoxFour.posX - 30, demenstrationBoxFour.posY + 15, demenstrationBoxFour.posX, demenstrationBoxFour.posY + 15);

      pushMatrix();
      fill(0, 0, 0);
      textSize(frictionTypesTextSize);
      text(frictionTypes, fPhraseLocationX, fPhraseLocationY - 75);
      text(kineticFrictionPhrase, fPhraseLocationX - 50, fPhraseLocationY + 50);
      text(staticFrictionPhrase, fPhraseLocationX + 250, fPhraseLocationY + 50);
      popMatrix();
    }

    if (stateStepCounter < 2)
    {
      image(frictionImage, 500, 420, 64, 64);
      pushMatrix();
      fill(0, 0, 0);
      textSize(amount);
      text(phrase, phraseLocationX - 25, phraseLocationY - 100);
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

  Box sliderRail;
  Button sliderButton;

  Box frictionSliderRail;
  Button frictionSliderButton;

  Button boxFiveResetButton;

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
  float velocity = 30;

  float frictionAmount = 10;

  float boxThreeSpeed = 50;
  float boxFourSpeed = 0;

  float boxFiveSpeed = 0;
  float boxFiveForce = 0;
  float boxFiveMaxForce = 1000;
  float boxFiveMaxFriction = 900;
  float boxFiveStaticFriction;

  boolean popUpReminder = false;
  boolean skip = false;

  int direction = 1;

  String phrase = "What is Friction?";
  String phraseTwo = "The block stopped from the ground's friction!";

  int frictionTypesTextSize = 34;
  int frictionTypesTextSizeSmall = 21;
  int frictionTypesTextSizeTiny = 16;
  float fPhraseLocationX = 250;
  float fPhraseLocationY = 200;
  String frictionTypes = "Two Types of Friction! ";

  String kineticFrictionPhrase = "Kinetic!";
  String staticFrictionPhrase = "Static!";

  String phraseThree = "Now it's Your Turn!";
  String phraseFour = "Click the button bellow to Move the Box";
  String phraseFive = "Move Sliders to adjust a Force and Static Friction amount!";

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
  String windMillTextThree = "Drag slows down fans after they turn off!";

  boolean canSeeWindMill = false;
  boolean canMoveWindmill = false;

  boolean showSecond = false;
  boolean showThird = false;

  boolean sliderIsPressed = false;
  boolean frictionSliderIsPressed = false;

  float windTimer = 0;
  float windTimerCountDown = 4;
  float windTimerMax = 4;

  float windForce = 0;
  float windMillSpeed = 0;

  Button windButton;

  float windmillPositionX = 420;
  float windmillPositionY = 250;
  
  Box mainBlade;
  Box windMillTower;

  float imageSpeed = 100;
  float fanImageX = 600;
  float dragImageX = 100;

  float fanSpeed = 300;

  Box rotBox;

  PImage frictionImage;
  PImage dragImage;
  PImage airImage;
}
