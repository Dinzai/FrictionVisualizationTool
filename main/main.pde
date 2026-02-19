
Loop sim;
CacheTextures cache; 
PFont theFont;
void setup()
{
  size(800, 600, P2D);
  cache = new CacheTextures();
  cache.AddToCache();
  theFont = createFont("DejaVu Sans", 24);

  textFont(theFont);
  sim = new Loop();
  sim.Add();
}

void draw()
{
  background(55);
  sim.Update();
  sim.Draw();
}
