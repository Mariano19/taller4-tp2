class Menu {

  int numButtons = 9;
  Button[] buttons = new Button[numButtons];
  String[] buttonLabels = {"Acoso", "Vanidad", "Desinterés", "Mediación", "Xenofobia", "Timidez", "Protección", "Desamparo", "Empatia"};
  int margin = 20; // Margen entre botones
  
  Menu() {
    createButtons();
  }

  void actualizar() {
    // Dibujar los botones
    for (Button button : buttons) {
      button.display();
      button.update();
    }
  }

  void createButtons() {
  int buttonWidth = (width - 4 * margin) / 3;  // Ancho de cada botón teniendo en cuenta el margen
  int buttonHeight = (height - 4 * margin) / 3;  // Alto de cada botón teniendo en cuenta el margen
  
  int xOffset = (width - (buttonWidth * 3 + margin * 2)) / 2;  // Desplazamiento horizontal para centrar los botones
  int yOffset = (height - (buttonHeight * 3 + margin * 2)) / 2;  // Desplazamiento vertical para centrar los botones
  

 // Calcular las coordenadas de posición para cada botón
  int buttonIndex = 0;
  for (int row = 0; row < 3; row++) {
    for (int col = 0; col < 3; col++) {
      int x = xOffset + col * (buttonWidth + margin);
      int y = yOffset + row * (buttonHeight + margin);
      buttons[buttonIndex] = new Button(x, y, buttonWidth, buttonHeight, buttonLabels[buttonIndex]);
      buttonIndex++;
      }
    }
  }

  void clickBoton() {
    // Verificar si se hizo clic en algún botón
    for (Button button : buttons) {
      if (button.isClicked(mouseX, mouseY)) {
        button.handleClick();
      }
    }
  }

  class Button {
    int x, y;  // Posición del botón
    int width, height;  // Dimensiones del botón
    String label;  // Etiqueta del botón
    boolean hover;  // Estado de hover
    Button(int x, int y, int width, int height, String label) {
      this.x = x;
      this.y = y;
      this.width = width;
      this.height = height;
      this.label = label;
    }

  void update() {
    // Verificar si el mouse está sobre el botón
    hover = isHovered(mouseX, mouseY);
  }

    void display() {
      // Dibujar el rectángulo del botón
      stroke(255);
      noFill();
     
      if (hover) {
      fill(255,15);  // Cambiar el color si el mouse está sobre el botón

    } else {
      noFill();

    }
      rect(x, y, width, height,5);

      // Dibujar la etiqueta del botón
      textAlign(CENTER, CENTER);
      fill(255);
      text(label, x, y, width, height);
    }

    boolean isClicked(int mouseX, int mouseY) {
      // Verificar si el mouse está dentro del botón
      return mouseX > x && mouseX < x + width && mouseY > y && mouseY < y + height;
    }
    
      boolean isHovered(int mouseX, int mouseY) {
    // Verificar si el mouse está sobre el botón
    return mouseX > x && mouseX < x + width && mouseY > y && mouseY < y + height;
  }

    void handleClick() {
      // Acción que se realiza cuando se hace clic en el botón
      println("Clic en " + label);
      programa.estado=(label);
      println("Estado:" + programa.estado);
    }
  }
}
