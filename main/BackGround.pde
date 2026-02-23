//avoids complications with simulation 'fake' window draw order, as DropDownMenu class is, in its self a UI componenet, this is a BACKGROUND layer

class BackGround implements Drawable
{
  BackGround()
  {
    windowBox = new Box();
    windowBox.MakeBox(768, 480);
    windowBox.SetColour(105, 102, 82);
    windowBox.Translate(15, 70);
  }

  void DrawToScreen()
  {
    pushMatrix();
    noStroke();
    background(95, 80, 200);
    windowBox.Draw();
    popMatrix();
  }

  Box windowBox;
}
