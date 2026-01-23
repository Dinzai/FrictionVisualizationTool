float deltaTime;
float previousTime;

void CalculateDeltaTime()
{
  float currentTime = millis();
  
  deltaTime = (currentTime - previousTime) / 1000.0;
  
  previousTime = currentTime;

}
