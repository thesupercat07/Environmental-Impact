import peasy.*;

Slider[] sliders = new Slider[6];
float xIncrement = 0;
float yIncrement;

String[] labels = {"Meat Consumption", "Dairy Consumption", "Plastic Use", "Disposables Use", "Recycling and Upcycling", "Proper Recycling"};

PShape planetSphere;
PImage planetTexture;

float yRotation = 1.0;
float zRotation = 23;

void setup() {
  //fullScreen(P3D);
  size(640, 400, P3D);
  initializeOverloadedSliders();
  initializePlanet();
}

void draw() {
  background(#060115); // dark blue/purple
  rotatePlanet();
  drawSliders();
  drawLabels();
  
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
void drawSliders() {
  pushMatrix();
    translate(width/12,0,0);
  for (int i = 0; i < sliders.length; i++) {
    sliders[i].createSlider();
    sliders[i].sliderPiece(sliders[i].yPosition);
  }
  //sliders[0].sliderPiece(sliders[0].yPosition);
  //sliders[1].sliderPiece(sliders[1].yPosition);
  //sliders[2].sliderPiece(sliders[2].yPosition);
  //sliders[3].sliderPiece(sliders[3].yPosition);
  //sliders[4].sliderPiece(sliders[4].yPosition);
  //sliders[5].sliderPiece(sliders[5].yPosition);
  popMatrix();
}

void drawLabels() {
  for (int i = 0; i < sliders.length; i++) {
      fill(255,255,255);
      //textSize(17);
      textSize((width * height) / 28500);
      textAlign(CENTER);
      text(labels[i], sliders[i].xPosition + width/12, sliders[i].sliderHeight + sliders[i].yPosition);
  }
}

void rotatePlanet() {
  pushMatrix();
    translate(width/2, height); 
      //rotateZ(zRotation);
        //rotateY(yRotation); 
          shape(planetSphere);
  popMatrix();
  
  yRotation -= 0.01;
}

void mouseDragged() { 
  for (int i = 0; i < sliders.length; i++) {
    
    if (pmouseX >= (sliders[i].xPosition + width/12) - sliders[i].sliderLength && pmouseX <= (sliders[i].xPosition + width/12) + sliders[i].sliderLength)
      //&& pmouseY <= sliders[i].yPosition + sliders[i].pieceHeight && pmouseY >= sliders[i].yPosition)
      {
        sliders[i].sliderPiece(pmouseY);
        println("slider " + i + " is clicked at " + pmouseX);
      } 
  }
}
