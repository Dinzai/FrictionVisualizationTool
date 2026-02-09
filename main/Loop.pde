

class Loop
{
  Loop()
  {
    scene = new Scene();
    
    menu = new DropDownMenu();
   
  }
  
  void Add()
  {
    scene.AddTolayer(Layers.UI, menu);
    scene.AddTolayer(Layers.ENTITY, spawner);
    input.Grab(menu);
    input.Grab(spawner);
  }
  
  void Draw()
  {
    scene.DrawOrder();
  }
  
  Scene scene;
  DropDownMenu menu;
  
}
