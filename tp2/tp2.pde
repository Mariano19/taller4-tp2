import fisica.*;

Programa programa;
PImage bg;
PImage personaje;
PImage orbitaVanidad;
PImage estrella, estrellamala;
PImage arrow, arrow2;
PImage reset;

void setup () {
  //orientation(LANDSCAPE); 
  //fullScreen();
  noStroke();
  fill(0);
  size (1920, 1080);
  bg = loadImage("/data/bg.jpg");
  personaje = loadImage("/data/personaje.png");
  estrella = loadImage("/data/estrella.png");
  estrellamala = loadImage("/data/estrellamala.png");
  orbitaVanidad = loadImage("/data/orbitavanidad.png");
  arrow = loadImage("/data/arrow.png");
  arrow2 = loadImage("/data/arrow2.png");
  reset = loadImage("/data/reset.png");
  bg.resize(1920/2, 0);
  
  orbitaVanidad.resize(1920/4, 0);
  imageMode(CORNER);
  Fisica.init(this);

  // Inicio objeto
  programa = new Programa();
}

void draw () {
  pushStyle();
  fill(#171717,50);
  rect(0,0,width,height);
  //image(bg, 0, 0);
  popStyle();
  programa.actualizar();
  
  pushStyle();
  textSize(14);
  textAlign(LEFT,CENTER);
  fill(255,0,0);
  text(frameRate, 10,10);
  popStyle();
}

void mousePressed() {
  programa.click();
}

void mouseReleased(){
  programa.release();
}
