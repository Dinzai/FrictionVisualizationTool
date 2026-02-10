

class Loop
{
  Loop()
  {
    
    title = new Scene();
    tutorial = new Scene();
    sim = new Scene();
    wind = new Scene();
    
    tScreen = new TitleScreen();
    tScreen.isTitle = true;
    tutScreen = new Tutorial();
    windScreen = new Windmill();
    
    menu = new DropDownMenu();
    
  }

  void Add()
  {
//title    
    title.AddTolayer(Layers.UI, tScreen);
    input.Grab(tScreen);
    
//tut    
    tutorial.AddTolayer(Layers.UI, tutScreen);
    input.Grab(tutScreen);
 
 //sim   
    sim.AddTolayer(Layers.UI, menu);
    sim.AddTolayer(Layers.ENTITY, spawner);
    input.Grab(menu);
    input.Grab(spawner);
    
//wind    
    wind.AddTolayer(Layers.UI, windScreen);
    input.Grab(windScreen);
    
    
  }

  void Update()
  {

    if(tScreen.isSim)
    {
      spawner.Update();
      CalculateDeltaTime();
    }
  }

  void Draw()
  {
    if (tScreen.isTitle)
    {
      title.DrawOrder();
    }
    if (tScreen.isTut)
    {
      tutorial.DrawOrder();
    }
    if (tScreen.isSim)
    {
       sim.DrawOrder();
    }
    if (tScreen.isWind)
    {
      wind.DrawOrder();
    }
  }

  Scene title;
  TitleScreen tScreen;

  
  Scene tutorial;
  Tutorial tutScreen;
  
  Scene wind;
  Windmill windScreen;


  Scene sim;
  DropDownMenu menu;

}
