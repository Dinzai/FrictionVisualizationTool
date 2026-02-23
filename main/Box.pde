//this
class Box
{
  Box()
  {
    baseShape = new ArrayList<Point>();
    shape = new ArrayList<Point>();
    normals = new ArrayList<Point>();
    c = new Colour();
    originalC = new Colour();
    m = new Material(M_TYPE.NONE);
  }

  void SetColour(float r, float g, float b)
  {
    c = new Colour(r, g, b);
  }

  void SetType(M_TYPE mType)
  {
    m.SetType(mType);
    c = m.c;
    originalC = m.c;
    mass = m.mass;
  }

  void MakeBox(float w, float h)
  {
    theWidth = w;
    theHeight = h;

    //time to add image! uv's baby
    Point TL = new Point(0, 0, 0, 0);
    Point TR = new Point(w, 0, 1, 0);
    Point BR = new Point(w, h, 1, 1);
    Point BL = new Point(0, h, 0, 1);

    baseShape.add(TL);
    baseShape.add(TR);
    baseShape.add(BR);
    baseShape.add(BL);

    for (Point p : baseShape)
    {
      shape.add(new Point(p.x, p.y));
    }
  }

  void MakeRotBox(float w, float h)
  {
    theWidth = w;
    theHeight = h;

    float halfWidth = theWidth * 0.5;
    float halfHeight = theHeight * 0.5;

    baseShape.clear();
    shape.clear();

    Point TL = new Point(-halfWidth, -halfHeight, 0, 0);
    Point TR = new Point(halfWidth, -halfHeight, 1, 0);
    Point BR = new Point(halfWidth, halfHeight, 1, 1);
    Point BL = new Point(-halfWidth, halfHeight, 0, 1);

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

  boolean CheckPoints(float px, float py)
  {
    //is my point
    Point p = new Point(px, py);

    for (Point axis : normals)
    {
      axis = Normalize(axis);

      Container shapeProjection = DotPointsToAxis(axis);

      float dot = p.x * axis.x + p.y * axis.y;
      if (dot < shapeProjection.GetMin() || dot > shapeProjection.GetMax())
      {
        return false;
      }
    }

    return true;
  }


  float AngleToRad(float angle)
  {
    angle *= PI/180;
    return angle;
  }

  void Rotate(float angle)
  {

    this.angle += AngleToRad(angle);
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

      forceOnObjectBasedOnMass = mass * gravity;//not realistic, but adds 'polish' feel
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
    ArrayList<Point> axes = new ArrayList<Point>();
    axes.addAll(normals);
    axes.addAll(otherShape.normals);

    float smallestOverlap = Float.MAX_VALUE;
    Point bestAxis = new Point();

    for (Point axis : axes)
    {
      axis = Normalize(axis);

      Container one = DotPointsToAxis(axis);
      Container two = otherShape.DotPointsToAxis(axis);

      if (one.GetMax() < two.GetMin() || two.GetMax() < one.GetMin())
      {
        hasPlayedCollisionSound = false;
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

    if (Math.abs(bestAxis.y) > Math.abs(bestAxis.x))
    {

      boolean thisMoving = abs(velocityY) > 0.1;
      boolean otherMoving = abs(otherShape.velocityY) > 0.1;

      changeVector = new Point(0, bestAxis.y * smallestOverlap);

      if (bestAxis.y < 0)
      {
        changeVector = new Point(0, smallestOverlap);

        if (bestAxis.y < 0)
        {
          isGrounded = true;
          otherShape.isGrounded = true;

          posY -= smallestOverlap;
          velocityY = 0;
          if (abs(angularVelocity) < 1)
          {
            angularVelocity = 0;
            otherShape.angularVelocity = 0;
          }

          if (isGrounded)
          {
            angularVelocity = 0;
            otherShape.angularVelocity = 0;
          }
        }
      }

      Point centerA = GetCenter();
      Point centerB = otherShape.GetCenter();

      float offsetX = centerA.x - centerB.x;
      float torque = offsetX / (theWidth * 0.5);

      if (abs(torque) > 0.1)
      {
        if (thisMoving && !otherMoving)
        {
          angularVelocity += torque * spinSpeed;
        } else if (!thisMoving && otherMoving)
        {
          otherShape.angularVelocity -= torque * spinSpeed;
        } else
        {
          angularVelocity += torque * spinSpeed * 0.5;
          otherShape.angularVelocity -= torque * spinSpeed * 0.5;
        }
      }

      velocityY = 0;
    } else
    {

      changeVector = new Point(bestAxis.x * smallestOverlap, 0);
      velocityX = 0;
      otherShape.force = otherShape.mass * accleration;
      otherShape.gotImpulse = true;
    }

    return true;
  }
  float angularVelocity = 0;
  float spinSpeed = 7;

  void Resolution(Box otherShape)
  {
    Translate(changeVector.x * 0.5f, changeVector.y * 0.5f);
    otherShape.Translate(-changeVector.x * 0.5f, -changeVector.y * 0.5f);
  }

  void Resolution()//floor
  {
    //Translate(changeVector.x, changeVector.y);
  }

  void CheckArea()
  {
    if (posY < minY)
    {
      setForDeletion = true;
    }
    if (posY > maxY)
    {
      setForDeletion = true;
    }
    if (posX < minX)
    {
      setForDeletion = true;
    }
    if (posX > maxX)
    {
      setForDeletion = true;
    }
  }

  void PhysicsUpdate()
  {
    if (gotImpulse)
    {
      accleration = force / mass;
      velocityX = accleration;
      force = 0;
      gotImpulse = false;
    }

    angle += angularVelocity * deltaTime;
    angularVelocity *= 0.98; // damping

    float angleDeg = degrees(angle);
    float snapped = round(angleDeg / 90.0) * 90.0;

    if (abs(angleDeg - snapped) < 2 && abs(angularVelocity) < 5)
    {
      angle = radians(snapped);
      angularVelocity = 0;
    }

    posX += velocityX * deltaTime;

    if (velocityX > 0)
    {
      velocityX -= m.kineticFrictionValue * deltaTime;
      if (velocityX < 0) velocityX = 0;
    } else if (velocityX < 0)
    {
      velocityX += m.kineticFrictionValue * deltaTime;
      if (velocityX > 0) velocityX = 0;
    }
  }
  void Update()
  {
    if (!isPaused)
    {
      velocityY += gravity * deltaTime;

      float predictedY = posY + velocityY * deltaTime;

      posY = predictedY;
    }

    isGrounded = false;

    if (posY > maxY)
    {
      posY = maxY;
      velocityY = 0;

      isGrounded = true;

      if (Math.abs(angularVelocity) < 3)
      {
        angularVelocity = 0;
      }
    }

    PhysicsUpdate();
    UpdateBounds();
    CalculateNormals();
  }

  void Draw()
  {
    CheckArea();
    Identity();
    pushMatrix();
    if (m.useTexture)
    {
      beginShape(QUADS);
      texture(m.texture2D);
      vertex(shape.get(0).x, shape.get(0).y, 0, 0);
      vertex(shape.get(1).x, shape.get(1).y, 256, 0);
      vertex(shape.get(2).x, shape.get(2).y, 256, 256);
      vertex(shape.get(3).x, shape.get(3).y, 0, 256);
      endShape(CLOSE);
    } else
    {
      beginShape();
      fill(c.r, c.g, c.b);
      strokeWeight(3);
      for (Point p : shape)
      {
        vertex(p.x, p.y);
      }
      endShape(CLOSE);
    }
    popMatrix();
  }

  float theWidth;
  float theHeight;

  float force = 0;

  float posX;
  float posY;

  float velocityX = 0;
  float velocityY = 0;

  float scaleX = 1;
  float scaleY = 1;

  boolean isSelected = false;
  boolean canClick = false;
  boolean isPaused = true;
  boolean isGrounded = false;
  boolean hasPlayedCollisionSound = false;

  float gravity = 98;
  float forceOnObjectBasedOnMass = 0;//yes unrealistic, but adds a 'polish'

  float angle = 0;
  float accleration = 0;
  float mass = 10;
  float groundRestThreshold = 0.5f;

  ArrayList<Point> shape;
  ArrayList<Point> baseShape;

  ArrayList<Point> normals;
  Point changeVector = new Point();

  Colour c;
  Colour originalC;

  Material m;

  boolean gotImpulse = false;
  boolean setForDeletion = false;

  float minX = 15;
  float maxX = 800;

  float minY = 70;
  float maxY = 550;
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
