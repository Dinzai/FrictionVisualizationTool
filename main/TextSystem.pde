
//'simple struct'
//really, thats what this is, justa  container with variables in it, no methods
class TextSystem
{
  TextSystem()
  {
    c = new Colour();
  }
  

  Colour original;
  Colour c;
  String words;
  float charSize;
  float offsetCheck;
  Point textPos;
  boolean canClick = false;
  boolean isActive = false;//active text button
}
