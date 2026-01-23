
import java.util.Map;

enum Layers
{
  BACKGROUND,
  ENTITY,
  UI,
}

interface Drawable// a complex object needs to implment this
{
  void DrawToScreen();
}

class Scene
{
  
  Scene()  
  {
    renderLayers = new HashMap<Layers, ArrayList<Drawable>>();
    
    for(Layers layer : Layers.values())
    {
      renderLayers.put(layer, new ArrayList<Drawable>());
    }
    
  }
  
  void AddTolayer(Layers layer, Drawable obj)
  {
    renderLayers.get(layer).add(obj);
  }

  void DrawOrder()
  {
    for(Map.Entry<Layers, ArrayList<Drawable>> entry : renderLayers.entrySet())
    {
      ArrayList<Drawable> objects = entry.getValue();
      for(Drawable obj : objects)
      {
        obj.DrawToScreen();
      }
    }
  }
  
  HashMap<Layers, ArrayList<Drawable>> renderLayers;
  
}
