//a promise that 'that' whom implments this, will define the behavior
interface Interactable
{
  void Click();
  
  void Reset();
}
//this is going to act as a singleton
class InputManager
{
  
  InputManager()
  {
    interactables = new ArrayList<Interactable>();
  }
  //notice that though I have never defined what Interactables functions do, that I can use it as a Parameter value
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
//Yes, this is the only thing looking for input.

void mousePressed()
{
  input.Clicked();
}

void mouseReleased()
{
  input.Released();
}
