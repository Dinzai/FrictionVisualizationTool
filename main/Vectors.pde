//Having a Vec3 for colour is very useful for quick colour changes
class Colour
{
  Colour()
  {
    r = 255;
    g = 255;
    b = 255;
  }
  
  Colour(float r, float g, float b)
  {
    this.r = r;
    this.g = g;
    this.b = b;
  }
  
  float r;
  float g;
  float b;
}
//This point system has UV's, that are connected with the Position of each point
class Point
{
  Point()
  {
    x = 0;
    y = 0;
  }
  
  Point(float x, float y)
  {
    this.x = x;
    this.y = y;
  }
  
  Point(float x, float y, float u, float v)
  {
    this.x = x;
    this.y = y;
    this.u = u;
    this.v = v;
  }
  
  
  float x;
  float y;
  
  float u;
  float v;
  
}


//global function in control of drawing arrows to the screen for any scene
void drawArrow(float x1, float y1, float x2, float y2)
  {
    line(x1, y1, x2, y2);

    float arrowSize = 10;

    float angle = atan2(y2 - y1, x2 - x1);

    float x3 = x2 - arrowSize * cos(angle - PI/6);
    float y3 = y2 - arrowSize * sin(angle - PI/6);

    float x4 = x2 - arrowSize * cos(angle + PI/6);
    float y4 = y2 - arrowSize * sin(angle + PI/6);

    line(x2, y2, x3, y3);
    line(x2, y2, x4, y4);
  }
