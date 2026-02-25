
//This is it's own container/scene that covers the title screen
class TitleScreen implements Drawable, Interactable
{

  TitleScreen()
  {
    buttons = new ArrayList<Button>();
    titleImage = cache.GetTexture(9);
    Add();
  }

  void Add()
  {
    Button tempTut = new Button("Tutorial");
    tempTut.SetSize(34);
    tempTut.SetTextOffsetCheck(130);
    tempTut.SetPosition(325, 320);
    tempTut.SetOriginalColour(0, 0, 0);

    Button tempSim = new Button("Simulation");
    tempSim.SetSize(34);
    tempSim.SetTextOffsetCheck(180);
    tempSim.SetPosition(195, 460);
    tempSim.SetOriginalColour(0, 0, 0);

    Button tempWind = new Button("Windmill");
    tempWind.SetSize(34);
    tempWind.SetTextOffsetCheck(150);
    tempWind.SetPosition(420, 460);
    tempWind.SetOriginalColour(0, 0, 0);
    
    Button tempCredit = new Button("Credits");
    tempCredit.SetSize(25);
    tempCredit.SetTextOffsetCheck(100);
    tempCredit.SetPosition(350, 500);
    tempCredit.SetOriginalColour(0, 0, 0);

    buttons.add(tempTut);
    buttons.add(tempSim);
    buttons.add(tempWind);
    buttons.add(tempCredit);
  }

  void Remove()
  {
    buttons.clear();
    isCredits = false;
    isTut = false;
    isSim = false;
    isWind = false;
    isTitle = true;
    Add();
  }

  void Click()
  {
    Button tempTut = buttons.get(0);
    Button tempSim = buttons.get(1);
    Button tempWind = buttons.get(2);
    Button tempCredit = buttons.get(3);

    if (tempTut.textSystem.canClick)
    {
      theSounds.PlayRandomUI();
      isTitle = false;
      theSounds.PlayMusic(BACKGROUND_MUSIC.TUTORIAL.ordinal());
      isTut = true;
    }
    if (tempSim.textSystem.canClick)
    {
      theSounds.PlayRandomUI();
      isTitle = false;
      theSounds.PlayMusic(BACKGROUND_MUSIC.SIM.ordinal());
      isSim = true;
    }
    if (tempWind.textSystem.canClick)
    {
      theSounds.PlayRandomUI();
      isTitle = false;
      theSounds.PlayMusic(BACKGROUND_MUSIC.WIND.ordinal());
      isWind = true;
    }
    if (tempCredit.textSystem.canClick)
    {
      theSounds.PlayRandomUI();
      isTitle = false;
      theSounds.PlayMusic(BACKGROUND_MUSIC.WIND.ordinal());
      isCredits = true;
    }
  }

  void Reset()
  {
    Button tempTut = buttons.get(0);
    if (tempTut.textSystem.canClick)
    {
      tempTut.textSystem.canClick = false;
    }

    Button tempSim = buttons.get(1);
    if (tempSim.textSystem.canClick)
    {
      tempSim.textSystem.canClick = false;
    }

    Button tempWind = buttons.get(2);
    if (tempWind.textSystem.canClick)
    {
      tempWind.textSystem.canClick = false;
    }
    
    Button tempCredits = buttons.get(3);
    if (tempCredits.textSystem.canClick)
    {
      tempCredits.textSystem.canClick = false;
    }
    
  }

  void DrawToScreen()
  {
    Button tempTut = buttons.get(0);
    if (tempTut.textSystem.canClick)
    {
      sim.Reset();//this is defined in Loop, sim is a global object created in Main
    }
    image(titleImage, 135, 80);

    pushMatrix();
    fill(0, 0, 0);
    textSize(54);
    text("Friction Simulator", 170, 80);
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
  boolean isCredits = false;
  
  PImage titleImage;

  ArrayList<Button> buttons;
}
