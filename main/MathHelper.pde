
class VectorMath
{
  //helper functions
  PVector GetPosition(OBJECT a)
  {
    return a.the.position;
  }
  
  PVector GetSize(OBJECT a)
  {
    return a.the.size;
  }
  
  PVector GetCenter(OBJECT a)
  {
    PVector sizeOne = GetSize(a);
    
    return new PVector(a.the.position.x + sizeOne.x * 0.5, a.the.position.y + sizeOne.y * 0.5);
  }
  
  PVector AbsoluteValue(PVector value)
  {
    return new PVector(abs(value.x), abs(value.y));
  }
  
  PVector CalculateDistance(OBJECT one, OBJECT two)//this calculates the distance between the objects centers
  {  
    //use the objects center for distance clac
    PVector objectOneCenterPosition = GetCenter(one);
    PVector objectTwoCenterPosition = GetCenter(two);
    
    return new PVector(objectOneCenterPosition.x - objectTwoCenterPosition.x, objectOneCenterPosition.y - objectTwoCenterPosition.y);
    
  }
  
  float CalculateAngle(OBJECT one, OBJECT two)
  {
    PVector distanceVector = CalculateDistance(one, two);
    return atan2(distanceVector.y, distanceVector.x);
  }
  
}

class PhysicsUtil
{
  
  boolean CheckCollision(OBJECT one, OBJECT two)
  {
    //calculater half sizes for AABB
    //Object One
    float oneHalfWidth = vMath.GetSize(one).x * 0.5;
    float oneHalfHeight = vMath.GetSize(one).y * 0.5;
        
    //Object Two
    float twoHalfWidth = vMath.GetSize(two).x * 0.5;
    float twoHalfHeight = vMath.GetSize(two).y * 0.5;
  
    //distance between centers 
    PVector distanceVector = vMath.CalculateDistance(one, two);
    distanceVector = vMath.AbsoluteValue(distanceVector);
    boolean overlapX = distanceVector.x < oneHalfWidth + twoHalfWidth;
    boolean overlapY = distanceVector.y < oneHalfHeight + twoHalfHeight;
   
    return overlapX && overlapY;
    
  }
  
  VectorMath vMath = new VectorMath();
}
