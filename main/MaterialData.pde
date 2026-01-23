

enum MaterialTypes//material types
{
  ICE,
  WOOD,
  METAL,
  ROCK, 
  GLASS,
}

class Vec3//placeholder for colour until I have textures
{
  Vec3(float r, float g, float b)
  {
    this.r = r;
    this.g = g;
    this.b = b;
  }
  float r;
  float g;
  float b;
  
}


//making a table for the types

float[][] StaticFriction = {
  //ICE Wood Metal Rock Glass
  {0.0, 0.0, 0.0, 0.0, 0.0},//ICE
  {0.0, 0.0, 0.0, 0.0, 0.0},//Wood
  {0.0, 0.0, 0.0, 0.0, 0.0},//Metal
  {0.0, 0.0, 0.0, 0.0, 0.0},//Rock
  {0.0, 0.0, 0.0, 0.0, 0.0},//Glass
};

float[][] KineticFriction = {
  //ICE Wood Metal Rock Glass
  {0.0, 0.0, 0.0, 0.0, 0.0},//ICE
  {0.0, 0.0, 0.0, 0.0, 0.0},//Wood
  {0.0, 0.0, 0.0, 0.0, 0.0},//Metal
  {0.0, 0.0, 0.0, 0.0, 0.0},//Rock
  {0.0, 0.0, 0.0, 0.0, 0.0},//Glass
};
//this way I can simply compare different objects types to calculate what friction cooeficient to use

//use case ->    
//float staticMU = StaticFriction[objectMaterial][SurfaceMaterial]
// float kineticMU = KineticFriction[objectMaterial][SurfaceMaterial]

class Material
{
  
  void SetType(String name)
  {
    if(name == "ice")
    {
      type = MaterialTypes.ICE;
    }
    
    if(name == "wood")
    {
      type = MaterialTypes.WOOD;
    }
    
    if(name == "metal")
    {
      type = MaterialTypes.METAL;
    }
    
    if(name == "rock")
    {
      type = MaterialTypes.ROCK;
    }
    
    if(name == "glass")
    {
      type = MaterialTypes.GLASS;
    }
    
  }
  
  void SetColour(float r, float g, float b)
  {
    colour = new Vec3(r, g, b);
  }
  
  void DebugType()
  {
    print(type);
  }
  
  Vec3 colour;
  MaterialTypes type;
}


class Attributes//this class only contains variables used for the basic objects, this will be an instance of basic object
{ 
  Material material = new Material();
  float mass = 0;  
  PVector position = new PVector();
  PVector size = new PVector();
  PVector velocity = new PVector();
  PVector accleration = new PVector();
  
}
