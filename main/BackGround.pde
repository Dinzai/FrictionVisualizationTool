//avoids complications with simulation 'fake' window draw order, as DropDownMenu class is, in its self a UI componenet, this is a BACKGROUND layer


//for Sim mode, really, it should be used in all the modes, but, this is fine for now

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
     windowBox.Draw();
  }
  
  Box windowBox;
}
