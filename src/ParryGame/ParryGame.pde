// Torbjorn Harvey | 16 Sept 2026 | ParryGame
import gifAnimation.*;
import processing.sound.*;
SoundFile laser1;
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<PowerUp> pwrUps = new ArrayList<PowerUp>();
ArrayList<Laser> lasers = new ArrayList<Laser>();
Player eye1;
Boss b1;
Timer eDist, pwDist, bossFreq;
int scr, enemyCount, enemiesPassed, laserDmg, lvl;

void setup() {
  size(1200, 900);
  //enemies.add(new Enemy(int(random(width)), -80));
  //pwrUps.add(new PowerUp(int(random(width)), -80));
  eye1 = new Player(width/2, height/2);
  eDist = new Timer(1500);
  pwDist = new Timer(6000);
  bossFreq = new Timer(40000);
  bossFreq.start();
  eDist.start();
  pwDist.start();
  scr = 0;
  enemyCount = 0;
  enemiesPassed = 0;
  laser1 = new SoundFile(this, "laser.mp3");
  laserDmg = 25;
  lvl = 1;
  
}

void draw() {
  background(0);

  if (eye1.health < 0) {
    eye1.health = 0;
  }

  if (eDist.isFinished() == true) {
    enemies.add(new Enemy(int(random(width)), -80));
    eDist.start();
    enemyCount++;
  }

  //power ups
  if (pwDist.isFinished()) {
    pwrUps.add(new PowerUp(int(random(width)), -80));
    pwDist.start();
  }

  eye1.display();
  eye1.move(mouseX, mouseY);
  if (eye1.health <= 0 || enemiesPassed >= 10) {
    gameOver();
  }

  //rocks
  for (int i = 0; i < enemies.size(); i++) {
    println("Enemies: " + enemies.size());
    Enemy e = enemies.get(i);
    e.display();
    e.move();
    //add isHit()
    if (eye1.isHit(e)) {
      enemies.remove(e);
      scr += e.health/18;
      eye1.health -= e.health/3;
    }

    if (e.isOffScreen() == true) {
      enemies.remove(e);
      enemiesPassed += 1;
    }
  }

  //lasers
  for (int i = 0; i < lasers.size(); i++) {
    println("Lasers: " + lasers.size());
    Laser l = lasers.get(i);
    for (int j = 0; j < enemies.size(); j++) {
      Enemy e = enemies.get(j);
      if (e.isHit(l)) {
        // increment score
        e.health -= l.damage;
        // remove enemy & laser
        if (e.health <= 0) {
          enemies.remove(e);
        }
        lasers.remove(l);
      }
    }

    l.display();
    l.move();

    if (l.isOffScreen() == true) {
      lasers.remove(l);
    }
  }
  //powerups
  for (int i = 0; i < pwrUps.size(); i++) {
    println("Power Ups: " + pwrUps.size());
    PowerUp pw = pwrUps.get(i);
    pw.display();
    pw.move();
    //add isHit()
    if (pw.isHit(eye1)) {
      //what power up type
      if (pw.type == 'H') {
        pwrUps.remove(pw);
        eye1.health += 50;
      } else if (pw.type == 'D') {
        laserDmg += 1;
        pwrUps.remove(pw);
      } else if (pw.type == 'T') {
        eye1.turretCount += 1;
        pwrUps.remove(pw);
      }
      //increase hp of player
    }
    if (pw.isOffScreen() == true) {
      pwrUps.remove(pw);
    }
  }
  infoPanel();
}

void mousePressed() {
  if (eye1.turretCount == 1) {
    lasers.add(new Laser(eye1.x, eye1.y, laserDmg));
    //if (!laser1.isPlaying()) {
    //  laser1.play();
    //}
  } else if (eye1.turretCount == 2) {
    lasers.add(new Laser(eye1.x - 20, eye1.y, laserDmg));
    lasers.add(new Laser(eye1.x + 20, eye1.y, laserDmg));
  } else if (eye1.turretCount == 3) {
    lasers.add(new Laser(eye1.x, eye1.y, laserDmg));
    lasers.add(new Laser(eye1.x - 20, eye1.y, laserDmg));
    lasers.add(new Laser(eye1.x + 20, eye1.y, laserDmg));
  }
}

//add infoPanel()
void infoPanel() {
  fill(100, 180, 255, 150);
  rectMode(CORNER);
  noStroke();
  rect(0, 0, width, 50);
  strokeWeight(4);
  stroke(100, 230, 230);
  fill(0, 0);
  rect(0, 0, width, 50);
  textSize(30);
  fill(160, 210, 255, 225);
  textAlign(CENTER);
  text("Score: " + scr, 70, 35);
  text("Enemies: " + enemyCount, 1000, 35);
  text("Health: " + eye1.health, 400, 35);
  text("Enemies Passed: " + enemiesPassed, 700, 35);
}

void gameOver() {
  rectMode(CENTER);
  noStroke();
  fill(150, 80);
  rect(width/2, height/2, width, 200);
  fill(185, 100, 100);
  textSize(100);
  text("You Died", width/2, height/2);
  noLoop();
}
