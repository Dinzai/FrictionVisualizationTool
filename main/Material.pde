
enum M_TYPE
{
  NONE,
    WOOD,
    METAL,
    ROCK,
    ICE,
    FAN,
}

class Material
{

  Material(M_TYPE mt)
  {
    materialType = mt;
    c = new Colour();
    UpdateType();
  }

  void UpdateType()
  {
    if (materialType == M_TYPE.NONE)
    {
      staticFrictionValue = 0;
      kineticFrictionValue = 0;
    }

    if (materialType == M_TYPE.WOOD)
    {
      staticFrictionValue = 450;
      kineticFrictionValue = 300;
    }

    if (materialType == M_TYPE.METAL)
    {
      staticFrictionValue = 200;
      kineticFrictionValue = 150;
    }

    if (materialType == M_TYPE.ROCK)
    {
      staticFrictionValue = 700;
      kineticFrictionValue = 500;
    }

    if (materialType == M_TYPE.ICE)
    {
      staticFrictionValue = 20;
      kineticFrictionValue = 10;
    }
  }

  void SetType(M_TYPE mType)
  {
    UpdateType();
    materialType = mType;
    SetColour();
    SetTexture(materialType.ordinal());
    useTexture = true;
  }

  void SetTexture(int num)
  {
    texture2D = cache.GetTexture(num);
  }

  void SetColour()
  {
    if (materialType == M_TYPE.NONE)
    {
      mass = 10;
      c = new Colour(227, 238, 179);
    }

    if (materialType == M_TYPE.WOOD)
    {
      mass = 30;
      c = new Colour(125, 80, 35);
    }

    if (materialType == M_TYPE.METAL)
    {
      mass = 75;
      c = new Colour(95, 80, 110);
    }

    if (materialType == M_TYPE.ROCK)
    {
      mass = 125;
      c = new Colour(55, 55, 55);
    }

    if (materialType == M_TYPE.ICE)
    {
      mass = 50;
      c = new Colour(110, 110, 255);
    }
  }

  float DetermineStaticInteraction(Material other)
  {
    if (!foundStaticValues)
    {
      if (staticFrictionValue == 0 || other.staticFrictionValue == 0)
      {
        combinedStatic = staticFrictionValue + other.staticFrictionValue;
        foundStaticValues = true;
      } else
      {
        combinedStatic = (staticFrictionValue + other.staticFrictionValue) * 0.5;
        foundStaticValues = true;
      }
    }
    return combinedStatic;
  }

  float DeterminekineticInteraction(Material other)
  {
    if (!foundKineticValues)
    {
      if (kineticFrictionValue == 0 || other.kineticFrictionValue == 0)
      {
        combinedKientic = kineticFrictionValue + other.kineticFrictionValue;
        foundKineticValues = true;
      } else
      {
        combinedKientic = (kineticFrictionValue + other.kineticFrictionValue) * 0.5;
        foundKineticValues = true;
      }
    }
    return combinedKientic;
  }

  float staticFrictionValue;
  float kineticFrictionValue;

  float combinedStatic = 0;
  float combinedKientic = 0;

  boolean foundStaticValues = false;
  boolean foundKineticValues = false;

  boolean useTexture = false;

  M_TYPE materialType;
  Colour c;
  float mass;

  PImage texture2D;
}

class MaterialIconObject implements Drawable, Interactable
{

  MaterialIconObject(M_TYPE materialType, float x, float y, float r)
  {
    xPos = x;
    yPos = y;
    radius = r;

    originalXPos = x;
    originalYPos = y;
    m = new Material(materialType);
  }

  void Click()
  {
    if (mouseX > xPos - radius && mouseX < xPos + radius && mouseY > yPos - radius && mouseY < yPos + radius)
    {
      isClicked = true;
    }
  }

  void Update()
  {
    if (isClicked == true)
    {
      xPos = mouseX;
      yPos = mouseY;
    }
  }

  boolean Collision(Box b)
  {

    if (xPos + radius < b.posX)
    {
      return false;
    }

    if (xPos - radius > b.posX + b.theWidth)
    {
      return false;
    }

    if (yPos + radius < b.posY)
    {
      return false;
    }

    if (yPos - radius > b.posY + b.theHeight)
    {
      return false;
    }


    return true;
  }

  void Check()
  {

    if (isClicked)
    {
      if (Collision(spawner.floor))
      {
        //print("hit");
        spawner.floor.SetType(m.materialType);
      }

      for (int i = 0; i < spawner.allObjects.size(); i++)
      {
        Box temp = spawner.allObjects.get(i);
        if (Collision(temp))
        {
          temp.SetType(m.materialType);
        }
      }
    }
  }

  void Reset()
  {
    isClicked = false;
    xPos = originalXPos;
    yPos = originalYPos;
  }

  void SetColour()
  {
    m.SetColour();
  }

  void DrawToScreen()
  {
    Check();
    pushMatrix();
    fill(m.c.r, m.c.g, m.c.b);
    circle(xPos, yPos, radius * 2);
    popMatrix();
  }

  float xPos;
  float yPos;

  float originalXPos;
  float originalYPos;

  boolean isClicked = false;

  float radius;

  Material m;
}


class MaterialPannel
{

  MaterialPannel()
  {
    pannel = new Box();
    pannel.MakeBox(145, 150);
    pannel.SetColour(110, 110, 110);
    pannel.Translate(170, 100);
    materials = new ArrayList<MaterialIconObject>();
    AddMaterialTypes();
  }

  void AddMaterialTypes()
  {
    MaterialIconObject none = new MaterialIconObject(M_TYPE.NONE, pannel.posX + 24, pannel.posY + 35, 10);
    none.SetColour();

    MaterialIconObject wood = new MaterialIconObject(M_TYPE.WOOD, pannel.posX + 24, pannel.posY + 70, 10);
    wood.SetColour();

    MaterialIconObject metal = new MaterialIconObject(M_TYPE.METAL, pannel.posX + 24, pannel.posY + 105, 10);
    metal.SetColour();

    MaterialIconObject rock = new MaterialIconObject(M_TYPE.ROCK, pannel.posX + 69, pannel.posY + 35, 10);
    rock.SetColour();

    MaterialIconObject ice = new MaterialIconObject(M_TYPE.ICE, pannel.posX + 69, pannel.posY + 70, 10);
    ice.SetColour();

    materials.add(none);
    materials.add(wood);
    materials.add(metal);
    materials.add(rock);
    materials.add(ice);

    for (MaterialIconObject m : materials)
    {
      input.Grab(m);
    }
  }

  void Draw()
  {
    pannel.Draw();
    pushMatrix();
    fill(0, 0, 0);
    textSize(10);
    text("None", pannel.posX + 15, pannel.posY + 20);
    text("Wood", pannel.posX + 15, pannel.posY + 55);
    text("Metal", pannel.posX + 15, pannel.posY + 90);
    text("Rock", pannel.posX + 60, pannel.posY + 20);
    text("Ice", pannel.posX + 60, pannel.posY + 55);
    text("Click and Drag", pannel.posX + 45, pannel.posY + 95);
    text("Materials to Objects", pannel.posX + 45, pannel.posY + 105);
    popMatrix();

    for (MaterialIconObject m : materials)
    {
      m.Update();
      m.DrawToScreen();
    }
  }


  Box pannel;
  ArrayList<MaterialIconObject> materials;
}
