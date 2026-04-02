class Food {
PImage image;
float imageXPos;
float imageYPos;
boolean poisonous;
boolean active = true; //Controlamos si la comida ha sido tocada por la gaviota o no
int timeToRespawn = 5000; // Tiempo en milisegundos para que la comida vuelva a aparecer después de comerla
float deactivationTime; //Controla cuánto tiempo ha pasado desde que se "comió" un alimento

//Alto y ancho de cada imagen (tienen altos y anchos diferentes para mantener la proporción)
int friesW = 51;
int friesH = 62;
int doughnutW = 85;
int doughnutH = 52;
int pizzaW = 56;
int pizzaH = 62;
int bocataW = 70;
int bocataH = 62;
int chiliW = 32;
int chiliH = 81;

Food(PImage _image, float _imageXPos, float _imageYPos){
  image = _image;
  imageXPos = _imageXPos;
  imageYPos = _imageYPos;
  poisonous = (image == chili); //Si la imagen es un chile, poisonous será true
}

void display(){
  if(active){
    if(image == fries){
      image(image, imageXPos, imageYPos, friesW, friesH);
    } else if (image == doughnut){
      image(image, imageXPos, imageYPos, doughnutW, doughnutH);
    } else if (image == pizza){
      image(image, imageXPos, imageYPos, pizzaW, pizzaH);
    } else if (image == bocata){
      image(image, imageXPos, imageYPos, bocataW, bocataH);
    } else {
      image(image, imageXPos, imageYPos, chiliW, chiliH);
    }
  }
}

//Método para movimiento
void move(){
  imageXPos -= xMovementVelocity;
}

//Cambiar el icono por otro cuando sale de pantalla para no repetir la secuencia generada en setup()
void updateIcon(){
  if(imageXPos + image.width < 0){
    image = everyFood[int(random(0, everyFood.length))];
    imageXPos -= image.width;
    if(image == chili){
      poisonous = true;   
    } else {
      poisonous = false;
    }
  }
}

//Comportamiento de suma puntos y resta de vidas
void collisionBehaviour(){
  if(active){
    if(poisonous){
      subtractALife(seagull);
    } else {
      points += 1;
      if(!soundPlayed){
        int randomSfx = int(random(0, 2));
        nomSounds[randomSfx].play();
        soundPlayed = true;
      }
    }
  }
  active = false;
  deactivationTime = millis();
  soundPlayed = false;
}

//Hace que la comida reaparezca después de haberla "comido"
void reactivateFood(){
  if(!active && millis() - deactivationTime >= timeToRespawn){
    active = true;
  }
}

}
