//this is a sound manager system used to hold, control, and load sounds for the program
import processing.sound.*;
//this is for different button pressing sounds, since it is a repeated sound
enum UI_SOUND
{
  BUTTON_ONE,
    BUTTON_TWO,
    BUTTON_THREE,
}

enum PHY_SOUND
{
  NONE,
    WOOD,
    METAL,
    ROCK,
    ICE,
}

enum BACKGROUND_MUSIC
{
  TITLE,
    TUTORIAL,
    SIM,
    WIND
}

class SoundManager
{
  SoundManager(PApplet p)//for the sound system to work, it takes in a PApplet, basically, it needs the current programs start to link to
  {
    parrent = p;
    uiSounds = new ArrayList<SoundFile>();
    physicsSounds = new ArrayList<SoundFile>();
    music = new ArrayList<SoundFile>();
  }

  SoundFile SetSound(String name)
  {
    SoundFile tempSound;
    String filePath = "assets/" + name + ".wav";
    tempSound = new SoundFile(parrent, filePath);
    return tempSound;
  }
  //preload
  SoundFile SetSound(String name, boolean preLoadable)
  {
    SoundFile tempSound;
    String filePath = "assets/" + name + ".wav";
    tempSound = new SoundFile(parrent, filePath, preLoadable);
    return tempSound;
  }

  void LoadUISounds()
  {
    uiSounds.add(SetSound("buttonSoundOne"));
    uiSounds.add(SetSound("buttonSoundTwo"));
    uiSounds.add(SetSound("buttonSoundThree"));
  }

  void PlayRandomUI()
  {
    int minimum = 0;
    int maximum = 3;

    int randomChoice = (int)random(minimum, maximum);

    uiSounds.get(randomChoice).stop();
    uiSounds.get(randomChoice).play();
  }

  void StopAllUI()
  {
    for (SoundFile s : uiSounds)
    {
      s.stop();
    }
  }

  void LoadPhysicsSound()
  {
    physicsSounds.add(SetSound("buttonSoundOne"));//should only play on NONE type
    physicsSounds.add(SetSound("woodSmack"));
    physicsSounds.add(SetSound("metalSmack"));
    physicsSounds.add(SetSound("rockSmack"));
    physicsSounds.add(SetSound("iceSmack"));
  }
  
  void PlayPhysicsSound(int num)
  {
    physicsSounds.get(num).stop();
    physicsSounds.get(num).play();
  }

  void LoadBackGroundMusic()
  {
    music.add(SetSound("titleMusic", true));
    music.add(SetSound("tutorialMusic", true));
    music.add(SetSound("simMusic", true));
    music.add(SetSound("windmillMusic", true));
  }

  void StopMusic()
  {
    for (SoundFile m : music)
    {
      m.stop();
    }
  }

  void PlayMusic(int num)
  {
    StopMusic();
    music.get(num).amp(0.1);
    music.get(num).loop();
  }
  
  void LoadAllMusic()
  {
    LoadBackGroundMusic();
  }
  
  void LoadAll()
  {    
    LoadUISounds();
    LoadPhysicsSound();
  }

  PApplet parrent;

  ArrayList<SoundFile> uiSounds;
  ArrayList<SoundFile> physicsSounds;
  ArrayList<SoundFile> music;
}
