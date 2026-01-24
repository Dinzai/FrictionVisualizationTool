
//this will run the 'game' loop

class Loop
{
  Loop()
  {
    scene = new Scene();
    pool = new ObjectPool();

  }
  
  void Load()//Add Objects here
  {
    OBJECT testbackGround = new OBJECT(0, 0, screenWidth, screenHeight, new Vec3(255,0,0));
    testbackGround.SetMaterial("rock");
    testbackGround.DebugMaterial();
    
    scene.AddTolayer(Layers.BACKGROUND, testbackGround);
    pool.AddToPool(testbackGround);
        
    OBJECT testObject = new OBJECT(200,200, 30, 30, new Vec3(0,255,0));
    
    testObject.SetMass(20);
    testObject.SetMaterial("rock");
    testObject.DebugMaterial();
    
    manager.AddListener(testObject);
    
    
    scene.AddTolayer(Layers.ENTITY, testObject);
    pool.AddToPool(testObject);
    
  }
  
  void FixedUpdate()
  {
    pool.FixedUpdate();
        
  }

  void Update()
  {
    CalculateDeltaTime();
    
    FixedUpdate();
    
    pool.Update();
    
    manager.NotifyEvent();
       
  }

  void Draw()
  {
    scene.DrawOrder();
  }

  Scene scene;
  ObjectPool pool;
  
}
