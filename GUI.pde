import peasy.*;

PeasyCam camera;

Slider[] sliders = new Slider[6];
float xIncrement = 0;
float yIncrement;

String[] labels = {"Meat Consumption", "Dairy Consumption", "Disposables Use", "Zero Waste Use", "Recycling and Upcycling", "Proper Recycling"};

PShape planetSphere;
PImage planetTexture;

float yRotation = 1.0;
float zRotation = 23;
float radius;

float score;

ArrayList<Shape> shapes;
PShape cowShape;
PShape treeShape;
PShape turtleShape;
PShape[] shapeOptions = {cowShape, treeShape, turtleShape};
int numberOfShapes;

PImage cowTexture;
PImage NULL;
PImage turtleTexture;
PImage[] textureOptions = {cowTexture, NULL, turtleTexture};


int index;

void setup() {
  //fullScreen(P3D);
  size(640, 400, P3D);
  
  initializePeasyCam();
  
  radius = height/2;
  
  initializeOverloadedSliders();
  initializePlanet();
  initializeObjectsAndImages();
  initializeShapes();
  
  //for (index = 0; index < shapes.size() -1; index++) {
  //  drawShapes();
  //}
}

void draw() {
  background(#060115); // dark blue/purple
  rotatePlanetAndShapes();
  camera.beginHUD();
    drawSliders();
    drawLabels();
    drawSliderPieces();
    
    resetButton();
  camera.endHUD();
  
  peasyCamOrNot();
  println(sliders[0].calculateImpactScore(), howManyShapesNeeded(), shapes.size());
}

// ==================================================
void initializePeasyCam() {
  //camera = new PeasyCam(this, width/2.0, height/2.0, 0, (height/2.0) / tan(PI*60.0 / 360.0));
  camera = new PeasyCam(this, 1500);
  camera.setMinimumDistance(0);
  camera.setMaximumDistance(450); // 350
}

void initializeOverloadedSliders() { 
  for (int i = 0; i < sliders.length; i++) {
    xIncrement = width/12 + xIncrement;
    sliders[i] = new Slider(xIncrement);
    xIncrement = width/20 + xIncrement;
  }
}

void initializePlanet() {
  noStroke();
  planetSphere = createShape(SPHERE, radius);
  planetTexture = loadImage("planetTexture.png");
  planetSphere.setTexture(planetTexture);
}

void initializeObjectsAndImages() {
  cowShape = loadShape("cowShape.obj");  // file from https://free3d.com/3d-model/cow-v4--997323.html
  treeShape = loadShape("treeShape.obj"); // file from https://free3d.com/3d-model/low-poly-tree-73217.html
  turtleShape = loadShape("turtleShape.obj"); // file from https://free3d.com/3d-model/-sea-turtle-v1--427786.html
  
  cowTexture = loadImage("cowFur.jpg"); // image from https://milkgenomics.org/wp-content/uploads/2013/08/bigstock-dairy-cow-fur-skin-backgroun-40931641.jpg
  NULL = loadImage("NULL.jpg"); // image is an unused placeholder to allow for setFill()
  turtleTexture = loadImage("turtleTexture.jpg"); // image from https://s-media-cache-ak0.pinimg.com/736x/77/23/86/772386b662e4ca88794dbb9463c57ea9.jpg 
}

void initializeShapes() {
  shapes = new ArrayList<Shape>();
  for (int i = 0; i < sliders[0].totalScore * 60; i++) {
    shapes.add(new Shape(radius));
  }
}

// ---------------------------------------------------
void rotatePlanetAndShapes() {
  pushMatrix();
    //translate(0, height/2, 0); // messes up PeasyCam
      //rotateZ(zRotation);
      //rotateY(yRotation);
        planetSphere.scale(1);
          shape(planetSphere);
          drawShapes();
          //if (mousePressed == false) {
          //  translate(-width/2, -height, 0);
          //  checkIfScoreHasChanged();
          //}
  popMatrix();
  
  yRotation -= 0.01;
}

// ---------------------------------------------------
void peasyCamOrNot() {
  if (pmouseY < sliders[0].yPosition + sliders[0].sliderHeight) {
    camera.setActive(false);
  }
  else {
    camera.setActive(true);
  }
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
}

void drawLabels() {
  for (int i = 0; i < sliders.length; i++) {
      fill(255,255,255);
      textSize(width/80);
      textAlign(CENTER);
      text(labels[i], sliders[i].xPosition + width/12, sliders[i].sliderHeight + sliders[i].yPosition);
  }
}

void drawShapes() {
  for (int i = 0; i < shapes.size(); i ++) {
      pushMatrix();
        Shape s = shapes.get(i);
        s.drawShape();
      popMatrix();
    }
}
  
// ---------------------------------------------------
float returnScore() {
  return score = lerp(sliders[0].yPosition/2 + (sliders[0].yPosition/2 - sliders[0].sliderHeight/2), sliders[0].yPosition + sliders[0].sliderHeight/2, pmouseY/100);
}

// ---------------------------------------------------
void checkIfScoreHasChanged() {
  for (int i = 0; i < sliders.length; i++) {
    if (sliders[i].checkIfHovering() && mousePressed) {
      addOrRemoveShapes();
    }
  }
  //if (mousePressed == false) {
  //  drawShapes();
  //}
}

int howManyShapesNeeded() {
  if (shapes.size() ==  0 && sliders[0].calculateImpactScore() == 0.499999994) { return numberOfShapes = 30; }
  if (sliders[0].calculateImpactScore() == 0) { return numberOfShapes = 60; }
  if (sliders[0].calculateImpactScore() == 1) { return numberOfShapes = 0; }
  return numberOfShapes = int(ceil(sliders[0].calculateImpactScore() * 60));
}

void addOrRemoveShapes() {
  for (index = shapes.size(); index < howManyShapesNeeded(); index++) {
    shapes.add(new Shape(radius));  
    drawShapes();
   }

  for (index = shapes.size()-1; index > howManyShapesNeeded(); index--) {
    shapes.remove(index);
    drawShapes();
  }
}

// ---------------------------------------------------
void resetButton() {
  fill(255,0,0);
  pushMatrix();
  translate(width*.92, height - (width*.08));
  rect(0, 0, width*.08, width*.08, 7);
  fill(255,255,255);
  textAlign(CENTER,CENTER);
  text("RESET CAMERA", 0, 0, width*.08, width*.08);
  popMatrix();
}

void mousePressed() {
  if (pmouseX > width*.92 && pmouseY > height-(width*.08)) {
    camera.reset();
  }
}
