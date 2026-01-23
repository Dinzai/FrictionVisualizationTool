

class BasicObject//this does not know how to be drawn, it is just a container of things with helper functions
{
  
  BasicObject()
  {
    the = new Attributes();
  }
  
  void InitPosition(float x, float y)
  {
    the.position.x = x;
    the.position.y = y;
  }
  
  void InitMass(float mass)
  {
    the.mass = mass;
  }
  
  void InitSize(float w, float h)  
  {
    the.size.x = w;
    the.size.y = h;
  }
  
  void InitAccleration(float aX, float aY)
  {
    the.accleration.x = aX;
    the.accleration.y = aY;
     
  }
  
  void InitMaterial(String name)
  {
    the.material.SetType(name);
  }
  
  Attributes the;
}
