
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
    backTextButton.SetPosition(750, 20);
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
    windButton.SetPosition(200, 350);
    windButton.SetOriginalColour(110, 110, 110);
  }

  void Click()
  {
    if (windButton.b.canClick)
    {
      windForce += 200 * deltaTime;
    }

    if (backTextButton.textSystem.canClick)
    {
      sim.tScreen.isWind = false;
      sim.tScreen.isTitle = true;
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

  void DrawToScreen()
  {

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
    text("Wind Force: " + (int)windForce, windMillTower.posX - 210, windMillTower.posY + 5);
    popMatrix();
    
    pushMatrix();
    fill(0, 0, 0);
    textSize(windTextSize);
    text("Drag: " + (int)dragResistence, windMillTower.posX + 160, windMillTower.posY + 5);
    popMatrix();

    drawArrow(windMillTower.posX + 230, windMillTower.posY + 15, windMillTower.posX + 150, windMillTower.posY + 15);
    drawArrow(windMillTower.posX - 200, windMillTower.posY + 15, windMillTower.posX - 100, windMillTower.posY + 15);

    backTextButton.Draw();
  }

  Button backTextButton;
  int windTextSize = 21;

  boolean canSeeWindMill = false;
  boolean canMoveWindmill = false;

  float windTimer = 0;
  float windTimerCountDown = 4;
  float windTimerMax = 4;
  
  float dragResistence = 20;

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
