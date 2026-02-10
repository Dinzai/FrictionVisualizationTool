
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
  }

  void Click()
  {
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

  void DrawToScreen()
  {
    backTextButton.Draw();
  }

  Button backTextButton;
}
