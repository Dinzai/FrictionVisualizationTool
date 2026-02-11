
enum M_TYPE
{
    NONE,
    WOOD,
    METAL,
    ROCK,
    ICE,
}

class Material
{

  Material(M_TYPE mt)
  {
    materialType = mt;
    if (materialType == M_TYPE.NONE)
    {      
      staticFrictionValue = 0;
      kineticFrictionValue = 0;
    }
    
    if (materialType == M_TYPE.WOOD)
    {
      staticFrictionValue = 45;
      kineticFrictionValue = 30;
    }

    if (materialType == M_TYPE.METAL)
    {
      staticFrictionValue = 20;
      kineticFrictionValue = 15;
    }

    if (materialType == M_TYPE.ROCK)
    {
      staticFrictionValue = 70;
      kineticFrictionValue = 50;
    }

    if (materialType == M_TYPE.ICE)
    {
      staticFrictionValue = 2;
      kineticFrictionValue = 1;
    }
  }

  float DetermineStaticInteraction(Material other)
  {

    return (staticFrictionValue + other.staticFrictionValue) * 0.5;
  }
  
  float DeterminekineticInteraction(Material other)
  {

    return (kineticFrictionValue + other.kineticFrictionValue) * 0.5;
  }

  float staticFrictionValue;
  float kineticFrictionValue;
  M_TYPE materialType;
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
    c = new Colour();
    m = new Material(materialType);
    

  }
  
  void Click()
  {
    if(mouseX > xPos - radius && mouseX < xPos + radius && mouseY > yPos - radius && mouseY < yPos + radius)
    {
      isClicked = true;     
    }
  }
  
  void Update()
  {
    if(isClicked == true)
    {
      xPos = mouseX;
      yPos = mouseY;
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
    if(m.materialType == M_TYPE.NONE)
    {
      c = new Colour(255, 255, 255); 
    }
    
    if(m.materialType == M_TYPE.WOOD)
    {
      c = new Colour(125, 80, 35); 
    }
    
    if(m.materialType == M_TYPE.METAL)
    {
      c = new Colour(95, 80, 110); 
    }
    
    if(m.materialType == M_TYPE.ROCK)
    {
      c = new Colour(55, 55, 55); 
    }
    
    if(m.materialType == M_TYPE.ICE)
    {
      c = new Colour(110, 110, 255); 
    }
  }
  
  void DrawToScreen()
  {
    pushMatrix();
    fill(c.r, c.g, c.b);
    circle(xPos, yPos, radius * 2);
    popMatrix();
  }
  
  float xPos;
  float yPos;
  
  float originalXPos;
  float originalYPos;
  
  boolean isClicked = false;
  
  float radius;
  
  Colour c;
  
  Material m;
  
}


class MaterialPannel
{
  
  MaterialPannel()
  {
    pannel = new Box();
    pannel.MakeBox(100, 100);
    pannel.SetColour(110, 110, 110);
    pannel.Translate(170, 100);
    materials = new ArrayList<MaterialIconObject>();
    AddMaterialTypes();
       
  }
  
  void AddMaterialTypes()
  {
    MaterialIconObject none = new MaterialIconObject(M_TYPE.NONE, pannel.posX + 15, pannel.posY + 20, 10);
    none.SetColour();
    
    MaterialIconObject wood = new MaterialIconObject(M_TYPE.WOOD, pannel.posX + 15, pannel.posY + 50, 10);
    wood.SetColour();
    
    MaterialIconObject metal = new MaterialIconObject(M_TYPE.METAL, pannel.posX + 15, pannel.posY + 80, 10);
    metal.SetColour();
    
    MaterialIconObject rock = new MaterialIconObject(M_TYPE.ROCK, pannel.posX + 40, pannel.posY + 20, 10);
    rock.SetColour();
    
    MaterialIconObject ice = new MaterialIconObject(M_TYPE.ICE, pannel.posX + 40, pannel.posY + 50, 10);
    ice.SetColour();
    
    materials.add(none);
    materials.add(wood);
    materials.add(metal);
    materials.add(rock);
    materials.add(ice);
    
    for(MaterialIconObject m : materials)
    {
      input.Grab(m);
    }
    
  }

  void Draw()
  {
    pannel.Draw();
    for(MaterialIconObject m : materials)
    {
      m.Update();
      m.DrawToScreen();
    }
  }
  
 
  Box pannel;
  ArrayList<MaterialIconObject> materials;
  
}
