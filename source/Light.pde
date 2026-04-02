class Light {
PImage image;
float imageXPos;
float imageYPos;
boolean active, isShort; //Active determina si la gaviota ha chocado con la luz o no, para manejar enfriamiento y resta de vidas. isShort será utilizada para almacenar el tipo de imagen (luz corta o larga) y poderla actualizar en el nivel 3
int cooldownTime = 3000; // Tiempo en milisegundos para que una luz vuelva a hacer daño
float deactivationTime; //Controla cuánto tiempo ha pasado desde que la gaviota chocó contra una luz

Light(PImage _image, boolean _isShort, float _imageXPos, float _imageYPos){
  image = _image;
  isShort = _isShort;
  imageXPos = _imageXPos;
  imageYPos = _imageYPos;
}
 
void display(){
  image(image, imageXPos, imageYPos);
  noFill();
  stroke(0);
}

//Método para dibujar el poste después de la luz
void drawPole(){
  image(pole, imageXPos + image.width, imageYPos + 20);
}

//Método para que las luces se muevan junto con el fondo
void move(){
  imageXPos -= xMovementVelocity;
}

void collisionBehaviour(){
  if(active){
    subtractALife(seagull);
  }
  active = false;
  deactivationTime = millis();
}

void cooldownBehaviour(){
  if(!active && millis() - deactivationTime >= cooldownTime){
    active = true;
  }
}

//Usar las imagenes de luces nocturnas
void turnOn(){
  image = isShort ? shortLightsNight : longLightsNight;
}

//Usar las imagenes de luces diurnas
void turnOff(){
  image = isShort ? shortLightsDay : longLightsDay;
}
  
}
