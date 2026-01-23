
int windowWidth = 800;
int windowHeight = 600;

Loop simulation;

void settings()
{
  size(windowWidth, windowHeight);
}

void setup()
{
  simulation = new Loop();
  simulation.Load();
}

void draw()
{
  background(55);
  simulation.Update();
  simulation.Draw();
}
