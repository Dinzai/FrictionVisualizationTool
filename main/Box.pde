
class Box
{
  Box()
  {
    baseShape = new ArrayList<Point>();
    shape = new ArrayList<Point>();
    normals = new ArrayList<Point>();
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

    for (Point p : baseShape)
    {
      shape.add(new Point(p.x, p.y));
    }
  }

  void MakeTri(float w, float h)
  {
    theWidth = w;
    theHeight = h;

    Point BL = new Point();
    Point BR = new Point(w, 0);
    Point TR = new Point(0, h);

    baseShape.add(BL);
    baseShape.add(BR);
    baseShape.add(TR);

    for (Point p : baseShape)
    {
      shape.add(new Point(p.x, p.y));
    }
  }

  float GetMaxY() {
    float maxY = shape.get(0).y;
    for (Point p : shape) {
      if (p.y > maxY) maxY = p.y;
    }
    return maxY;
  }


  float AngleToRad(float angle)
  {
    angle *= PI/180;
    return angle;
  }

  void Rotate(float angle)
  {

    this.angle = AngleToRad(angle);

    for (int i = 0; i < baseShape.size(); i++)
    {
      Point p = baseShape.get(i);
      Point o = shape.get(i);

      p.x = o.x * cos(this.angle ) - o.y * sin(this.angle );
      p.y = o.x * sin(this.angle ) + o.y * cos(this.angle );
    }
    UpdateBounds();
  }

  void Identity()
  {
    for (int i = 0; i < shape.size(); i++)
    {

      Point copyShape = baseShape.get(i);
      Point originalShape = shape.get(i);

      float x = copyShape.x * scaleX;
      float y = copyShape.y * scaleY;

      float rx = x * cos(angle) - y * sin(angle);
      float ry = x * sin(angle) + y * cos(angle);

      originalShape.x = rx + posX;
      originalShape.y = ry + posY;
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

  Point GetCenter()
  {
    float x = 0;
    float y = 0;

    for (Point p : shape)
    {
      x += p.x;
      y += p.y;
    }

    return new Point(x / shape.size(), y / shape.size());
  }


  void UpdateBounds()
  {
    float minX = shape.get(0).x;
    float maxX = shape.get(0).x;
    float minY = shape.get(0).y;
    float maxY = shape.get(0).y;

    for (Point p : shape)
    {
      if (p.x < minX)
      {
        minX = p.x;
      }

      if (p.x > maxX)
      {
        maxX = p.x;
      }

      if (p.y < minY)
      {
        minY = p.y;
      }

      if (p.y > maxY)
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
  }
  /*
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
   float x = p1.x + (y - p1.y) * (p2.x - p1.x) / (p2.y - p1.y);
   
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
   */  //Adding triangles made managing my own render system no good

  Point Normalize(Point vec)
  {
    float magnitude = sqrt(vec.x * vec.x + vec.y * vec.y);
    Point v = vec;
    if (magnitude != 0)
    {
      v = new Point(v.x / magnitude, v.y / magnitude);
    }
    return v;
  }

  void CalculateNormals()
  {
    normals.clear();
    for (int i = 0; i < shape.size(); i++)
    {
      Point p = shape.get(i);
      Point nextP = shape.get((i + 1) % shape.size());

      Point edge = new Point(nextP.x - p.x, nextP.y - p.y);
      Point aNormal = new Point(-edge.y, edge.x);
      Point normal = Normalize(aNormal);
      normals.add(normal);
    }
  }

  Container DotPointsToAxis(Point axis)
  {
    Container contain = new Container();
    ArrayList<Point> points = new ArrayList<Point>();
    for (int i = 0; i < shape.size(); i++)
    {
      points.add(shape.get(i));
    }

    for (Point p : points)
    {
      Point transformedPos = p;
      float dot = transformedPos.x * axis.x + transformedPos.y * axis.y;
      contain.Add(dot);
    }

    contain.CalculateMinMax();

    return contain;
  }

  boolean Collision(Box otherShape)
  {
    ArrayList<Point> axies = new ArrayList<Point>();


    for (Point normal : normals)
    {
      axies.add(normal);
    }

    for (Point normal : otherShape.normals)
    {
      axies.add(normal);
    }

    float smallestOverlap = Float.MAX_VALUE;
    Point bestAxis = new Point();

    for (Point axis : axies)
    {
      axis = Normalize(axis);

      Container one = DotPointsToAxis(axis);
      Container two = otherShape.DotPointsToAxis(axis);


      if (one.GetMax() < two.GetMin())
      {

        return false;
      }

      if (two.GetMax() < one.GetMin())
      {

        return false;
      }

      float overlap = min(one.GetMax(), two.GetMax()) - max(one.GetMin(), two.GetMin());
      if (overlap < smallestOverlap)
      {

        smallestOverlap = overlap;
        bestAxis = axis;
      }
    }

    Point d = new Point(GetCenter().x - otherShape.GetCenter().x, GetCenter().y - otherShape.GetCenter().y);

    float dot = d.x * bestAxis.x + d.y * bestAxis.y;

    if (dot < 0)
    {
      bestAxis.x *= -1;
      bestAxis.y *= -1;
    }

    changeVector = new Point(bestAxis.x * smallestOverlap, bestAxis.y * smallestOverlap);
    if (changeVector.y < 0)
    {
      velocityY = 0;
      Translate(0, changeVector.y);
    }

    return true;
  }

  void Resolution()//floor
  {

    Translate(changeVector.x, changeVector.y);
  }

  void Resolution(Box otherShape)
  {

    Translate(changeVector.x * 0.5, changeVector.y * 0.5);
    otherShape.Translate(-changeVector.x * 0.5, -changeVector.y * 0.5);
  }


  void Update()
  {
    if (!isPaused)
    {
      velocityY += gravity * deltaTime;
      Translate(0, velocityY * deltaTime);
    }


    UpdateBounds();
    CalculateNormals();
  }



  void Draw()
  {
    Identity();
    pushMatrix();
    beginShape();
    fill(c.r, c.g, c.b);
    strokeWeight(3);
    for (Point p : shape)
    {
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
    popMatrix();
    /*
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
     */
  }

  float theWidth;
  float theHeight;

  float posX;
  float posY;

  float velocityX = 0;
  float velocityY = 0;

  float scaleX = 1;
  float scaleY = 1;

  boolean isSelected = false;
  boolean canClick = false;

  boolean isPaused = true;

  float gravity = 200;

  float angle = 0;


  ArrayList<Point> shape;
  ArrayList<Point> baseShape;

  ArrayList<Point> normals;
  Point changeVector = new Point();

  Colour c;
}



class Container
{


  void Add(float value)
  {
    values.add(value);
  }

  void CalculateMinMax()
  {
    for (float v : values)
    {
      if (v < min)
      {
        min = v;
      }
      if (v > max)
      {
        max = v;
      }
    }
  }

  float GetMax()
  {
    return max;
  }

  float GetMin()
  {
    return min;
  }

  ArrayList<Float> values = new ArrayList<Float>();

  float min = Float.MAX_VALUE;//Float.MAX_VALUE hold the largest float, i set min to large, max to low
  float max = -Float.MAX_VALUE;//this way when the above runs, min becoms v, max becomes v, and then that function can compare those values
}
