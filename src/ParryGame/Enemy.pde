import gifAnimation.*;

class Enemy {
  //member vars
  PImage e1;
  int x, y, size, health, damage, xp, speed;
  boolean isHit;

  //constructor
  Enemy(int x, int y) {
    this.x = x;
    this.y = y;
    size = int(random(50, 100));
    speed = int(random(3, 6));
    health = size * 2;
    isHit = false;
    e1 = loadImage("eyeGrn.png");
  }

  //member methods
  void display() {
    noStroke();
    fill(120);
    e1.resize(size,size);
    image(e1,x,y);
    textAlign(CENTER, CENTER);
    fill(0, 255, 0);
    textSize(20);
    text(health, x, y);
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

  boolean isHit(Laser l) {
    float d = dist(x, y, l.x, l.y);
    if (d < size/3) {
      return true;
    } else {
      return false;
    }
  }
}
