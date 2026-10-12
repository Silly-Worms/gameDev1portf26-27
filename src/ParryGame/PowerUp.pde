class PowerUp {
  //member vars
  int x, y, size, speed;
  char type;
  boolean isHit;
  PImage pw1;

  //constructor
  PowerUp(int x, int y) {
    this.x = x;
    this.y = y;
    size = int(random(35, 55));
    speed = int(random(1, 6));
    if (random(3)>2.0) {
      type = 'H';
      //pw1 = loadImage("pwUp01.png");
    } else if (random(4) > 1.0) {
      type = 'T';
      //pw1 = loadImage("pwUp02.png");
    } else {
      type = 'D';
      //pw1 = loadImage("pwUp03.png");
    }
    isHit = false;
  }

  //member methods
  void display() {
    fill(200, 255, 255);
    ellipse(x, y, size, size);
    fill(0);
    text(type, x, y);
  }

  void move() {
    y += speed;
  }

  boolean isOffScreen() {
    if (y > height + size/2) {
      return true;
    } else {
      return false;
    }
  }

  //add isHit()
  boolean isHit(Player p) {
    float d = dist(x, y, p.x, p.y);
    if (d<35) {
      return true;
    } else {
      return false;
    }
  }
}
