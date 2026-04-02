//Clase Confettti para la pantalla de juego ganado
class Confetti {
  float x, y;
  float speedY;
  float speedX;
  float size;
  float angle;
  float rotationSpeed;
  color col;

  Confetti() {
    reset();
    y = random(-height, 0);
  }

  void reset() {
    x = random(width);
    y = random(-100, -10);
    speedY = random(2, 6);
    speedX = random(-1.5, 1.5);
    size = random(6, 12);
    angle = random(TWO_PI);
    rotationSpeed = random(-0.1, 0.1);
    col = color(random(255), random(255), random(255));
  }

  void update() {
    y += speedY;
    x += speedX;
    angle += rotationSpeed;

    if (y > height + 20) {
      reset();
    }
  }

  void display() {
    pushMatrix();
    translate(x, y);
    rotate(angle);
    noStroke();
    fill(col);
    rectMode(CENTER);
    rect(0, 0, size, size * 0.6);
    popMatrix();
  }
}
