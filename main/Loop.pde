//the actual 'Game Loop' of the program

class Loop
{
  Loop()
  {
    //Notice, each Object, is categorized with each scene
    //the scene is the drawable layer
    //Input is a singleton, made at the bottom of the Interact class
    //The function is to grab objects thatbhave implmented the Interactable interface
    
    //The title Screen
    title = new Scene();
    tScreen = new TitleScreen();
    tScreen.isTitle = true;//start in title
    
    //tutorial
    tutorial = new Scene();
    tutScreen = new Tutorial();
    
    //Windmill
    wind = new Scene();
    windScreen = new Windmill();
    
    //Simulation Mode
    simulator = new Scene();
    spawner = new Spawnable();
    menu = new DropDownMenu();    
    back = new BackGround();
    
    credits = new Scene();
    creditPage = new Credits();
    
  }

  void Add()
  {
    //Add to layer has an option to chose the layer, and object
    //input.Grab choses which object to grab
    
    //title
    title.AddTolayer(Layers.UI, tScreen);
    input.Grab(tScreen);

    //tut
    tutorial.AddTolayer(Layers.UI, tutScreen);
    input.Grab(tutScreen);

    //sim
    simulator.AddTolayer(Layers.UI, menu);//top most layer
    simulator.AddTolayer(Layers.BACKGROUND, back);//bottom most layer
    simulator.AddTolayer(Layers.ENTITY, spawner);//middle layer
    input.Grab(menu);
    input.Grab(spawner);

    //wind
    wind.AddTolayer(Layers.UI, windScreen);
    input.Grab(windScreen);
    
    credits.AddTolayer(Layers.UI, creditPage);
    input.Grab(creditPage);
    
  }
  
  void Reset()
  {//eject basically removes that system from being interactable, for the moment
    tutorial.RemoveFromLayer(Layers.UI, tutScreen);
    input.Eject(tutScreen);
    tutScreen = new Tutorial();
    tutorial.AddTolayer(Layers.UI, tutScreen);
    input.Grab(tutScreen);
  }


  void Update()
  {
    if (tScreen.isTut)
    {
      CalculateDeltaTime();
      tutScreen.Update();
    }

    if (tScreen.isSim)
    {
      CalculateDeltaTime();
      CalculateFixedDeltaTime();
      spawner.Update();      
    }
    
    if (tScreen.isWind)
    {
      CalculateDeltaTime();
      windScreen.Update();
    }
    
    
    
  }

  void Draw()
  {
    if (tScreen.isTitle)
    {
      background(95, 80, 200);//I may not have to reset the bckground per if statement, noticed a strange bug that apears sometimes, hoping this fixes it
      title.DrawOrder();
    }
    if (tScreen.isTut)
    {
      background(95, 80, 200);
      tutorial.DrawOrder();
    }
    if (tScreen.isSim)
    {
      background(95, 80, 200);
      simulator.DrawOrder();
    }
    if (tScreen.isWind)
    {
      background(95, 80, 200);
      wind.DrawOrder();
    }
    if(tScreen.isCredits)
    {
      credits.DrawOrder();
    }
  }

  Scene title;
  TitleScreen tScreen;

  Scene tutorial;
  Tutorial tutScreen;

  Scene wind;
  Windmill windScreen;

  Scene simulator;
  DropDownMenu menu;
  BackGround back;
  
  Scene credits;
  Credits creditPage;
  
}
