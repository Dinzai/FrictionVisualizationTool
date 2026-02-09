
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

    objectTextButton = new Button("Object");
    objectTextButton.SetSize(12);
    objectTextButton.SetPosition(100, 70);
    objectTextButton.SetOriginalColour(0, 0, 0);

    selectTextButton = new Button("Select");
    selectTextButton.SetSize(12);
    selectTextButton.SetPosition(20, 70);
    selectTextButton.SetOriginalColour(0, 0, 0);

    scaleTextButton = new Button("Scale");
    scaleTextButton.SetSize(12);
    scaleTextButton.SetPosition(20, 140);
    scaleTextButton.SetOriginalColour(0, 0, 0);

    rotationTextButton = new Button("Rotate");
    rotationTextButton.SetSize(12);
    rotationTextButton.SetPosition(20, 210);
    rotationTextButton.SetOriginalColour(0, 0, 0);
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
//selection mode
    if (!canExpand && selectTextButton.textSystem.canClick)
    {
      selectTextButton.textSystem.isActive = true;
      spawner.SetMode("select");
    }
    else if (selectTextButton.textSystem.isActive == true)
    {
      selectTextButton.textSystem.isActive = false;
    }
    //scale mode
    if (!canExpand && scaleTextButton.textSystem.canClick)
    {
      scaleTextButton.textSystem.isActive = true;
      spawner.SetMode("scale");
    }
    else if (scaleTextButton.textSystem.isActive == true)
    {
      scaleTextButton.textSystem.isActive = false;
    }
    
    
  }

  void Reset()
  {
    
  }

  void DrawToScreen()
  {
    box.Draw();
    button.Draw();
    if (!canExpand)
    {
      selectTextButton.Draw();
      scaleTextButton.Draw();
      rotationTextButton.Draw();
      objectTextButton.Draw();
    }
  }

  boolean canExpand = true;

  Box box;
  Button button;
  Button selectTextButton;
  Button scaleTextButton;
  Button rotationTextButton;
  //Button materialTextButton;
  Button objectTextButton;
}
