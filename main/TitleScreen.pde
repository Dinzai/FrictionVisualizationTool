

class TitleScreen implements Drawable, Interactable
{

  TitleScreen()
  {
    buttons = new ArrayList<Button>();
    Add();
  }

  void Add()
  {

    Button tempTut = new Button("Tutorial");
    tempTut.SetSize(34);
    tempTut.SetTextOffsetCheck(130);
    tempTut.SetPosition(350, 200);
    tempTut.SetOriginalColour(0, 0, 0);

    Button tempSim = new Button("Simulation");
    tempSim.SetSize(34);
    tempSim.SetTextOffsetCheck(155);
    tempSim.SetPosition(150, 350);
    tempSim.SetOriginalColour(0, 0, 0);

    Button tempWind = new Button("Windmill");
    tempWind.SetSize(34);
    tempWind.SetTextOffsetCheck(130);
    tempWind.SetPosition(500, 350);
    tempWind.SetOriginalColour(0, 0, 0);

    buttons.add(tempTut);
    buttons.add(tempSim);
    buttons.add(tempWind);
  }

  void Remove()
  {
    buttons.clear();
    isTitle = true;
    isTut = false;
    isSim = false;
    isWind = false;
    Add();
  }

  void Click()
  {
    Button tempTut = buttons.get(0);
    Button tempSim = buttons.get(1);
    Button tempWind = buttons.get(2);

    if (tempTut.textSystem.canClick)
    {

      isTitle = false;
      isTut = true;
    }

    if (tempSim.textSystem.canClick)
    {
      isTitle = false;
      isSim = true;
    }

    if (tempWind.textSystem.canClick)
    {
      isTitle = false;
      isWind = true;
    }
  }

  void Reset()
  {
    Button tempTut = buttons.get(0);
    if (tempTut.textSystem.canClick)
    {
      tempTut.textSystem.canClick = false;
    }

    Button tempSim = buttons.get(0);
    if (tempSim.textSystem.canClick)
    {
      tempSim.textSystem.canClick = false;
    }

    Button tempWind = buttons.get(0);
    if (tempWind.textSystem.canClick)
    {
      tempWind.textSystem.canClick = false;
    }
  }

  void DrawToScreen()
  {
    Button tempTut = buttons.get(0);
    if (tempTut.textSystem.canClick)
    {
      sim.Reset();
    }

    pushMatrix();
    fill(0, 0, 0);
    textSize(55);
    text("Friction Simulator!", 200, 100);
    popMatrix();
    for (Button b : buttons)
    {
      b.Draw();
    }
  }

  boolean isTitle = false;
  boolean isTut = false;
  boolean isSim = false;
  boolean isWind = false;

  ArrayList<Button> buttons;
}
