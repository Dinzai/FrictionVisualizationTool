

class OBJECT extends BasicObject implements Drawable, Listener, Collideable 
{
  
  OBJECT(float x, float y, float w, float h, Vec3 colour)//initalize position, and size
  {
    super();
    InitPosition(x, y);
    InitSize(w, h);
    SetColour(colour.r, colour.g, colour.b);
    
  }
  
  void SetMaterial(String name)
  {
    InitMaterial(name);
  }
  
  void SetMass(float mass)
  {
    InitMass(mass);
  }
  
  void SetAccleration(float speed)
  {
    InitAccleration(speed, speed);
  }
  
  void CollisionMaterials(OBJECT b)
  {
    if(util.CheckCollision(this, b))
    {
       indexOne = this.GetMaterial();
       indexTwo = b.GetMaterial();
      
      //this.staticMU = 0.85;//StaticFriction[indexOne][indexTwo];
      //this.kineticMU = 0.85;//KineticFriction[indexOne][indexTwo];
      //println("Assigned kineticMU: " + this.kineticMU);

    }

  }
  
  void OnInput(HashSet<Character> keys)
  {
     
    if(keys.contains('w'))
    {
      direction.y = -1;
    }
    
    else if(keys.contains('s'))
    {
      direction.y = 1;
    }
    else 
    {
      direction.y = 0;
    }
    
    if(keys.contains('a'))
    {
      direction.x = -1;
    }
    
    else if(keys.contains('d'))
    {
      direction.x = 1;
    }
    else 
    {
      direction.x = 0;
    }
    
    Move();
  
  }
  
  void Move()
  {
    the.position.x += the.velocity.x * deltaTime;
    the.position.y += the.velocity.y * deltaTime;
  }
  
  void ProcessFriction()
  {
      staticMU = StaticFriction[indexOne][indexTwo];
      kineticMU = KineticFriction[indexOne][indexTwo];
     
     the.accleration.x = direction.x * acclerationAmount;
     the.accleration.y = direction.y * acclerationAmount;
     
     the.velocity.x += the.accleration.x * deltaTime;
     the.velocity.y += the.accleration.y * deltaTime;


     //print("this is the value :" + Math.signum(the.velocity.x) * friction);
     the.velocity.x -= the.velocity.x * kineticMU;
     the.velocity.y -= the.velocity.y * kineticMU;
     
     if(the.velocity.mag() < staticMU )
     {
       the.velocity.x = 0;
     }
     
        
     
  }

  void DrawToScreen()  
  {
    fill(the.material.colour.r, the.material.colour.g, the.material.colour.b);
    rect(the.position.x, the.position.y, the.size.x, the.size.y);
  }
  
  float staticMU = 0; 
  float kineticMU = 0; 
  float acclerationAmount = 20;
  PVector direction = new PVector();
  
  int indexOne;
  int indexTwo;
  
  
}
