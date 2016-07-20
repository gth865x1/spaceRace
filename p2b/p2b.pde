//Catherine Chapman
//CS3451

/*for my instancing, I have three instances of my 2A Hero within the scene.
for my rotation - I have a clock with rotating hands, and my hero rotates from his home to his friends
for my translation - I have their ship taking flight */

// 3D Scene Example

import processing.opengl.*;

float time = 0;  // keep track of passing of time

void setup() {
  size(1500, 750, P3D);  // must use 3D here !!!
  noStroke();           // do not draw the edges of polygons
}

// Draw a scene with a cylinder, a sphere and a box
void draw() {

  resetMatrix();  // set the transformation matrix to the identity (important!)

  background(240, 252, 255);  // clear the screen to bluish white

  // set up for perspective projection
  perspective (PI * 0.333, 1.0, 0.01, 1000.0);

  // place the camera in the scene (just like gluLookAt())

  camera(0, 0.0, 86.0, 0.0, 0.0, -1.0, 0.0, 1.0, 0.0);



  // create an ambient light source
  ambientLight (102, 102, 102);

  // create directional light sources
  lightSpecular (204, 204, 204);
  directionalLight (152, 152, 152, 0, 0, -1);


  //Draw the hero alien

  if (time > 0 && time <= 45) {

    pushMatrix();
    translate(0, -13, 0);
    translate(-22, 10, 0);
    scale(.25, .5, .25);
    drawAlien();
    popMatrix();

    //drawclock
    pushMatrix();
    translate(-40, -30, 0);
    rotate(57, 0, 1, 0);
    drawClock();
    popMatrix();

    //draw table
    pushMatrix();
    translate(-33, 8, 2);
    scale(1, 1, 2);
    drawTable();
    popMatrix();
  }

  if (time > 45 && time <64) {
    camera (0, 0.0, time+15, 0, 0.0, -1.0, 0.0, 1.0, 0.0);
    
    directionalLight (249, 250, 87, 0, 0.5, 0);

    pushMatrix();
    rotate(.1388889*time, 0, 1.0, 0);
    translate(0, -13, 0);
    translate(-22, 10, 0);
    scale(.25, .5, .25);
    drawAlien();
    popMatrix();
    
  }
  if (time >= 36 && time <=64) {

    //draw two moreinstances of aliens - he's late to meet his buddies, oh no!
    pushMatrix();
    translate(10, 0, 3);
    scale(.25, .5, .25);
    drawAlien();
    popMatrix();

    pushMatrix();
    translate(36, 0, 3);
    scale(.25, .5, .25);
    rotate(95, 0, -1.0, 0);
    drawAlien();
    popMatrix();

    //draw spaceship
    pushMatrix();
    translate(26, -8, -10);
    scale(1, 1, 1.75);
    spaceship();
    popMatrix();
  }

  if (time > 64) {
    //time for their flight to leave!
    camera (0, 0.0, 75, 0, 0.0, -1.0, 0.0, 1.0, 0.0);
    pushMatrix();
    translate(0, -0.9*time, 0);

    translate(26, 36, -10);
    scale(1, 1, 1.75);
    spaceship();
    popMatrix();
  }

  // step forward in time
  time += 0.05;
  //println(time);
}

// Draw a cylinder of a given radius, height and number of sides.
// The base is on the y=0 plane, and it extends vertically in the y direction.
void cylinder (float radius, float height, int sides) {
  int i, ii;
  float []c = new float[sides];
  float []s = new float[sides];

  for (i = 0; i < sides; i++) {
    float theta = TWO_PI * i / (float) sides;
    c[i] = cos(theta);
    s[i] = sin(theta);
  }

  // bottom end cap

  normal (0.0, -1.0, 0.0);
  for (i = 0; i < sides; i++) {
    ii = (i+1) % sides;
    beginShape(TRIANGLES);
    vertex (c[ii] * radius, 0.0, s[ii] * radius);
    vertex (c[i] * radius, 0.0, s[i] * radius);
    vertex (0.0, 0.0, 0.0);
    endShape();
  }

  // top end cap

  normal (0.0, 1.0, 0.0);
  for (i = 0; i < sides; i++) {
    ii = (i+1) % sides;
    beginShape(TRIANGLES);
    vertex (c[ii] * radius, height, s[ii] * radius);
    vertex (c[i] * radius, height, s[i] * radius);
    vertex (0.0, height, 0.0);
    endShape();
  }

  // main body of cylinder
  for (i = 0; i < sides; i++) {
    ii = (i+1) % sides;
    beginShape();
    normal (c[i], 0.0, s[i]);
    vertex (c[i] * radius, 0.0, s[i] * radius);
    vertex (c[i] * radius, height, s[i] * radius);
    normal (c[ii], 0.0, s[ii]);
    vertex (c[ii] * radius, height, s[ii] * radius);
    vertex (c[ii] * radius, 0.0, s[ii] * radius);
    endShape(CLOSE);
  }
}

