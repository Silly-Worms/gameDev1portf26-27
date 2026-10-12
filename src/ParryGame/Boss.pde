class Boss {
  int x, y, w, h, lvl, health;
  PImage boss1;
  
  Boss(int x, int y, int lvl) {
    this.x = x;
    this.y = y;
    this.lvl = lvl;
    w = 200;
    h = 200;
    health = 1500;
    if(lvl == 1) {
      boss1 = loadImage("boss1.png");
    } else if (lvl == 2) {
      boss1 = loadImage("boss2.png");
    }
  }
  
  void display() {
    fill(255,100,100);
    ellipse(x,y,w,h);
  }
  void move() {
  }
}
