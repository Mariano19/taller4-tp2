Programa programa;
PImage bg;
PImage personaje;
PImage orbitaVanidad;
PImage estrella;


void setup () {
  size (1920/2, 1080/2);
  bg = loadImage("/assets/bg.jpg");
  personaje = loadImage("/assets/personaje.png");
 estrella = loadImage("/assets/estrella.png");
  orbitaVanidad = loadImage("/assets/orbitavanidad.png");
  bg.resize(1920/2, 0);
  orbitaVanidad.resize(1920/4, 0);
  imageMode(CORNER);

  // Inicio objeto
  programa = new Programa();
}

void draw () {
  background(0);
  pushStyle();
  tint(255, 100);  // Apply transparency without changing color
  //image(bg, 0, 0);
  popStyle();
  programa.actualizar();
}

void mousePressed() {
  programa.click();
}

void keyPressed() {
  programa.teclado();
}
