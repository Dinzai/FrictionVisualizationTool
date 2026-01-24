
//this will run the 'game' loop

class Loop
{
  Loop()
  {
    scene = new Scene();

  }
  
  void Load()//Add Objects here
  {
    OBJECT testbackGround = new OBJECT(0, 0, screenWidth, screenHeight, new Vec3(255,0,0));
    testbackGround.SetMaterial("ice");
    testbackGround.DebugMaterial();
    
    scene.AddTolayer(Layers.BACKGROUND, testbackGround);
        
    OBJECT testObject = new OBJECT(200,200, 30, 30, new Vec3(0,255,0));
    
    testObject.SetMass(20);
    testObject.SetAccleration(200);
    testObject.SetMaterial("wood");
    testObject.DebugMaterial();
    
    manager.AddListener(testObject);
    
    
    scene.AddTolayer(Layers.ENTITY, testObject);
    
  }

  void Update()
  {
    CalculateDeltaTime();
    manager.NotifyEvent();
  }

  void Draw()
  {
    scene.DrawOrder();
  }

  Scene scene;
}