void drawHead() {
  //Method draws the head, eyes, and antenna for the figure


  //Antenna
  pushMatrix();

  // diffuse (fill), ambient and specular material properties
  fill (196, 222, 27);       // "fill" sets both diffuse and ambient color (yuck!)
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (5.0);            // set specular exponent

  translate (0, -20, 0);
  cylinder (1.25, 10.0, 32);
  translate(0, -1.70, 0);
  sphere(2.0);

  popMatrix();

  //Head
  pushMatrix();

  fill (196, 222, 27);
  ambient (50, 50, 50);
  specular (150, 150, 150);
  shininess (5.0);

  sphereDetail (40);
  scale(1.35, .80, 1);
  sphere(13);

  popMatrix();

  //Ears
  pushMatrix();
  fill (196, 250, 27); 
  ambient (50, 50, 50);
  specular (150, 150, 150);
  shininess (5.0);
  translate(-19.0, -10, 0);
  rotate(30, 0, 0, -1.0);
  scale(1.25, 1.25, 1.25);
  drawEar();
  popMatrix();

  pushMatrix();
  fill (196, 250, 27); 
  ambient (50, 50, 50);
  specular (150, 150, 150);
  shininess (5.0);
  translate(17.0, 0, 0);
  rotate(30, 0, 0, 1.0);
  scale(1.25, 1.25, 1.25);
  drawEar();
  popMatrix();


  //Eyes
  //Eye 1
  pushMatrix();
  fill(255);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (5.0);            // set specular exponent
  translate(0, -3.5, 10.5);
  sphere(3.0);
  popMatrix();

  //pupil 1
  pushMatrix();
  fill(0);
  translate(0, -4.0, 13.15);
  rotate(90, 1.0, 0, 0);
  cylinder(.55, .50, 32);
  popMatrix();

  //Eye 2
  pushMatrix();
  fill(255);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (5.0);            // set specular exponent
  translate(-6, -3.05, 10);
  sphere(3.0);
  popMatrix();

  //pupil 2
  pushMatrix();
  fill(0);
  translate(-5.75, -3.35, 12.80);
  rotate(90, 1.0, 0, 0);
  cylinder(.55, .50, 32);
  popMatrix();


  //Eye 3
  pushMatrix();
  fill(255);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (5.0);            // set specular exponent
  translate(6, -3.05, 10);
  sphere(3.0);
  popMatrix();

  //pupil 3
  pushMatrix();
  fill(0);
  translate(5.75, -3.35, 12.80);
  rotate(90, 1.0, 0, 0);
  cylinder(.55, .50, 32);
  popMatrix();

  //Mouth

  pushMatrix();
  fill(0);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (5.0);   
  //rotate(0, 0, 0, 0);
  translate(0, 3, 2.80);
  cylinder(12, .25, 32);
  translate(0, 0, 9.5);
  rotate(79, 1.0, 0, 0);
  cylinder(3, .1, 32);
  popMatrix();

  pushMatrix();
  fill(0);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (5.0);   
  translate(0, 2.61, 12.5);
  rotate(40, 1.0, 0, 0);
  cylinder(3, .1, 32);
  popMatrix();
}

