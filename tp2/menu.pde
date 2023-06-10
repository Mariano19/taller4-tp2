class Menu {
  float botonW;
  float botonH;
  int cant = 3;
  int cant2 = 3;

  Menu() {

    botonW = 421.5/2;
    botonH = 237.09/2;
  }

  void actualizar() {
    noFill();
    stroke(255);

    for ( int i = 0; i < cant; i++ ) {
      for ( int x = 0; x < cant2; x++ ) {
        rect(width/2*i/2, height/2*x/2, botonW, botonH);
      }
    }
  }
}
