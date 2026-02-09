
interface Interactable
{
  void Click();
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
  
  void FixedUpdate()
  {
    for(Interactable ie : interactables)
    {
      ie.Click();
    }
  }
  
  ArrayList<Interactable> interactables;
  
}

InputManager input = new InputManager();


void mousePressed()
{
  input.FixedUpdate();
}

void mouseReleased()
{
  
}