void drawBody() {
  //Draw top of uniform
  pushMatrix();
  fill(90, 48, 109);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (5.0);

  translate(0, 7.90, 0);
  scale(1.25, .2, 1);

  sphere(13);
  popMatrix();

  //draw body
  pushMatrix();
  fill(15, 108, 166);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (5.0);

  sphereDetail (40);

  translate(0, 22, 0);
  scale(1.25, 1.25, .99);
  sphere(13);
  popMatrix();


  //uniform detail
  pushMatrix();
  fill(200, 115, 49);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (3.0);

  translate(6, 15, 9);

  sphere(3);
  popMatrix();

  pushMatrix();
  fill(242, 221, 34);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (3.0);
  translate(6.25, 15, 10);
  rotate(-60, 0, 0, 1.0);
  cylinder(3.3, .2, 32);
  popMatrix();


  //draw arms

  drawArms();

  //draw belt
  pushMatrix();
  fill(35, 50, 73);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (3.0);
  translate(0, 23, 0);
  scale(1.11, 1, 1);
  cylinder(15, 2, 32);
  popMatrix();

  pushMatrix();
  fill(35, 50, 73);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (3.0);
  translate(0, 24, 14.75);
  scale(1.75, 1, .75);
  box(2.5);
  popMatrix();

  //draw legs and shoes
  drawLegs();
}

void drawArms() {

  //draw shoulders
  //shoulder1
  pushMatrix();
  fill(15, 108, 166);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (5.0);
  translate(-13.65, 12, 0);
  sphere(3.52);
  popMatrix();

  //arm 1
  pushMatrix();
  fill(15, 108, 166);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (5.0);
  translate(-14.40, 12.19, 1.5);
  rotate(30, -1, 0, -1.0);
  cylinder(3.40, 17, 32);
  popMatrix();

  //shoulder2
  pushMatrix();
  translate(13.65, 12, 0);
  sphere(3.52);
  popMatrix();

  //arm 2
  pushMatrix();
  fill(15, 108, 166);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (5.0);
  translate(14.40, 12.19, 1.5);
  rotate(30, -1, 0, 1.0);
  cylinder(3.40, 17, 32);
  popMatrix();

  //hand 1
  pushMatrix();
  drawHand();
  popMatrix();

  //hand 2
  pushMatrix();
  translate(-5, 8.65, 4.15);
  rotate(180, 0, -.5, 1.0);
  drawHand();
  popMatrix();
}

void drawEar() {
  float x1 = 0;
  float y1 = 0;


  float x2 = x1+4;
  float x3 = x2+5;

  float y2 = y1-5;
  float y3 = y2+4.5;

  float i = 0;
  while (i<1) {
    beginShape(TRIANGLES);
    vertex(x1, y1, i);
    vertex(x2, y2, i);
    vertex(x3, y3, i);
    endShape(CLOSE); 
    i +=.15;
  }
}

void drawLegs() {

  //leg 1
  pushMatrix();
  fill(15, 108, 166);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (5.0);
  translate(-5.75, 30, 0);
  cylinder(6.6, 20, 32);
  popMatrix();

  //leg2
  pushMatrix();
  fill(15, 108, 166);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (5.0);
  translate(5.75, 30, 0);
  cylinder(6.6, 20, 32);
  popMatrix();  

  //shoes
  //shoe 1
  pushMatrix();
  fill(35, 50, 73);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (3.0);
  translate(-5.75, 52, 1);
  rotate(35, 0, -1.0, 0);
  scale(1.5, 1, 1.9);
  sphere(4.5);
  popMatrix();


  //shoe 2
  pushMatrix();
  fill(35, 50, 73);
  ambient (50, 50, 50);      // set ambient color
  specular (150, 150, 150);   // set specular color
  shininess (3.0);
  translate(5.75, 52, 1);
  rotate(35, 0, 1.0, 0);
  scale(1.5, 1, 1.9);
  sphere(4.5);
  popMatrix();
}

void drawFingers() {
  //fingers
  pushMatrix();
  fill (196, 222, 27);
  ambient (50, 50, 50);
  specular (150, 150, 150);
  shininess (5.0);

  sphereDetail (40);
  //  translate(-30, 30, 13);
  scale(1.2, .5, .8);
  sphere(2.35);

  popMatrix();
}

