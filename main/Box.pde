
class Box
{
  Box()
  {
    baseShape = new ArrayList<Point>();
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
    
    baseShape.add(TL);
    baseShape.add(TR);
    baseShape.add(BR);
    baseShape.add(BL);

    for(Point p : baseShape)
    {
      shape.add(new Point(p.x, p.y));
    }
  }
  
  void Identity()
  {

    for(int i = 0; i < shape.size(); i++)
    {
      
      Point copyShape = baseShape.get(i);
      Point originalShape = shape.get(i);
    
      originalShape.x = copyShape.x * scaleX + posX; 
      originalShape.y = copyShape.y * scaleY + posY; 
      
    }
  }
  

  void SetPosition(float x, float y)
  {
    Point p = shape.get(0);
    float dx = x - p.x;
    float dy = y - p.y;
    dx -= theWidth / 2;
    dy -= theHeight / 2;
    
    Translate(dx, dy);

  }

  void Translate(float x, float y)
  {
    posX += x;
    posY += y;
    
  }
  
  void UpdateBounds()
  {
    float minX = shape.get(0).x;
    float maxX = shape.get(1).x;
    float minY = shape.get(2).y;
    float maxY = shape.get(3).y;
    
    for(Point p : shape)
    {
      if(p.x < minX)
      {
        minX = p.x;
      }
      
      if(p.x > maxX)
      {
        maxX = p.x;
      }
      
      if(p.y < minY)
      {
        minY = p.y;
      }
      
      if(p.y > maxY)
      {
        maxY = p.y;
      }
      
      theWidth = maxX - minX;
      theHeight = maxY - minY;
      
    }
    
  }

  void Scale(float sx, float sy)
  {
    scaleX *= sx;
    scaleY *= sy;
    UpdateBounds();
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
    Identity();
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
  
  float posX;
  float posY;
  
  float scaleX = 1;
  float scaleY = 1;
  
  boolean isSelected = false;
  boolean canClick = false;


  ArrayList<Point> shape;
  ArrayList<Point> baseShape;
  Colour c;
}
