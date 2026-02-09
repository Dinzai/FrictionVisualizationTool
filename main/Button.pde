
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
    textSystem = new TextSystem();
    textSystem.textPos = new Point();
    textSystem.words = phrase;
    isText = true;
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
    if (isText)
    {
      textSystem.charSize = amount;
    }
  }

  void SetPosition(float x, float y)
  {
    if (isBox)
    {
      b.Translate(x, y);
    }
    if (isText)
    {
      textSystem.textPos.x = x;
      textSystem.textPos.y = y;
    }
  }

  void SetColour(float red, float green, float blue)//call to change highlight
  {
    if (isBox)
    {
      b.SetColour(red, green, blue);
    }

    if (isText)
    {
      textSystem.c = new Colour(red, green, blue);
    }
  }

  void SetOriginalColour(float red, float green, float blue)//call on creation
  {
    original = new Colour(red, green, blue);
    if (isText)
    {
      textSystem.c = original;
    }
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
        b.canClick = true;
      } else
      {
        SetColour(original.r, original.g, original.b);
        b.canClick = false;
      }
    }


    if (isText)
    {
      if (!textSystem.isActive)
      {
        if (mouseX > textSystem.textPos.x && mouseX < textSystem.textPos.x + 30
          && mouseY > textSystem.textPos.y - 10 && mouseY < textSystem.textPos.y + 6)
        {
          SetColour(100, 200, 100);
          textSystem.canClick = true;
        } else
        {

          SetColour(original.r, original.g, original.b);
          textSystem.canClick = false;
        }
      } else if (textSystem.isActive)
      {
        SetColour(100, 200, 100);
        textSystem.canClick = false;
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

    if (isText)
    {

      textSize(textSystem.charSize);
      fill(textSystem.c.r, textSystem.c.g, textSystem.c.b);
      text(textSystem.words, textSystem.textPos.x, textSystem.textPos.y);
    }
  }

  Box b;



  Colour original;

  TextSystem textSystem;

  boolean isBox = false;
  boolean isText = false;

};
