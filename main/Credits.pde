
class Credits implements Drawable, Interactable
{

  Credits()
  {
    backTextButton = new Button("Back");
    backTextButton.SetSize(21);
    backTextButton.SetTextOffsetCheck(50);
    backTextButton.SetPosition(740, 25);
    backTextButton.SetOriginalColour(0, 0, 0);

    me = new Box();
    me.MakeBox(90, 100);
    me.SetColour(190, 150, 130);
    me.Translate(30, 130);
    me.m.SetTexture(11);
    me.m.useTexture = true;
    me.FlipColourOther();

    openAI = new Box();
    openAI.MakeBox(75, 75);
    openAI.SetColour(190, 150, 130);
    openAI.Translate(30, 420);
    openAI.m.SetTexture(12);
    openAI.m.useTexture = true;
    openAI.FlipColourOther();

  }

  void Click()
  {
    if (backTextButton.textSystem.canClick)
    {
      theSounds.PlayRandomUI();
      sim.tScreen.isCredits = false;
      theSounds.PlayMusic(BACKGROUND_MUSIC.TITLE.ordinal());
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

    background(95, 80, 200);

    pushMatrix();
    backTextButton.Draw();
    popMatrix();

    pushMatrix();
    me.Draw();
    openAI.Draw();
    popMatrix();

    pushMatrix();
    fill(0, 0, 0);
    textSize(40);
    text("Programmer: Brett Rogers", 140, 200);
    textSize(20);
    text("I used Chat-GPT Ruber Ducking: Rewind Features, Collision Resolution", 80, 400);
    popMatrix();
  }

  Box me;
  Box openAI;

  Button backTextButton;
}
