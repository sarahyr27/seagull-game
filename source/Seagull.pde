class Seagull {
PImage image;
float imageXPos;
float imageYPos;
float targetX, targetY; //Para ubicar un nuevo punto al cual se moverá la gaviota, aportará suavidad visual al accionar los controles de movimiento con el uso de lerp()
//Variables para controlar la dimensión de la imagen de la gaviota según el movimiento
int flyW = 118;
int flyH = 34;
int diveW = 77;
int diveH = 48;
int velocity = 5; //Variable para controlar la velocidad del movimiento con los controles del juego
float gravity = 0.01; //Magnitud de la gravedad que usaremos en el comportamiento de caída libre para la posición en Y
boolean isDiving = false; //Controlar la animación del vuelo hacia abajo
boolean isDamaged = false; //Controlar animación de daño cuando colisiona
float damageTime; //Para guardar el momento exacto en que colisiona contra un objeto que haga daño
int damageDuration = 1000; //En ms
float h = isDiving ? diveH : flyH;


Seagull(PImage _image, float _imageXPos, float _imageYPos){
  image = _image;
  imageXPos = _imageXPos;
  imageYPos = _imageYPos;
  targetX = imageXPos;
  targetY = imageYPos;
}

void display(){
  pushStyle(); //Para aplicar estilos de imagen únicamente a la gaviota y no a otros elementos del sistema
  
  //Animaciones para cuando se recibe daño
  if(isDamaged){
    if(millis() / 100 % 2 == 0){ //Cuando millis() sea par, aplicamos el código de debajo, para un efecto de parpadeo
      tint(255, 0); //Opacidad del 0%
    } else {
    tint(255, 255);
    }
    
    if(millis() - damageTime > damageDuration){ //Apagamos la condición isDamaged después de un segundo
      isDamaged = false;
    }
  } else { //Si la condición isDamaged está apagada, la imagen se muestra sin transparencia
    tint(255, 255);
  }
  
  //Movimiento de la imagen
  if(!gamePaused){
    imageXPos = lerp(imageXPos, targetX, 0.12);
    imageYPos = lerp(imageYPos, targetY, 0.12);
  }

  //Animación de movimiento vertical, hacia arriba o hacia abajo
  if(isDiving){
    image(seagullFlyingDown, imageXPos, imageYPos, diveW, diveH);
  } else {
    image(seagullFlyingUp, imageXPos, imageYPos, flyW, flyH);
  }
  
  popStyle();
}

//SIMULACIÓN LEYES FÍSICAS
//Método que simula el movimiento en caída libre y la acción de la gravedad sobre la gaviota
void gravityBehaviour(){
  if(targetY + h < height){ //Límite de posición dentro de la pantalla
    velocity += gravity;
    targetY += velocity;
  }
}

//CONTROLES DE MOVIMIENTO
void moveUp(){
  if(imageYPos - image.height*3.6/4 > 0){ //Para que la gaviota no se salga de la pantalla. Hacemos los mismos ajustes en los siguientes métodos para el control de movimiento
    targetY -= velocity*20;
  }
}

void moveDown(){
  if(targetY + h < height){
    targetY += velocity*20;
  } else {
    targetY = height - h - h/2;
  }
}

void moveLeft(){
  if(imageXPos - image.width/4 > 0){
    targetX -= velocity*20;
  } 
}

void moveRight(){
  if(imageXPos + image.width < width){
    targetX += velocity*20;
  } 
}


}
