class Slider {
  float sliderLength;
  float sliderHeight;
  float xPosition;
  float yPosition;
  float zPosition;
  
  float pieceLength;
  float pieceHeight;
  float yPos;
  
  float meatScore;
  float dairyScore;
  float disposablesScore;
  float zerowasteScore;
  float upcyclingScore;
  float recyclingScore;
  float impactScore;
  
  Slider() {
    sliderLength = width / 45;
    sliderHeight = height / 6;
    xPosition = 0;
    yPosition = 0;
    zPosition = 0;
  }
  
  Slider(float xPos) {
    sliderLength = width / 45;
    sliderHeight = height / 6;
    xPosition = xPos;
    yPosition = height / 5;
    zPosition = 0;
    
    pieceLength = 5 * sliderLength / 4;
    pieceHeight = sliderHeight / 8;
    yPos = yPosition;
    
    meatScore = 0.5;
    dairyScore = 0.5;
    disposablesScore = 0.5;
    zerowasteScore = 0.5;
    upcyclingScore = 0.5;
    recyclingScore = 0.5;
    impactScore = 0.5;
  }
  
  // ==================================================
  void createSlider() {
    pushMatrix();
      translate(xPosition, yPosition, zPosition);
      fill(255,255,255);
      box(sliderLength, sliderHeight, 15);
    popMatrix();
  }
  
   boolean checkIfHovering() {
    if (pmouseX >= (this.xPosition + width/12) - sliderLength && pmouseX <= (this.xPosition + width/12) + sliderLength
      && pmouseY <= this.yPosition + (sliderHeight/2) && pmouseY >= this.yPosition - (sliderHeight/2)) {
      return true;
    } else {
      return false;
    }
  }
  
  void checkForSliding() {
    if (checkIfHovering() && mousePressed) {
      yPos = pmouseY;  
    } 
      sliderPiece(yPos);
  }
 
  void sliderPiece(float y) {
    yPos = y;
    pushMatrix();
      translate(xPosition + width/12, yPos, zPosition);
      fill(#FFF700); // yellow
      box(pieceLength, pieceHeight, 22);
    popMatrix();
  }
  
  // ---------------------------------------------------
  float calculateImpactScore() { // ~ -0.005(good), 0.5 (neutral), 1.005 (bad)
    impactScore = (recyclingScore + upcyclingScore + zerowasteScore - disposablesScore - dairyScore - meatScore) / 6;
    return map(impactScore, -0.33,0.33, 0.0,1.0);
}
  
} // end of Slider class