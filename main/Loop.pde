

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
    input.Grab(menu);
  }
  
  void Draw()
  {
    scene.DrawOrder();
  }
  
  Scene scene;
  DropDownMenu menu;
  
}
