Programa programa;

void setup () {
  size (1920/2, 1080/2);
  imageMode(CENTER);

  // Inicio objeto
  programa = new Programa();
}

void draw () {
  background (0);
  programa.actualizar();
}
