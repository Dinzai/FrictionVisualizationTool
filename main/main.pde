
Loop sim;
CacheTextures cache; 

void setup()
{
  size(800, 600, P2D);
  cache = new CacheTextures();
  cache.AddToCache();
  sim = new Loop();
  sim.Add();
}

void draw()
{
  background(55);
  sim.Update();
  sim.Draw();
}
