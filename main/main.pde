//Brett Rogers, Ferris State University, DAGD 420 Feb 20th, 2026 Friction Simulator 

//Gloabls
Loop sim;
CacheTextures cache; 
SoundManager theSounds;
PFont theFont;

void setup()
{
  size(800, 600, P2D);
  //initalize the textures
  cache = new CacheTextures();
  cache.AddToCache();
  //set the font, if computer doesn't have it, it will set to what it can, works fine
  theFont = createFont("DejaVu Sans", 24);
  textFont(theFont);
  //allocate memory for the soun
  theSounds = new SoundManager(this);
  theSounds.LoadAllMusic();
  theSounds.LoadAll();
  theSounds.PlayMusic(BACKGROUND_MUSIC.TITLE.ordinal());
  //start the program with the data  
  sim = new Loop();
  sim.Add();
  
}

void draw()
{
  //background colour is intential, part of colour pallet
  background(95, 80, 200);
  sim.Update();
  sim.Draw();
}
