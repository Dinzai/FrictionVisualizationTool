
class Windmill implements Drawable, Interactable
{

  Windmill()
  {
    Add();
  }

  void Add()
  {
    backTextButton = new Button("Back");
    backTextButton.SetSize(21);
    backTextButton.SetTextOffsetCheck(30);
    backTextButton.SetPosition(740, 25);
    backTextButton.SetOriginalColour(0, 0, 0);

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
    windButton.SetPosition(200, 310);
    windButton.SetOriginalColour(110, 110, 110);

    sliderRail = new Box();
    sliderRail.MakeBox(80, 10);
    sliderRail.SetColour(80, 80, 80);
    sliderRail.Translate(200, 200);

    sliderButton = new Button();
    sliderButton.SetSize(10, 10);
    sliderButton.SetOriginalColour(90, 90, 90);
    sliderButton.SetPosition(200, 200);
    
    dragSliderRail = new Box();
    dragSliderRail.MakeBox(80, 10);
    dragSliderRail.SetColour(80, 80, 80);
    dragSliderRail.Translate(560, 285);

    dragSliderButton = new Button();
    dragSliderButton.SetSize(10, 10);
    dragSliderButton.SetOriginalColour(90, 90, 90);
    dragSliderButton.SetPosition(560, 285);
    
    windowBox = new Box();
    windowBox.MakeBox(650, 480);
    windowBox.SetColour(135, 135, 135);
    windowBox.Translate(80, 40);
    
  }

  void Click()
  {
    if (windButton.b.canClick)
    {
      theSounds.PlayRandomUI();
      windForce += startingForce;
    }

    if (backTextButton.textSystem.canClick)
    {
      theSounds.PlayRandomUI();
      sim.tScreen.isWind = false;
      sim.tScreen.isTitle = true;
    }
    if (sliderButton.b.canClick)
    {
      theSounds.PlayRandomUI();
      sliderIsPressed = true;
    }
    
    if (dragSliderButton.b.canClick)
    {
      theSounds.PlayRandomUI();
      dragSliderIsPressed = true;
    }
    
  }

  void Reset()
  {

    if (sliderIsPressed)
    {
      sliderIsPressed = false;
    }
    
    if (dragSliderIsPressed)
    {
      dragSliderIsPressed = false;
    }

    if (backTextButton.textSystem.canClick)
    {
      backTextButton.textSystem.canClick = false;
    }
  }

  void Update()
  {
    windMillSpeed = windForce;
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
        startingForce = value * maxWindForce;
        sliderButton.b.posX = newPositionX;
        
      }
    }
    
    //drag
    
    if (dragSliderIsPressed)
    {
      float minSlide = dragSliderRail.posX;
      float maxSlide = dragSliderRail.posX + dragSliderRail.theWidth - dragSliderButton.b.theWidth;
      float newPositionX = mouseX - dragSliderButton.b.theWidth / 2;
      if (newPositionX < minSlide)
      {
        
        newPositionX = minSlide;
      }
      if (newPositionX > maxSlide)
      {
        
        newPositionX = maxSlide;
      }
      if (mouseY > dragSliderButton.b.shape.get(0).y && mouseY < dragSliderButton.b.shape.get(0).y + dragSliderButton.b.theHeight)
      {
        
        //lock the magnitude based on the size
         float value = (newPositionX - minSlide) / (maxSlide - minSlide);
        dragResistence = value * maxDragResistence;
        dragSliderButton.b.posX = newPositionX;
      }
    }

    if (windMillSpeed >= 5)
    {
      canMoveWindmill = true;
    }

    if (canMoveWindmill)
    {
      if (windForce > 0)
      {
        windForce -= dragResistence * deltaTime;
        //canMoveWindmill = false;
      }
      else if(windForce <= 0)
      {
        windForce = 0;
        canMoveWindmill = false;
      }

      windBladeUp.Rotate(windMillSpeed * deltaTime);
      windBladeRight.Rotate(windMillSpeed * deltaTime);
      windBladeDown.Rotate(windMillSpeed * deltaTime);
      windBladeLeft.Rotate(windMillSpeed * deltaTime);
    }
  }

  void DrawToScreen()
  {
    pushMatrix();
    
    windowBox.Draw();
    fill(0, 0, 0);
    textSize(windTextSize);
    text("Move the sliders!", 330, 120);
    text("Push the Button!", 120, 350);
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
    pushMatrix();
    stroke(0);
    strokeWeight(5);
    windButton.Draw();
    popMatrix();

    pushMatrix();
    fill(0, 0, 0);
    textSize(windTextSize);
    text("Current Wind Force: " + (int)windForce, windMillTower.posX - 300, windMillTower.posY + 15);
    popMatrix();

    pushMatrix();
    fill(0, 0, 0);
    textSize(windTextSize);
    text("Drag: " + (int)dragResistence, windMillTower.posX + 160, windMillTower.posY + 15);
    popMatrix();

    drawArrow(windMillTower.posX + 230, windMillTower.posY + 25, windMillTower.posX + 150, windMillTower.posY + 25);
    drawArrow(windMillTower.posX - 200, windMillTower.posY + 25, windMillTower.posX - 100, windMillTower.posY + 25);

    pushMatrix();
    fill(0, 0, 0);
    textSize(windTextSize);
    text("Starting Wind force: " + (int)startingForce, 110, 180);
    popMatrix();
    
    sliderRail.Draw();
    sliderButton.Draw();
        
    dragSliderRail.Draw();
    dragSliderButton.Draw();

    backTextButton.Draw();
  }

  Button backTextButton;
  int windTextSize = 21;

  boolean canSeeWindMill = false;
  boolean canMoveWindmill = false;

  boolean sliderIsPressed = false;
  boolean dragSliderIsPressed = false;

  float windTimer = 0;
  float windTimerCountDown = 4;
  float windTimerMax = 4;

  float dragResistence = 0;
  float maxDragResistence = 5000;

  float windForce = 0;
  float windMillSpeed = 0;

  Button windButton;

  float windmillPositionX = 420;
  float windmillPositionY = 250;
  
  float startingForce = 0;
  float maxWindForce = 10000;


  Box windBladeUp;
  Box windBladeRight;
  Box windBladeDown;
  Box windBladeLeft;
  Box windMillTower;

  Box sliderRail;
  Button sliderButton;
  
  Box dragSliderRail;
  Button dragSliderButton;
  Box windowBox;
  
}
