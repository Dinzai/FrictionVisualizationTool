Loop sim;

void setup()
{
  size(800, 600);
  sim = new Loop();
  sim.Add();


}
void draw()
{
  background(55);
  sim.Update();
  sim.Draw();

}
