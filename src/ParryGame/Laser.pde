class Laser {
  int x, y, w, h, speed, damage;
  PImage bullet;
  float angle;


  Laser(int x, int y, int damage) {
    this.x = x;
    this.y = y;
    w = 5;
    h = 15;
    speed = 3;
    bullet = loadImage("bullet.png");
    this.damage = damage;
    damage = 25;
  }

  void display() {
    //fill(255,0,0);
    //rect(x,y,8,12);
    bullet.resize(30, 30);
    image(bullet, x, y);
  }

  void move() {
    y = y - speed;
    angle += 0.05;
  }

  boolean isOffScreen() {
    if (y < -15) {
      return true;
    } else {
      return false;
    }
  }
}
