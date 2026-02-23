//Brett Rogers, Ferris State University, DAGD 420 Feb 20th, 2026 Friction Simulator 
Loop sim;
CacheTextures cache; 
SoundManager theSounds;
PFont theFont;

void setup()
{
  size(800, 600, P2D);
  
  cache = new CacheTextures();
  cache.AddToCache();
  theFont = createFont("DejaVu Sans", 24);
  textFont(theFont);
  
  theSounds = new SoundManager(this);
  theSounds.LoadAllMusic();
  theSounds.LoadAll();
  theSounds.PlayMusic(BACKGROUND_MUSIC.TITLE.ordinal());
    
  sim = new Loop();
  sim.Add();
  
}

void draw()
{
  background(95, 80, 200);
  sim.Update();
  sim.Draw();
}
