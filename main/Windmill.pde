//This is it's own scene
class Windmill implements Drawable, Interactable
{

  Windmill()
  {
    Add();
  }

  void Add()
  {
    
    //(68, 62, 107);//boxes
    //(150, 138, 62);//buttons
    
    backTextButton = new Button("Back");
    backTextButton.SetSize(21);
    backTextButton.SetTextOffsetCheck(50);
    backTextButton.SetPosition(740, 25);
    backTextButton.SetOriginalColour(0, 0, 0);

    //wind mill part
    mainBlade = new Box();
    mainBlade.MakeRotBox(128, 128);
    mainBlade.SetColour(180, 180, 220);
    mainBlade.Translate(windmillPositionX, windmillPositionY + 20);
    mainBlade.m.SetTexture(10);
    mainBlade.m.useTexture = true;
    mainBlade.FlipColourOther();
    mainBlade.Rotate(30);
    
    windMillTower = new Box();
    windMillTower.MakeBox(20, 100);
    windMillTower.SetColour(190, 150, 130);
    windMillTower.Translate(windmillPositionX - 10, windmillPositionY);
    windMillTower.m.SetTexture(1);
    windMillTower.m.useTexture = true;
    windMillTower.FlipColourOther();

    windButton = new Button();
    windButton.SetSize(60, 20);
    windButton.SetPosition(200, 310);
    windButton.SetOriginalColour(150, 138, 62);

    sliderRail = new Box();
    sliderRail.MakeBox(80, 15);
    sliderRail.SetColour(68, 62, 107);
    sliderRail.Translate(200, 200);

    sliderButton = new Button();
    sliderButton.SetSize(15, 15);
    sliderButton.SetOriginalColour(150, 138, 62);
    sliderButton.SetPosition(200, 200);

    dragSliderRail = new Box();
    dragSliderRail.MakeBox(80, 10);
    dragSliderRail.SetColour(68, 62, 107);
    dragSliderRail.Translate(560, 285);

    dragSliderButton = new Button();
    dragSliderButton.SetSize(10, 10);
    dragSliderButton.SetOriginalColour(150, 138, 62);
    dragSliderButton.SetPosition(560, 285);

    windowBox = new Box();
    windowBox.MakeBox(650, 480);
    windowBox.SetColour(105, 102, 82);
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
      theSounds.PlayMusic(BACKGROUND_MUSIC.TITLE.ordinal());
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
      } else if (windForce <= 0)
      {
        windForce = 0;
        canMoveWindmill = false;
      }

      mainBlade.Rotate(windMillSpeed * deltaTime);
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

  Box windMillTower;

  Box sliderRail;
  Button sliderButton;

  Box dragSliderRail;
  Button dragSliderButton;
  Box windowBox;

  Box mainBlade;
}
