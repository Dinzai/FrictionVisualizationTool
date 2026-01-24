

interface Collideable
{
  void ProcessFriction();
  void CollisionMaterials(OBJECT b);
}

class ObjectPool
{
  ObjectPool()
  {
    collisionObjects = new ArrayList<Collideable>();

  }

  void AddToPool(Collideable obj)
  {
    collisionObjects.add(obj);
  }

  void Collision()
  {
    for (int i = 0; i < collisionObjects.size(); i++)
    {
      OBJECT a = (OBJECT)collisionObjects.get(i);
      for (int j = i+ 1; j < collisionObjects.size(); j++)
      {
        OBJECT b = (OBJECT)collisionObjects.get(j);
        
        a.CollisionMaterials(b);
        
        
      }
    }

  }
  
  void FixedUpdate()
  {
    Collision();
  }
  
  void Update()
  {
    for (int i = 0; i < collisionObjects.size(); i++)
    {
      Collideable a = collisionObjects.get(i);
      a.ProcessFriction();
    }

  }

  ArrayList<Collideable> collisionObjects;

  float timeStep = 0;
}
