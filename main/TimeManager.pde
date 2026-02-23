//TIME is global, accesable anywhere

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
//I thought maybe of having a different version of time could prove helpful, never ended up using this, though, could be neat to use 
void CalculateFixedDeltaTime()
{
  float fixedCurrentTime = millis();
  
  fixedDeltaTime = (fixedCurrentTime - fixedPreviousTime) / 4000.0;
  
  fixedPreviousTime = fixedCurrentTime;

}
