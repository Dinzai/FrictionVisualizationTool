
class Box
{
  Box()
  {
    shape = new ArrayList<Point>();
    c = new Colour();
  }

  void SetColour(float r, float g, float b)
  {
    c = new Colour(r, g, b);
  }

  void MakeBox(float w, float h)
  {
    theWidth = w;
    theHeight = h;

    Point TL = new Point();
    Point TR = new Point(w, 0);
    Point BL = new Point(0, h);
    Point BR = new Point(w, h);

    shape.add(TL);
    shape.add(TR);
    shape.add(BR);
    shape.add(BL);
  }



  void Translate(float x, float y)
  {
    for (int i = 0; i < shape.size(); i++)
    {
      Point p = shape.get(i % shape.size());
      p.x += x;
      p.y += y;
    }
  }

  void Scale(float sx, float sy)
  {
    for (int i = 0; i < shape.size(); i++)
    {
      Point p = shape.get(i % shape.size());
      p.x *= sx;
      p.y *= sy;
    }
  }

  void FillBox()
  {
    pushMatrix();
    stroke(c.r, c.g, c.b);
    strokeWeight(1);
    float minY = shape.get(0).y;
    float maxY = shape.get(0).y;

    for (Point p : shape)
    {
      minY = min(minY, p.y);
      maxY = max(maxY, p.y);
    }

    for (int y = (int)minY; y <= (int)maxY; y++)
    {
      ArrayList<Float> raster = new ArrayList<Float>();

      for (int i = 0; i < shape.size(); i++)
      {
        Point p = shape.get(i);
        Point nextP = shape.get((i + 1) % shape.size());

        //swap

        Point p1 = p;
        Point p2 = nextP;

        if (p1.y > p2.y)
        {
          Point temp = p1;
          p1 = nextP;
          p2 = temp;
        }

        if (y > p1.y && y < p2.y)
        {
          float x = p1.x;
          raster.add(x);
        }
      }

      for (int i = 0; i < raster.size() - 1; i+=2)
      {
        line(raster.get(i), y, raster.get(i+1), y);
      }
    }
    popMatrix();
  }

  void Draw()
  {
    FillBox();
    pushMatrix();
    stroke(0);
    strokeWeight(3);
    for (int i = 0; i < shape.size(); i++)
    {
      Point p = shape.get(i);
      Point nextP = shape.get((i + 1) % shape.size());

      line(p.x, p.y, nextP.x, nextP.y);
    }
    popMatrix();
  }

  float theWidth;
  float theHeight;
  ArrayList<Point> shape;
  Colour c;
}
