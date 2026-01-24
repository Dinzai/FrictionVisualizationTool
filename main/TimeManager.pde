float deltaTime;
float previousTime;

float fixedDeltaTime;
float fixedPreviousTime;

void CalculateDeltaTime()
{
  float currentTime = millis();
  
  deltaTime = (currentTime - previousTime) / 1000.0;
  
  previousTime = currentTime;

}

void CalculateFixedDeltaTime()
{
  float fixedCurrentTime = millis();
  
  fixedDeltaTime = (fixedCurrentTime - fixedPreviousTime) / 300.0;
  
  fixedPreviousTime = fixedCurrentTime;

}
