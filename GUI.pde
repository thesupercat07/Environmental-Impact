import peasy.*;

Slider[] sliders = new Slider[6];
float xIncrement = 0;
float yIncrement;

String[] labels = {"Meat Consumption", "Dairy Consumption", "Disposables Use", "Zero Waste Use", "Recycling and Upcycling", "Proper Recycling"};

PShape planetSphere;
PImage planetTexture;

float yRotation = 1.0;
float zRotation = 23;

float score;

PShape cowShape;
PImage cowFur;

void setup() {
  //fullScreen(P3D);
  size(640, 400, P3D);
  initializeOverloadedSliders();
  initializePlanet();
  
  cowShape = loadShape("cow.obj");
  cowFur = loadImage("cowFur.png");
}

void draw() {
  background(#060115); // dark blue/purple
  rotatePlanet();
  drawSliders();
  drawLabels();
  drawSliderPieces(); 
  
  fill(255,255,255);
  translate(0,height-40,0);
  rect(0,0, 40,40);
  fill(0,0,0);
  textSize(15);
  text(pmouseX, 15, 10);
  text(pmouseY, 15, 30);
  
}

// ==================================================
void initializeOverloadedSliders() { 
  for (int i = 0; i < sliders.length; i++) {
    xIncrement = width/12 + xIncrement;
    sliders[i] = new Slider(xIncrement);
    xIncrement = width/20 + xIncrement;
  }
}

void initializePlanet() {
  noStroke();
  planetSphere = createShape(SPHERE, height/2);
  planetTexture = loadImage("planetTexture.png");
  planetSphere.setTexture(planetTexture);
}

// ---------------------------------------------------
void rotatePlanet() {
  pushMatrix();
    translate(width/2, height); 
      rotateZ(zRotation);
        rotateY(yRotation); 
          shape(planetSphere);
  popMatrix();
  
  yRotation -= 0.01;
}

// ---------------------------------------------------
void drawSliders() {
  pushMatrix();
    translate(width/12,0,0);
  for (int i = 0; i < sliders.length; i++) {
    sliders[i].createSlider();
  }
  popMatrix();
}

void drawSliderPieces() {
  for (int i = 0; i < sliders.length; i++) {
    sliders[i].checkForSliding();
    
    if (sliders[0].checkIfHovering() && mousePressed) {
      sliders[0].meatScore = map(returnScore(), 47,113, 1,0);
    }
    if (sliders[1].checkIfHovering() && mousePressed) {
      sliders[0].dairyScore = map(returnScore(), 47,113, 0,1);
    }
    if (sliders[2].checkIfHovering() && mousePressed) {
      sliders[0].disposablesScore = map(returnScore(), 47,113, 0,1);
    }
    if (sliders[3].checkIfHovering() && mousePressed) {
      sliders[0].zerowasteScore = map(returnScore(), 47,113, 0,1);
    }
    if (sliders[4].checkIfHovering() && mousePressed) {
      sliders[0].upcyclingScore = map(returnScore(), 47,113, 0,1);
    }
    if (sliders[5].checkIfHovering() && mousePressed) {
      sliders[0].recyclingScore = map(returnScore(), 47,113, 0,1);
    }
  }
  println(sliders[0].calculateImpactScore());
  //println(sliders[0].meatScore, sliders[0].recyclingScore);
  //println(sliders[0].yPosition, sliders[0].sliderHeight);
}

void drawLabels() {
  for (int i = 0; i < sliders.length; i++) {
      fill(255,255,255);
      textSize(width/80);
      textAlign(CENTER);
      text(labels[i], sliders[i].xPosition + width/12, sliders[i].sliderHeight + sliders[i].yPosition);
  }
}

// ---------------------------------------------------
float returnScore() {
  return score = lerp(sliders[0].yPosition/2 + (sliders[0].yPosition/2 - sliders[0].sliderHeight/2), sliders[0].yPosition + sliders[0].sliderHeight/2, pmouseY/100);
}
