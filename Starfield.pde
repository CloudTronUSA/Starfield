int numStars = 300;
int numOddStars = 20;

Star[] stars = new Star[numStars];

void setup() {
  size(800, 500);
  
  // create stars
  for (int i = 0; i < stars.length-numOddStars; i++) {
    stars[i] = new Star();
  }
  for (int i = stars.length-numOddStars; i < stars.length; i++) {
    stars[i] = new OddStar();
  }
}

void draw() {
  background(0);
  translate(width/2, height/2);  // set 0,0 at the center of screen
  
  for (int i = 0; i < stars.length; i++) {
    stars[i].update();
    stars[i].show();
  }
}

// Star //
class Star {
  double x, y, z;  // z is (imaginary) distance between star and screen
  double pz;  // previous z
  
  double speed;  // speed
  double size;  // size
  int sColor;  // color

  Star() {
    speed = 10;
    size = 8;
    sColor = color(255,255,255);
    
    x = random(0, width)-(width/2);
    y = random(0, height)-(height/2);
    z = random(width);  // start at random distance
    pz = z;
  }

  void update() {
    z -= speed;
    
    if (z < 1) {  // touched screen
      z = width;  // new generation - start at max distance
      x = random(0, width)-(width/2);
      y = random(0, height)-(height/2);
      pz = z;
    }
  }

  void show() {
    // new pos
    double x2 = map((float)(x / z), 0, 1, 0, width);  // reflect x-z ratio to screen x
    double y2 = map((float)(y / z), 0, 1, 0, height);  // reflect y-z ratio to screen y

    // old pos
    double x1 = map((float)(x / pz), 0, 1, 0, width);  // reflect x-z ratio to screen x
    double y1 = map((float)(y / pz), 0, 1, 0, height);  // reflect y-z ratio to screen y

    pz = z;

    // Draw star streak
    stroke(sColor, map((float)z, 0, width, 255, 20));
    strokeWeight(map((float)z, 0, width, (float)size, 0)); // Thickness decreases with distance
    line((float)x1, (float)y1, (float)x2, (float)y2);
  }
}

class OddStar extends Star {
  OddStar() {
    speed = 40;
    size = 20;
    sColor = color(255,164,13);
    
    x = random(0, width)-(width/2);
    y = random(0, height)-(height/2);
    z = random(width);  // start at random distance
    pz = z;
  }
}
