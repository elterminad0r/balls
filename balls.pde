ArrayList<Ball> balls;

void setup() {
  size(800, 800);
  balls = new ArrayList<Ball>();
}

void draw() {
  println();
  background(0);
  for (Ball b : balls) {
    b.move();
  }
  for (Ball b : balls) {
    b.handle_collisions();
    b.draw_ball();
  }
}

void keyPressed() {
  switch (keyCode) {
  case ' ':
    balls.add(new Ball());
    break;
  case 'B':
    balls.add(new Ball(20));
    break;
  case 'X':
    balls.add(new Ball(20, new PVector(50, 400), new PVector(5, 0)));
    balls.add(new Ball(20, new PVector(width - 50, 420), new PVector(-5, 0)));
    break;
  case 'R':
    setup();
    break;
  }
}
