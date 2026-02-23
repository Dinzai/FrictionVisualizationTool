
import java.util.Map;
//what layers can we draw to
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
  
  void RemoveFromLayer(Layers layer, Drawable obj)
  {
    renderLayers.get(layer).remove(obj);
  }

  void DrawOrder()
  {
    for(Layers layer : Layers.values())
    {
      ArrayList<Drawable> objects = renderLayers.get(layer);
      for(Drawable obj : objects)
      {
        obj.DrawToScreen();
      }
    }
  }
  
  HashMap<Layers, ArrayList<Drawable>> renderLayers;
  
}
