
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
  
  void AddListener(Listener listen)
  {
    listener.add(listen);
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

InputManager manager = new InputManager();



void keyPressed()
{
  manager.KeyDown(key);
}

void keyReleased()
{
  manager.KeyUp(key);
}
