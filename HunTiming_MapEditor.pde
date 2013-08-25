String map_name;
PImage map_picture;
int map_size, map_width, map_height;
color wall_color, tower_color, spawnTeam1_color, spawnTeam2_color;
byte version, path_value, wall_value, tower_value, spawnTeam1_value, spawnTeam2_value;
byte[] px;
boolean canPressAKey, isEnterPressed, isErrorMsg;

void setup() {
  
  map_width = 1064;
  map_height = 630;
  wall_color = color(0); // black
  tower_color = color(255,0,0); // red
  spawnTeam1_color = color(0,255,0); // green
  spawnTeam2_color = color(0,0,255); // blue
  version = 1;
  path_value = 0;
  wall_value = 1;
  tower_value = 2;
  spawnTeam1_value = 3;
  spawnTeam2_value = 4;
  canPressAKey = true;
  isEnterPressed = false;
  isErrorMsg = false;
  map_name = "";
  
  map_size = map_width * map_height;
  size(map_width, map_height);
  px = new byte[map_size+1];
  
}

void draw() {
  
  background(255);
  fill(0);
  text("Map file name (whithout \".png\" extension)  : ", 50, 50);
  text(map_name, 300, 50);
  fill(255,0,0);
  if (isErrorMsg) text("ERROR : This file is missing or inaccessible. Make sure the URL is valid.", 75, 75);
  
  map_name = writeString(map_name);
  
  if (isEnterPressed)
  {
    isEnterPressed = false;
    map_picture = loadImage(map_name + ".png");
    
    if (map_picture != null)
    {
      image(map_picture, 0, 0);
      if (recordData()) exit();
    }
    else isErrorMsg = true;
  }
}

boolean recordData() {
  
  px[0] = version;
  loadPixels();
  
  for (int i = 0; i < map_size; i++) {
    
    if (pixels[i] == wall_color) px[i+1] = wall_value;
    else if (pixels[i] == tower_color) px[i+1] = tower_value;
    else if (pixels[i] == spawnTeam1_color) px[i+1] = spawnTeam1_value;
    else if (pixels[i] == spawnTeam2_color) px[i+1] = spawnTeam2_value;
    else px[i+1] = path_value;
  }
  
  saveBytes(map_name + ".dat", px);
  return true;
}

String writeString(String s) {
  
  if (keyPressed && canPressAKey)
  {
    canPressAKey = false;
    isErrorMsg = false;
    if (key != CODED)
    {
      if (key == RETURN || key == ENTER) isEnterPressed = true;
      else if (key == BACKSPACE && s.length() > 0) s = s.substring(0, s.length() - 1);
      else if (key != BACKSPACE) s += key;
    }
  }
  return s;
}

void keyReleased() {
  
  canPressAKey = true;
}

