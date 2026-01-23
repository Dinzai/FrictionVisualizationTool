
int screenWidth = 800;
int screenHeight = 600;

Loop simulation;

void settings()
{
  size(screenWidth, screenHeight);
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
