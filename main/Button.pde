
class Button
{
  //default box button
  Button()
  {
    b = new Box();
    isBox = true;
  }

  Button(boolean makeTri)
  {
    if (makeTri)
    {
      t = new Box();
      isTri = true;
    }
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
    if (isTri)
    {
      t.MakeTri(w, h);
    }
  }

  void SetSize(float amount)
  {
    if (isText)
    {
      textSystem.charSize = amount;
    }
  }

  void SetTextOffsetCheck(float amount)
  {
    textSystem.offsetCheck = amount;
  }

  void Rotate(float angle)
  {
    if (isBox)
    {
      b.Rotate(angle);
    }
    if (isTri)
    {
      t.Rotate(angle);
    }
  }

  void SetPosition(float x, float y)
  {
    if (isBox)
    {
      b.Translate(x, y);
    }
    if (isTri)
    {
      t.Translate(x, y);
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

    if (isTri)
    {
      t.SetColour(red, green, blue);
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
    if (isTri)
    {
      t.SetColour(red, green, blue);
    }
  }

  boolean PointInTriangle(Point p, Point a, Point b, Point c)
  {
    float area = 0.5f * (-b.y * c.x + a.y * (-b.x + c.x) + a.x * (b.y - c.y) + b.x * c.y);

    float edgeAB = 1/(2 * area) * (a.y * c.x - a.x * c.y + (c.y - a.y) * p.x + (a.x - c.x) * p.y);

    float edgeAC = 1/(2 * area) * (a.x * b.y - a.y * b.x + (a.y - b.y) * p.x + (b.x - a.x) * p.y);

    return edgeAB >= 0 && edgeAC >= 0 && (edgeAB + edgeAC) <= 1;
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

    if (isTri)
    {
      if (!isActive)
      {
        Point m = new Point(mouseX, mouseY);
        if (PointInTriangle(m, t.shape.get(0), t.shape.get(1), t.shape.get(2)))
        {
          SetColour(100, 200, 100);
          t.canClick = true;
        } else
        {
          SetColour(original.r, original.g, original.b);
          t.canClick = false;
        }
      } else if (isActive)
      {
        SetColour(100, 200, 100);
        t.canClick = true;
        
      }
    }


    if (isText)
    {
      if (!textSystem.isActive)
      {
        if (mouseX > textSystem.textPos.x && mouseX < textSystem.textPos.x + textSystem.offsetCheck
          && mouseY > textSystem.textPos.y - 15 && mouseY < textSystem.textPos.y + 15)
        {
          SetColour(0, 255, 0);
          textSystem.canClick = true;
        } else
        {

          SetColour(original.r, original.g, original.b);
          textSystem.canClick = false;
        }
      } else if (textSystem.isActive)
      {
        SetColour(0, 255, 0);
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

    if (isTri)
    {
      t.Draw();
    }

    if (isText)
    {

      textSize(textSystem.charSize);
      fill(textSystem.c.r, textSystem.c.g, textSystem.c.b);
      text(textSystem.words, textSystem.textPos.x, textSystem.textPos.y);
    }
  }

  Box b;
  Box t;

  Colour original;

  TextSystem textSystem;

  boolean isActive = false;
  boolean isBox = false;
  boolean isTri = false;
  boolean isText = false;
};
