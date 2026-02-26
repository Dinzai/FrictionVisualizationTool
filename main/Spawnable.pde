//Spawnable is used cohesivly with the DropDown menu and Background, All are seperate Objects, working in tandem to produce the Simulator system
//Spawnable controls the draw, update, collision of any and all boxes that are created during runtime
//DropDownMenu is simply the UI that communicates with Spawnable
//Background is simply the fake window for the user's simulation

//Spawnable is a singleton

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
    floor.MakeBox(768, 50);
    floor.Translate(15, 550);
    floor.SetType(M_TYPE.NONE);
  }

  void Spawn()
  {
    Box temp = new Box();
    temp.MakeRotBox(50, 50); //default box size
    temp.Translate(400, 300);
    temp.SetType(M_TYPE.NONE);
    index++;
    allObjects.add(temp);
  }

  void SpawnTri()
  {
    Box temp = new Box();
    temp.MakeTri(200, 200); //default tri size
    temp.Rotate(90);
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

  void KillAllActive()
  {
    for (int i = 0; i < allObjects.size(); i++)
    {
      Box temp = allObjects.get(i);
      temp.setForDeletion = true;
    }
    index = -1;
  }


  void Click()
  {
    for (Box b : allObjects)
    {
      if (b.canClick)
      {
        theSounds.PlayRandomUI();
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
      float minX = 40;
      float maxX = 755;
      float minY = 95;
      float maxY = 525;

      float newPositionX = mouseX;
      float newPositionY = mouseY;
      if (newPositionX < minX)
      {
        newPositionX = minX;
      }
      if (newPositionX > maxX)
      {
        newPositionX = maxX;
      }

      if (newPositionY < minY)
      {
        newPositionY = minY;
      }
      if (newPositionY > maxY)
      {
        newPositionY = maxY;
      }

      b.SetColour(200, 100, 100);
      b.canClick = false;
      b.posX = newPositionX;
      b.posY = newPositionY;
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
        b.mass *= 1.02;
        b.Scale(1.02, 1.02);
      }
    }

    if (b.isSelected && mode == "massDown")
    {
      if (b.scaleX > 0.5 && b.scaleY > 0.5)
      {
        b.SetColour(200, 100, 100);
        b.canClick = false;
        b.mass *= 0.8;
        b.Scale(0.8, 0.8);
      }
    }
  }

  void AddForce(float amount)
  {
    if (index != -1)
    {
      Box b = allObjects.get(index);
      if (b.isPaused)
      {
        b.gotImpulse = true;
        b.force = amount;
      }
    }
  }
  void Grab()
  {
    for (int i = 0; i < allObjects.size(); i++)
    {
      Box b = allObjects.get(i);
      if (!b.isSelected)
      {
        if (b.FindPointInBox(mouseX, mouseY))
        {
          b.SetColour(100, 200, 100);

          b.canClick = true;
        } else
        {
          b.c = b.originalC;
          b.SetColour(b.c.r, b.c.g, b.c.b);

          b.canClick = false;
        }
      }

      if (b.isSelected)
      {
        index = i;
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

  void GarbageCollection()
  {
    for (int i = 0; i < allObjects.size(); i++)
    {
      Box temp = allObjects.get(i);
      if (temp.setForDeletion)
      {
        allObjects.remove(temp);
        index--;
      }
    }
    return;
  }

  void DoOnce(Box temp, boolean canReset)
  {
    if (canReset)
    {
      theSounds.PlayPhysicsSound(temp.m.materialType.ordinal());
      canReset = false;
    }
  }

  void CheckCollision()
  {
    for (int i = 0; i < allObjects.size(); i++)
    {
      Box temp = allObjects.get(i);
      if (temp.Collision(floor))
      {
        if (!temp.isPaused)
        {
          temp.m.foundStaticValues = false;
          temp.m.foundKineticValues = false;
          DoOnce(temp, true);
        }
        temp.m.staticFrictionValue = temp.m.DetermineStaticInteraction(floor.m);
        temp.m.kineticFrictionValue = temp.m.DeterminekineticInteraction(floor.m);

        temp.Resolution();
        temp.isPaused = true;
      }
      for (int j = i + 1; j <  allObjects.size(); j++)
      {
        Box other = allObjects.get(j);
        if (temp != other)
        {

          if (temp.Collision(other))
          {

            if (!temp.isPaused)
            {
              DoOnce(temp, true);
            }

            if (!other.isPaused)
            {
              DoOnce(other, true);
              other.isPaused = true;
            }

            temp.Resolution(other);
            other.Resolution(temp);

            // ChatGPT helped with this code, I was struggling with what the interaction shoud resolve as
            //I did not copy paste, but, asked many questions, and wrote down its suggestion with the collision code here
            
            boolean tempMoving = Math.abs(temp.velocityX) > 0.01 || Math.abs(temp.velocityY) > 0.01;
            boolean otherMoving = Math.abs(other.velocityX) > 0.01 || Math.abs(other.velocityY) > 0.01;
            
            //this bellow i logically deducted from the case above
            if (tempMoving && !otherMoving)
            {
              other.force = other.mass * temp.velocityX;
              other.gotImpulse = true;
              temp.velocityX = 0;
              temp.velocityY = 0;
            } else if (!tempMoving && otherMoving)
            {
              temp.force = temp.mass * other.velocityX;
              temp.gotImpulse = true;
              other.velocityX = 0;
              other.velocityY = 0;
            } else
            {
              temp.velocityX *= 0.5;
              other.velocityX *= 0.5;
            }

            if (temp.posY < other.posY)
            {
              temp.isPaused = true;
              other.isPaused = true;
            }
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
    for (Box b : allObjects)
    {
      b.Update();
    }
  }

  void Update()
  {
    GarbageCollection();
    EachUpdate();
    CheckCollision();
    Grab();
  }

  void DrawToScreen()
  {

    pushMatrix();
    stroke(1);
    strokeWeight(3);
    for (Box b : allObjects)
    {
      b.Draw();
    }
    popMatrix();

    pushMatrix();
    noStroke();
    floor.Draw();
    popMatrix();
  }

  int index = -1;

  Box floor;
  ArrayList<Box> allObjects;
  String mode;
}

//By making the object global, DropDownMenu can commmunicate with spawnable, this object is not created until loop runs
Spawnable spawner;// = new Spawnable();
