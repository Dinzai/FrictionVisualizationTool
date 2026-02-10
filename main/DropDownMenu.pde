
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
    playButton.Rotate(68);
    playButton.SetPosition(700, 50);
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
  }

  void Click()
  {
    if (button.b.canClick && canExpand)
    {
      box.Translate(-10, -10);
      box.Scale(1.6, 8);
      box.Translate(10, 10);
      button.SetPosition(60, 210);
      canExpand = false;
    } else if (button.b.canClick && !canExpand)
    {
      box.Translate(-10, -10);
      box.Scale(0.625, 0.125);
      box.Translate(10, 10);
      button.SetPosition(-60, -210);
      canExpand = true;
    }
    if (!canExpand && objectTextButton.textSystem.canClick)
    {
      spawner.Spawn();
    }

    //play mode
    if (!canExpand && playButton.t.canClick)
    {
      spawner.SwitchGravityOn();
      
    } 
    //selection mode
    if (!canExpand && selectTextButton.textSystem.canClick)
    {
      selectTextButton.textSystem.isActive = true;
      spawner.SetMode("select");
    } else if (selectTextButton.textSystem.isActive == true)
    {
      selectTextButton.textSystem.isActive = false;
    }
    //scale mode
    if (!canExpand && scaleUpTextButton.textSystem.canClick)
    {
      scaleUpTextButton.textSystem.isActive = true;
      spawner.SetMode("massUp");
    } else if (scaleUpTextButton.textSystem.isActive == true)
    {
      scaleUpTextButton.textSystem.isActive = false;
    }

    if (!canExpand && scaleDownTextButton.textSystem.canClick)
    {
      scaleDownTextButton.textSystem.isActive = true;
      spawner.SetMode("massDown");
    } else if (scaleDownTextButton.textSystem.isActive == true)
    {
      scaleDownTextButton.textSystem.isActive = false;
    }
    
    if (backTextButton.textSystem.canClick)
    {
      sim.tScreen.isTitle = true;
      sim.tScreen.isSim = false;
    } 
    
    
  }

  void Reset()
  {
    if (backTextButton.textSystem.canClick)
    {
      backTextButton.textSystem.canClick = false;
    }
  }

  void DrawToScreen()
  {
    box.Draw();
    button.Draw();
    playButton.Draw();
    backTextButton.Draw();
    if (!canExpand)
    {
      selectTextButton.Draw();
      scaleUpTextButton.Draw();
      scaleDownTextButton.Draw();
      objectTextButton.Draw();
    }
  }

  boolean canExpand = true;

  Box box;
  Button button;
  Button playButton;
  Button selectTextButton;
  Button scaleUpTextButton;
  Button scaleDownTextButton;
  Button backTextButton;

  //Button materialTextButton;
  Button objectTextButton;
}
