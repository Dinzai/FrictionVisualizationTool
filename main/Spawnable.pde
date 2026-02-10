

class Spawnable implements Drawable, Interactable
{

  Spawnable()
  {
    allObjects = new ArrayList<Box>();

    PlaceFloor();
  }

  void PlaceFloor()
  {
    floor = new Box();
    floor.MakeBox(800, 50);
    floor.Translate(0, 550);
    
    
    
  }

  void Spawn()
  {
    Box temp = new Box();
    temp.MakeBox(50, 50); //default box size
    temp.Translate(400, 300);
    allObjects.add(temp);
  }
  
  void SpawnTri()
  {
    Box temp = new Box();
    temp.MakeTri(200, 200); //default tri size
    //temp.Rotate(90);
    temp.Translate(400, 300);
    allObjects.add(temp);
  }

  void SetMode(String mode)
  {

    if (mode == "select")
    {
      this.mode = mode;
    }

    if (mode == "massUp")
    {
      this.mode = mode;
    }

    if (mode == "massDown")
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

    if (b.isSelected && mode == "massUp")
    {
      if (b.scaleX < 2 && b.scaleY < 2)
      {
        b.SetColour(200, 100, 100);
        b.canClick = false;
        b.Scale(1.02, 1.02);
      }
    }

    if (b.isSelected && mode == "massDown")
    {
      if (b.scaleX > 0.5 && b.scaleY > 0.5)
      {
        b.SetColour(200, 100, 100);
        b.canClick = false;
        b.Scale(0.8, 0.8);
      }
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

  void SwitchGravityOn()
  {
    mode = "select";
    for (Box b : allObjects)
    {
      
      b.isPaused = !b.isPaused;
    }
  }

  void CheckCollision()
  {
    for (int i = 0; i < allObjects.size(); i++)
    {
      Box temp = allObjects.get(i);
      if(temp.Collision(floor))
      {
        temp.Resolution();
        temp.AlignFlatSide(floor);
      }
      for(int j = i + 1; j <  allObjects.size(); j++)
      {
        Box other = allObjects.get(j);
        if(temp != other)
        {
          if(temp.Collision(other))
          {
            temp.Resolution(other);
          }
        }
      }
      
    }
  }
  
  void EachUpdate()
  {
    floor.Identity();
    floor.UpdateBounds();
    floor.CalculateNormals();
    for(Box b : allObjects)
    {
      b.Update();
    }
  }

  void Update()
  {
    EachUpdate();
    CheckCollision();
    Grab();
    
  }

  void DrawToScreen()
  {

    for (Box b : allObjects)
    {
      b.Draw();
    }
    floor.Draw();
  }

  Box floor;
  ArrayList<Box> allObjects;
  String mode;
}


Spawnable spawner = new Spawnable();
