
import java.util.HashSet;


interface Listener
{
  void OnInput(HashSet<Character> keys);//a listener needs to implment this function
}


class InputManager
{
  InputManager()
  {
    listener = new ArrayList<Listener>();
    keys = new HashSet<Character>();
  }
  //Listeners allow me to let the user to chose which objects have the ability to move
  void AddListener(Listener listen)
  {
    listener.add(listen);
  }
  
  void RemoveListener(Listener listen)
  {
    listener.remove(listen);
  }
  
  void KeyDown(Character theKey)
  {
    keys.add(theKey);

  }
  
  void KeyUp(Character theKey)
  {
    keys.remove(theKey);
  }
  
  void NotifyEvent()
  {
    for(Listener listening : listener)
    {
      listening.OnInput(keys);
    }
  }
  
  
  ArrayList<Listener> listener;
  HashSet<Character> keys; 
  
}

InputManager manager = new InputManager();//used as a singlton



void keyPressed()
{
  manager.KeyDown(key);
}

void keyReleased()
{
  manager.KeyUp(key);
}
