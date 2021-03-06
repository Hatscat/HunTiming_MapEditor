String map_url;
PImage map_picture;
int map_size, map_width, map_height;
color wall_color, tower_color, spawnTeam1_color, spawnTeam2_color;
byte version, path_value, wall_value, tower_value, spawnTeam1_value, spawnTeam2_value;
byte[] px;

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
  
  map_size = map_width * map_height;
  size(map_width, map_height);
  px = new byte[map_size+1];
  
  selectInput("Select a file to process : ", "fileSelected");
}

void fileSelected(File selection) {
  
  if (selection == null) exit();
  else
  {
    map_url = selection.getAbsolutePath();
    map_picture = loadImage(map_url);
    if (map_picture == null) exit();
  }
}


void draw() {
  
  if (map_picture != null)
  {
    image(map_picture, 0, 0);
    if (recordData()) exit();
    else background(255, 0, 0);
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
  
  saveBytes(map_url.substring(0, map_url.indexOf(".")) + ".dat", px);
  return true;
}

