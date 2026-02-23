//This object is styled in the C programming language's Struct 
//meaning, this 'object' is simply a type of container that holds only attributes, 
//there are No methods. Yes, the constructor is considered a method, simply allocating memory
//for the colour is fine here

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
