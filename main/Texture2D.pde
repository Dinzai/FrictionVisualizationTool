
//need to have a system to load, cache, and handle used images for the program

class CacheTextures
{
  CacheTextures()
  {
    allTextures = new ArrayList<PImage>();
  }
  
  PImage SetImage(String name)
  {
    PImage tempImage;
    tempImage = loadImage("assets/" + name + ".png");
    return tempImage;
  }   
  
  void AddToCache()
  {
    PImage none = SetImage("none");
    allTextures.add(none);//0
    allTextures.add(SetImage("wood"));//1
    allTextures.add(SetImage("metal"));//2
    allTextures.add(SetImage("rock"));//3
    allTextures.add(SetImage("ice"));//4
  }
  
  PImage GetTexture(int num)
  {
    return allTextures.get(num);
  }
    
  ArrayList<PImage> allTextures;
}
