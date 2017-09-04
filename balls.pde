class Ball {
  PVector loc, speed, pending_speed;
  float r, mass;

  Ball() {
    loc = new PVector(random(width), random(height));
    speed = PVector.random2D().mult(random(3));
    r = random(3, 7);
    mass = r;
    pending_speed = speed;
  }

  Ball(float _r) {
    r = _r;
    loc = new PVector(random(width), random(height));
    speed = PVector.random2D().mult(random(3));
    mass = r;
    pending_speed = speed;
  }

  Ball(float _r, PVector _loc, PVector _speed) {
    r = _r;
    loc = _loc;
    speed = _speed;
    pending_speed = speed;
    mass = r;
  }

  void handle_walls() {
    if (loc.x < r) {
      speed.x = abs(speed.x);
    } else if (loc.x > width - r) {
      speed.x = -abs(speed.x);
    }

    if (loc.y < r) {
      speed.y = abs(speed.y);
    } else if (loc.y > height - r) {
      speed.y = -abs(speed.y);
    }
  }

  void handle_balls() {
    for (Ball b : balls) {
      if (b != this) {
        if (PVector.dist(loc, b.loc) < r + b.r) {
          PVector diff = PVector.sub(loc, b.loc);
          float phi = diff.heading();
          float v1 = speed.mag();
          float v2 = b.speed.mag();
          float m1 = mass;
          float m2 = b.mass;
          float o1 = speed.heading();
          float o2 = b.speed.heading();

          float rx = ((v1 * cos(o1 - phi) * (m1 - m2) + 2 * m2 * v2 * cos(o2 - phi))/(m1 + m2)) * cos(phi) + v1 * sin(o1 - phi) * cos(phi + HALF_PI);
          float ry = ((v1 * cos(o1 - phi) * (m1 - m2) + 2 * m2 * v2 * cos(o2 - phi))/(m1 + m2)) * sin(phi) + v1 * sin(o1 - phi) * sin(phi + HALF_PI);
          pending_speed = new PVector(rx, ry);
        }
      }
    }
  }

  void move() {
    speed = pending_speed;
    loc.add(speed);
  }

  void handle_collisions() {
    handle_walls();
    handle_balls();
  }

  void draw_ball() {
    ellipse(loc.x, loc.y, r * 2, r * 2);
  }
}

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