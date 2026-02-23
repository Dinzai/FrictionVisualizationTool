
//need to have a system to load, cache, and handle used images for the program

//This object runs at the start of the program, loading the textures into memory
//In the Material class, is an enumoratror M_TYPE
//using the same order as previously dtermined, the textures will load into memory
//that way, calling M_TYPE.whateverType.oridinal()<- will chose the correct texture

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
    //From here down, are textures that do no need to be defined in materials
    allTextures.add(SetImage("fanIcon"));//5
    allTextures.add(SetImage("frictionIcon"));//6
    allTextures.add(SetImage("airIcon"));//7
    allTextures.add(SetImage("dragIcon"));//8
    allTextures.add(SetImage("scienceIcon"));//9
    allTextures.add(SetImage("windMillIcon"));//10
  }
  
  PImage GetTexture(int num)
  {
    return allTextures.get(num);
  }
    
  ArrayList<PImage> allTextures;
}
