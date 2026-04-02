class Button{
  PImage image;
  float xPos, yPos;
  int imgWidth, imgHeight;
  String function; //función del botón
  boolean wasHovered = false; //Para controlar sonidos
  
  Button(PImage _image, float _xPos, float _yPos, String _function){
    image = _image;
    xPos = _xPos;
    yPos = _yPos;
    function = _function;
    imgWidth = image.width;
    imgHeight = image.height;
  }
  
  void display(){
    if(mouseOver()){
      image(image, xPos, yPos, imgWidth + 5, imgHeight + 2);
      if(!wasHovered){
        buttonOver.play();
      }
    } else {
      image(image, xPos, yPos, imgWidth, imgHeight);
    } 
    wasHovered = mouseOver();
  }
  
  //Método para comprobar si el cursor está sobre el botón
  boolean mouseOver(){
    float halfW = imgWidth / 2;
    float halfH = imgHeight / 2;
    boolean xArea = mouseX >= xPos - halfW && mouseX <= xPos + halfW;
    boolean yArea = mouseY >= yPos - halfH && mouseY <= yPos + halfH;
    return xArea && yArea;
  }

}
