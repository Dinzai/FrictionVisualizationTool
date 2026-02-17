
//a small rectangle, with button, that 'expands' when clicked, and 'shows' options
//each option is a button, that 'activates'

class DropDownMenu implements Drawable, Interactable
{
  DropDownMenu()
  {

    box = new Box();
    box.MakeBox(100, 30);
    box.SetColour(110, 110, 110);
    box.Translate(10, 10);

    button = new Button();
    button.SetSize(20, 10);
    button.SetPosition(90, 30);
    button.SetOriginalColour(55, 55, 55);

    playButton = new Button(true);
    playButton.SetSize(30, 30);
    playButton.Rotate(135);
    playButton.SetPosition(700, 35);
    playButton.SetOriginalColour(200, 55, 55);

    backTextButton = new Button("Back");
    backTextButton.SetSize(21);
    backTextButton.SetTextOffsetCheck(30);
    backTextButton.SetPosition(750, 20);
    backTextButton.SetOriginalColour(0, 0, 0);

    objectTextButton = new Button("Object");
    objectTextButton.SetSize(12);
    objectTextButton.SetTextOffsetCheck(30);
    objectTextButton.SetPosition(100, 70);
    objectTextButton.SetOriginalColour(0, 0, 0);

    materialTextButton = new Button("Material");
    materialTextButton.SetSize(12);
    materialTextButton.SetTextOffsetCheck(30);
    materialTextButton.SetPosition(100, 140);
    materialTextButton.SetOriginalColour(0, 0, 0);

    selectTextButton = new Button("Select");
    selectTextButton.SetSize(12);
    selectTextButton.SetTextOffsetCheck(30);
    selectTextButton.SetPosition(20, 70);
    selectTextButton.SetOriginalColour(0, 0, 0);

    scaleUpTextButton = new Button("+ Mass");
    scaleUpTextButton.SetSize(12);
    scaleUpTextButton.SetTextOffsetCheck(30);
    scaleUpTextButton.SetPosition(20, 140);
    scaleUpTextButton.SetOriginalColour(0, 0, 0);

    scaleDownTextButton = new Button("- Mass");
    scaleDownTextButton.SetSize(12);
    scaleDownTextButton.SetTextOffsetCheck(30);
    scaleDownTextButton.SetPosition(20, 210);
    scaleDownTextButton.SetOriginalColour(0, 0, 0);

    forceButton = new Button();
    forceButton.SetSize(60, 20);
    forceButton.SetPosition(370, 20);
    forceButton.SetOriginalColour(110, 110, 110);

    sliderRail = new Box();
    sliderRail.MakeBox(80, 10);
    sliderRail.SetColour(80, 80, 80);
    sliderRail.Translate(520, 50);

    sliderButton = new Button();
    sliderButton.SetSize(10, 10);
    sliderButton.SetOriginalColour(90, 90, 90);
    sliderButton.SetPosition(520, 50);

    directionSliderRail = new Box();
    directionSliderRail.MakeBox(80, 10);
    directionSliderRail.SetColour(80, 80, 80);
    directionSliderRail.Translate(180, 50);

    directionSliderButton = new Button();
    directionSliderButton.SetSize(10, 10);
    directionSliderButton.SetOriginalColour(90, 90, 90);
    directionSliderButton.SetPosition(180, 50);

    pannel = new MaterialPannel();
  }

  void Click()
  {

    if (sliderButton.b.canClick)
    {
      sliderIsPressed = true;
    }

    if (directionSliderButton.b.canClick)
    {
      directionSliderIsPressed = true;
    }

    if (button.b.canClick && canExpand)
    {
      box.Translate(-10, -10);
      box.Scale(1.6, 8);
      box.Translate(10, 10);
      button.SetPosition(60, 210);
      sliderIsPressed = false;
      directionSliderIsPressed = false;
      canExpand = false;
    } else if (button.b.canClick && !canExpand)
    {
      box.Translate(-10, -10);
      box.Scale(0.625, 0.125);
      box.Translate(10, 10);
      button.SetPosition(-60, -210);
      canShowMaterials = false;
      sliderIsPressed = false;
      directionSliderIsPressed = false;
      canExpand = true;
    }
    if (!canExpand && objectTextButton.textSystem.canClick)
    {
      canShowMaterials = false;
      sliderIsPressed = false;
      directionSliderIsPressed = false;
      spawner.Spawn();
    }

    if (forceButton.b.canClick)
    {
      sliderIsPressed = false;
      directionSliderIsPressed = false;
      canAddForce = true;
    }

    //Material Mode
    if (!canExpand && materialTextButton.textSystem.canClick)
    {
      sliderIsPressed = false;
      directionSliderIsPressed = false;
      canShowMaterials = !canShowMaterials;
    }

    //play mode
    if (playButton.t.canClick)
    {
      sliderIsPressed = false;
      directionSliderIsPressed = false;
      playButton.isActive = !playButton.isActive;
      spawner.SwitchGravityOn();
      canShowMaterials = false;
    }

    //selection mode
    if (!canExpand && selectTextButton.textSystem.canClick)
    {
      sliderIsPressed = false;
      directionSliderIsPressed = false;
      canShowMaterials = false;

      selectTextButton.textSystem.isActive = true;
      spawner.SetMode("select");
    } else if (selectTextButton.textSystem.isActive == true)
    {
      selectTextButton.textSystem.isActive = false;
    }

    //scale mode
    if (!canExpand && scaleUpTextButton.textSystem.canClick)
    {
      sliderIsPressed = false;
      directionSliderIsPressed = false;
      canShowMaterials = false;

      scaleUpTextButton.textSystem.isActive = true;
      spawner.SetMode("massUp");
    } else if (scaleUpTextButton.textSystem.isActive == true)
    {
      scaleUpTextButton.textSystem.isActive = false;
    }

    if (!canExpand && scaleDownTextButton.textSystem.canClick)
    {
      sliderIsPressed = false;
      directionSliderIsPressed = false;
      canShowMaterials = false;
      scaleDownTextButton.textSystem.isActive = true;
      spawner.SetMode("massDown");
    } else if (scaleDownTextButton.textSystem.isActive == true)
    {
      scaleDownTextButton.textSystem.isActive = false;
    }

    if (backTextButton.textSystem.canClick)
    {
      sliderIsPressed = false;
      directionSliderIsPressed = false;
      canShowMaterials = false;
      spawner.allObjects.clear();
      playButton.isActive = false;

      sim.tScreen.isSim = false;
      sim.tScreen.isTitle = true;
    }
  }

