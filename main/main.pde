//Brett Rogers, Ferris State University, DAGD 420 Feb 20th, 2026 Friction Simulator 

//Having sim, cache, and theSounds global allows for quick memory access/modification
//sim is the program, sometimes accessing certain parts of sim from other 'game states' is necessary for 
//resetting the state
//cache holds, and allows acess to all textures loaded into the program
//theSounds holds, and allows access to all sounds loaded into the program

//This program contains NO inheritence, only use of Interfaces. 

Loop sim;
CacheTextures cache; 
SoundManager theSounds;
PFont theFont;

void setup()
{
  size(800, 600, P2D);
  
  cache = new CacheTextures();
  cache.AddToCache();
  theFont = createFont("DejaVu Sans", 24);//If it can not find this font, a font will be provided, working seemlessly
  textFont(theFont);
  //the sound manager loads the sound effects/music into memory
  theSounds = new SoundManager(this);
  theSounds.LoadAllMusic();
  theSounds.LoadAll();
  theSounds.PlayMusic(BACKGROUND_MUSIC.TITLE.ordinal());
  //this begins the title 'game state'   
  sim = new Loop();
  sim.Add(); 
}

void draw()
{
  background(95, 80, 200);//This is a specific colour chosen within the colour pallet
  sim.Update();
  sim.Draw();
}
