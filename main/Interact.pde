
interface Interactable
{
  void Click();
  
  void Reset();
}

class InputManager
{
  
  InputManager()
  {
    interactables = new ArrayList<Interactable>();
  }
  
  void Grab(Interactable ie)
  {
    interactables.add(ie);
  }
  
  void Eject(Interactable ie)
  {
    interactables.remove(ie);
  }
  
  void Clicked()
  {
    for(Interactable ie : interactables)
    {
      ie.Click();
    }
  }
  
  void Released()
  {
    for(Interactable ie : interactables)
    {
      ie.Reset();
    }
  }
  
  ArrayList<Interactable> interactables;
  
}

InputManager input = new InputManager();


void mousePressed()
{
  input.Clicked();
}

void mouseReleased()
{
  input.Released();
}
