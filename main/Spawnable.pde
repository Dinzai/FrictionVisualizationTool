

class Spawnable implements Drawable, Interactable
{

  Spawnable()
  {
    allObjects = new ArrayList<Box>();
  }


  void Spawn()
  {
    Box temp = new Box();
    temp.MakeBox(50, 50); //default box size
    temp.Translate(400, 300);
    allObjects.add(temp);
  }

  void SetMode(String mode)
  {

    if (mode == "select")
    {
      this.mode = mode;
    }

    if (mode == "scale")
    {
      this.mode = mode;
    }

    if (mode == "rotate")
    {
      this.mode = mode;
    }
  }


  void Click()
  {
    for (Box b : allObjects)
    {
      if (b.canClick)
      {
        b.isSelected = true;
      }
    }
  }

  void Reset()
  {
    for (Box b : allObjects)
    {
      if (b.isSelected == true)
      {
        b.isSelected = false;
      }
    }
  }


  void Move(Box b)
  {
    if (b.isSelected && mode == "select")
    {
      b.SetColour(200, 100, 100);
      b.canClick = false;
      b.SetPosition(mouseX, mouseY);
    }
  }
  
  void Scale(Box b)
  {
    
    float left = b.shape.get(0).x;
    float right = left + b.theWidth;
    float center = right - b.theWidth / 2;
    if (b.isSelected && mode == "scale")
    {
      b.SetColour(200, 100, 100);
      b.canClick = false;
      b.Translate(-400, -300);
      
      if(mouseX > center && mouseX < right)
      {
        b.Scale(1.02, 1.0);
      } 
      
      if(mouseX < center && mouseX > left)
      {
        b.Scale(0.8, 1.0);
      }      
      /*
      if(mouseY < b.shape.get(0).y)
      {
        b.Scale(1.0, 0.8);
      }
      if(mouseY > b.shape.get(2).y)
      {
        b.Scale(1.0, 1.02);
      }
      */
      b.Translate(400, 300);
    }
  }

  void Grab()
  {
    for (Box b : allObjects)
    {
      if (!b.isSelected)
      {
        if (mouseX > b.shape.get(0).x && mouseX < b.shape.get(0).x + b.theWidth &&
          mouseY > b.shape.get(0).y && mouseY < b.shape.get(0).y + b.theHeight)
        {
          b.SetColour(100, 200, 100);
          b.canClick = true;
        } else
        {
          b.SetColour(255, 255, 255);
          b.canClick = false;
        }
      } 
      Move(b);
      Scale(b);
    }
  }

  void DrawToScreen()
  {
    Grab();
    for (Box b : allObjects)
    {
      b.Draw();
    }
  }



  ArrayList<Box> allObjects;
  String mode;
}


Spawnable spawner = new Spawnable();