  void Reset()
  {
    if (canAddForce)
    {
      canAddForce = false;
    }
    if (sliderIsPressed == true)
    {
      sliderIsPressed = false;
    }
    if (directionSliderIsPressed == true)
    {
      directionSliderIsPressed = false;
    }
    if (backTextButton.textSystem.canClick)
    {
      backTextButton.textSystem.canClick = false;
    }
  }

  void SliderUpdate()
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
        startingForce = value * maxForceAmount;
        sliderButton.b.posX = newPositionX;
      }
    }
  }

  void DirectionSliderUpdate()
  {
    if (directionSliderIsPressed)
    {
      float minSlide = directionSliderRail.posX;
      float maxSlide = directionSliderRail.posX + directionSliderRail.theWidth - directionSliderButton.b.theWidth;
      float newPositionX = mouseX - directionSliderButton.b.theWidth / 2;
      if (newPositionX < minSlide)
      {

        newPositionX = minSlide;
      }
      if (newPositionX > maxSlide)
      {

        newPositionX = maxSlide;
      }
      if (mouseY > directionSliderButton.b.shape.get(0).y && mouseY < directionSliderButton.b.shape.get(0).y + directionSliderButton.b.theHeight)
      {

        //lock the magnitude based on the size
        float value = (newPositionX - minSlide) / (maxSlide - minSlide);
        startingDirection = value * 2 - 1;
        directionSliderButton.b.posX = newPositionX;
      }
    }
  }

  void ForceUpdate()
  {
    if (canAddForce)
    {
      spawner.AddForce(startingForce * startingDirection);
    }
  }

  void DrawToScreen()
  {
    ForceUpdate();
    SliderUpdate();
    DirectionSliderUpdate();
    pushMatrix();
    fill(0, 0, 0);
    textSize(16);

    text("Add Force to Selected!", 340, 15);

    text("Current Force: " + (int)startingForce, 490, 35);
    if (startingDirection > -1 && startingDirection < 1)
    {
      text("Force Direction: None", 172, 35);
    }
    if (startingDirection == -1)
    {
      text("Force Direction: Left", 172, 35);
    }
    if (startingDirection == 1)
    {
      text("Force Direction: Right", 172, 35);
    }

    text("Add", 625, 29);
    text("Gravity!", 625, 40);

    sliderRail.Draw();
    sliderButton.Draw();

    directionSliderRail.Draw();
    directionSliderButton.Draw();

    popMatrix();

    pushMatrix();
    fill(0, 0, 0);
    textSize(14);
    text("Click!", 60, 60);
    popMatrix();

    pushMatrix();
    box.Draw();
    fill(0, 0, 0);
    textSize(16);
    text("Menu", 35, 30);
    if (canExpand)
    {
      drawArrow(100, 60, 100, 45);
    }


    button.Draw();
    playButton.Draw();
    backTextButton.Draw();
    forceButton.Draw();
    if (!canExpand)
    {
      pushMatrix();
      fill(0, 0, 0);
      textSize(12);
      text("Click on Menu", 80, 200);
      text("Options", 80, 212);
      text("Click!", 90, 245);
      popMatrix();
      drawArrow(120, 240, 140, 240);
      selectTextButton.Draw();
      scaleUpTextButton.Draw();
      scaleDownTextButton.Draw();
      objectTextButton.Draw();
      materialTextButton.Draw();
      if (canShowMaterials)
      {

        pannel.Draw();
      }
    }

    popMatrix();
  }

  boolean canExpand = true;

  boolean canShowMaterials = false;

  boolean canAddForce = false;

  boolean sliderIsPressed = false;
  boolean directionSliderIsPressed = false;

  float maxForceAmount = 5000;
  float startingForce = 0;

  float startingDirection = -1;

  int direction = 1;

  Box box;
  Button button;
  Button playButton;
  Button selectTextButton;
  Button scaleUpTextButton;
  Button scaleDownTextButton;
  Button backTextButton;

  Button materialTextButton;
  Button objectTextButton;

  Box sliderRail;
  Button sliderButton;

  Box directionSliderRail;
  Button directionSliderButton;

  MaterialPannel pannel;

  Button forceButton;
}
