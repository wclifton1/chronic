/**
 * Simple Linear Gradient 
 * 
 * The lerpColor() function is useful for interpolating
 * between two colors.
 */

// Constants
int Y_AXIS = 1;
int X_AXIS = 2;
color b1, b2, warning, stop;
PImage logo;
PImage line;
PFont font;
String rHead="RPM ";
String bHead="Battery ";
String tHead="Torque ";
float critV = 12.5;
float lowV = 14.5;
float v = 16.0;
int rpm = 18000;
float t = 0.300;
PrintWriter output;

void setup() {
  size(1100, 650);
  font = loadFont("PTSans-Regular-48.vlw");
  textFont(font);
  // Define colors
  b1 = color(0);
  b2 = color(100, 102, 119);
  warning = color(240, 145, 72);
  stop = color(162, 25, 25);
  logo = loadImage("logo.png"); // Load the original image
  line = loadImage("line.png"); // Load the original image
  output = createWriter(month()+"-"+day()+" "+hour()+"-"+minute()+"-"+second()+" chronic.txt");

  //noLoop();
}

void draw() {
  // Background

  if (v < lowV) {
    setGradient(0, 0, width, height, b1, warning, Y_AXIS);
  }
  else if (v < critV || rpm < 10000) {
    setGradient(0, 0, width, height, b1, stop, Y_AXIS);
  }
  else {
    setGradient(0, 0, width, height, b1, b2, Y_AXIS);
  }
  image(line, 50, 60);
  image(logo, 120, 30);
  text(rHead, 80, 300);
  text(rpm, 250, 300);
  text(tHead, 80, 450);
  text(t, 250, 450);
  text(bHead, 80, 600);
  text(v, 250, 600);
  output.println(month()+"/"+day()+","+hour()+":"+minute()+":"+second()+","+rpm+","+t+","+v);
}

void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

  noFill();

  if (axis == Y_AXIS) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  }  
  else if (axis == X_AXIS) {  // Left to right gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
  }
}

