
class Button
{
  //default box button
  Button()
  {
    b = new Box();
    isBox = true;
  }
  //constructor for text based button
  Button(String phrase)
  {
    textPos = new Point();
    words = phrase;
    isText = true;
  }
  //image based button
  Button(TEXTURE_TYPE type)
  {
  }

  void SetSize(float w, float h)//Must call first
  {
    if (isBox)
    {
      b.MakeBox(w, h);
    }
    
  }
  
  void SetSize(float amount)
  {
    if(isText)
    {
      charSize = amount;
    }
  }

  void SetPosition(float x, float y)
  {
    if (isBox)
    {
      b.Translate(x, y);
    }
    if(isText)
    {
      textPos.x = x;
      textPos.y = y;
    }
  }

  void SetColour(float red, float green, float blue)//call to change highlight
  {
    if (isBox)
    {
      b.SetColour(red, green, blue);
    }
  }

  void SetOriginalColour(float red, float green, float blue)//call on creation
  {
    original = new Colour(red, green, blue);
    if (isBox)
    {
      b.SetColour(red, green, blue);
    }
    
  }

  void CheckMousePos()
  {
    if (isBox) 
    {
      if (mouseX > b.shape.get(0).x && mouseX < b.shape.get(0).x + b.theWidth &&
        mouseY > b.shape.get(0).y && mouseY < b.shape.get(0).y + b.theHeight)
      {
        SetColour(100, 200, 100);
        canClick = true;
      } else
      {
        SetColour(original.r, original.g, original.b);
        canClick = false;
      }
    }
  }


  void Draw()
  {
    CheckMousePos();
    if (isBox)
    {
      b.Draw();
    }
    
    if(isText)
    {
      
      textSize(charSize);
      fill(original.r, original.g, original.b);
      text(words, textPos.x, textPos.y);
    }
    
  }

  Box b;

  String words;
  float charSize;
  Point textPos;

  Colour original;

  boolean canClick = false;

  boolean isBox = false;
  boolean isText = false;
  boolean isImage = false;
};
