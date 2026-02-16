//avoids complications with simulation 'fake' window draw order, as DropDownMenu class is, in its self a UI componenet, this is a BACKGROUND layer
class BackGround implements Drawable
{
  BackGround()
  {
    windowBox = new Box();
    windowBox.MakeBox(768, 480);
    windowBox.SetColour(135, 135, 135);
    windowBox.Translate(15, 70);
  }
  
  
  void DrawToScreen()
  {
     windowBox.Draw();
  }
  
  Box windowBox;
}
