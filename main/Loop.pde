

class Loop
{
  Loop()
  {

    title = new Scene();
    tScreen = new TitleScreen();

    tutorial = new Scene();
    sim = new Scene();
    wind = new Scene();

    tScreen.isTitle = true;
    tutScreen = new Tutorial();
    windScreen = new Windmill();

    menu = new DropDownMenu();
    
    back = new BackGround();
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
    sim.AddTolayer(Layers.BACKGROUND, back);
    sim.AddTolayer(Layers.ENTITY, spawner);
    input.Grab(menu);
    input.Grab(spawner);

    //wind
    wind.AddTolayer(Layers.UI, windScreen);
    input.Grab(windScreen);
  }
  
  void Reset()
  {
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
      spawner.Update();
      CalculateDeltaTime();
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
  BackGround back;
}
