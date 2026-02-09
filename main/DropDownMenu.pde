
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

    objectTextButton = new Button("Add Object");
    objectTextButton.SetSize(12);
    objectTextButton.SetPosition(100, 70);
    objectTextButton.SetOriginalColour(0, 0, 0);
  }

  void Click()
  {
    if (button.canClick && canExpand)
    {
      box.Translate(-10, -10);
      box.Scale(1.6, 8);
      box.Translate(10, 10);
      button.SetPosition(60, 210);
      canExpand = false;
    } else if (button.canClick && !canExpand)
    {
      box.Translate(-10, -10);
      box.Scale(0.625, 0.125);
      box.Translate(10, 10);
      button.SetPosition(-60, -210);
      canExpand = true;
    }
  }

  void DrawToScreen()
  {
    box.Draw();
    button.Draw();
    if (!canExpand)
    {
      objectTextButton.Draw();
    }
  }

  boolean canExpand = true;

  Box box;
  Button button;
  Button objectTextButton;
}
