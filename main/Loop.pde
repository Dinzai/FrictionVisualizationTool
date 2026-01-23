
//this will run the 'game' loop

class Loop
{
  Loop()
  {
    scene = new Scene();

  }
  
  void Load()//Add Objects here
  {
    OBJECT testObject = new OBJECT(200,200, 30, 30);
    testObject.SetAccleration(200);
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
