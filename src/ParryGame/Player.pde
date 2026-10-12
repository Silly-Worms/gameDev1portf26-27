class Player {
  //member vars
  int x, y, totalFrames, currentFrame, health, turretCount;
  PImage p1;

  //constructor
  Player(int x, int y) {
    this.x = x;
    this.y = y;
    totalFrames = 7;
    p1 = loadImage("ship.png");
    currentFrame = frameCount % totalFrames;
    health = 150;
    turretCount = 1;
  }
  //member methods
  void display() {
    imageMode(CENTER);
    image(p1, x, y);
  }

  void move(int tempX, int tempY) {
    x = tempX;
    y = tempY;
    
    if (y < height-100) {
      y = height-100;
    }
  }

  boolean isHit(Enemy e) {
    float d = dist(x, y, e.x, e.y);
    if (d < 50) {
      return true;
    } else {
      return false;
    }
  }
}
