
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
  
  
  float x;
  float y;
  
}



void drawArrow(float x1, float y1, float x2, float y2)
  {
    // Draw main line
    line(x1, y1, x2, y2);

    // Arrow head size
    float arrowSize = 10;

    // Direction angle
    float angle = atan2(y2 - y1, x2 - x1);

    // Arrow head points
    float x3 = x2 - arrowSize * cos(angle - PI/6);
    float y3 = y2 - arrowSize * sin(angle - PI/6);

    float x4 = x2 - arrowSize * cos(angle + PI/6);
    float y4 = y2 - arrowSize * sin(angle + PI/6);

    // Draw arrow head
    line(x2, y2, x3, y3);
    line(x2, y2, x4, y4);
  }
