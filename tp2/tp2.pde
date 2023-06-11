Programa programa;
PImage bg;

void setup () {
  size (1920/2, 1080/2);  
  bg = loadImage("/assets/bg.jpg");
  bg.resize(1920/2, 0);
  imageMode(CORNER);

  // Inicio objeto
  programa = new Programa();
}

void draw () {
  image(bg,0,0);
  programa.actualizar();
}
