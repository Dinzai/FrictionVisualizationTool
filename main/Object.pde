

class OBJECT extends BasicObject implements Drawable, Listener 
{
  
  OBJECT(float x, float y, float w, float h)//initalize position, and size
  {
    super();
    InitPosition(x, y);
    InitSize(w, h);
  }
  
  void SetMass(float mass)
  {
    InitMass(mass);
  }
  
  void SetAccleration(float speed)
  {
    InitAccleration(speed, speed);
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
     the.velocity.x = the.accleration.x * deltaTime;
     the.velocity.y = the.accleration.y * deltaTime;
     
     the.position.x += the.velocity.x * direction.x;
     the.position.y += the.velocity.y * direction.y;
     
  }
  
  void DrawToScreen()  
  {
    fill(255,0,0);
    rect(the.position.x, the.position.y, the.size.x, the.size.y);
  }
  
  PVector direction = new PVector();
  
}