void drawHand() {
  pushMatrix();
  fill (196, 222, 27);
  ambient (50, 50, 50);
  specular (150, 150, 150);
  shininess (5.0);

  sphereDetail (40);
  translate(-26, 14.75, 13.1);
  sphere(3.25);

  popMatrix();

  //fingers - hand 1
  pushMatrix();
  translate(-29, 18, 14.05);
  rotate(10, 0, 0, -1.0);
  drawFingers();
  popMatrix();

  pushMatrix();
  translate(-29, 13, 15.05);
  rotate(-10, 0.0, 0, -1.0);
  drawFingers();
  popMatrix();

  pushMatrix();
  translate(-26.5, 15.2, 16);
  rotate(90, 0, -1.0, 0);
  drawFingers();
  popMatrix();
}

void drawAlien() {
  //draws the full alien - head and body are split for later purposes
  drawHead();
  drawBody();
}

void spaceship() {
  pushMatrix();
  fill (0, 0, 255);
  ambient (50, 50, 50);
  specular (150, 150, 150);
  shininess (3.0);

  sphereDetail (40);
  translate(0, -10, 0);
  scale(.50, 2, .5);
  sphere(10);
  popMatrix();

  pushMatrix();
  fill(250, 250, 250);
  ambient (50, 50, 50);
  specular (150, 150, 150);
  shininess (3.0);
  translate(0, -9, 0);
  cylinder(5.04, 30, 32);
  popMatrix();

  pushMatrix();
  fill(255, 0, 0);
  ambient (50, 50, 50);
  specular (150, 150, 150);
  shininess (3.0);

  translate(11, 20, 0);
  scale(1.5, 1.5, 1.5);
  rotate(90, 0, 0, -1.0);
  drawEar();
  popMatrix();

  pushMatrix();
  fill(255, 0, 0);
  ambient (50, 50, 50);
  specular (150, 150, 150);
  shininess (3.0);

  translate(-4.75, 9, -1);
  scale(1.5, 1.5, 1.5);
  rotate(90, 0, 0, 1.0);
  drawEar();
  popMatrix();

  pushMatrix();
  fill(255, 0, 0);
  ambient (50, 50, 50);
  specular (150, 150, 150);
  shininess (3.0);
  translate(0, 22, 0);
  box(7.0);
  popMatrix();
}

void drawClock() {
  pushMatrix();
  fill (240, 175, 200);
  ambient (100, 100, 100);
  specular (0, 0, 0);
  shininess (2.0);

  sphereDetail (40);
  scale(1, 1.75, 1);
  sphere(4);
  popMatrix();

  pushMatrix();
  fill(0);
  ambient (100, 100, 100);
  specular (0, 0, 0);
  shininess (2.0);
  rotate(.05*time, 0, 0, 1.0);
  translate(3, 0, 2.5);
  cylinder(2, .3, 32);
  popMatrix();

  pushMatrix();
  fill(0);
  ambient (100, 100, 100);
  specular (0, 0, 0);
  shininess (2.0);
  rotate(30, 0, 0, 1.0);
  translate(3, 0, 2.5);
  scale(1.5, 1, 1);
  cylinder(2, .3, 32);
  popMatrix();
}

void drawTable() {
  //tabletop
  pushMatrix();
  fill (100, 225, 200);
  ambient (100, 100, 100);
  specular (0, 0, 0);
  shininess (2.0);
  cylinder(5, 2, 32);
  popMatrix();

  //table leg
  pushMatrix();
  fill (100, 225, 200);
  ambient (100, 100, 100);
  specular (0, 0, 0);
  shininess (2.0);
  translate(0, 1, 0);
  cylinder(1, 18, 32);
  popMatrix();

  //OJ glass
  pushMatrix();
  fill(250, 250, 250);
  ambient (50, 50, 50);
  specular (150, 150, 150);
  shininess (3.0);
  translate(2, -5, 0.5);
  cylinder(.75, 5, 32);
  popMatrix();

  pushMatrix();
  fill(255, 153, 0);
  ambient (50, 50, 50);
  specular (150, 150, 150);
  shininess (3.0);
  translate(2, -3, 0.5);
  cylinder(.76, 3, 32);
  popMatrix();
}