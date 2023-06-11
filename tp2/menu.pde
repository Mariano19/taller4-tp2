class Menu {

  int numButtons = 9;
  Button[] buttons = new Button[numButtons];
  String[] buttonLabels = {"Acoso", "Vanidad", "Desinterés", "Mediación", "Xenofobia", "Timidez", "Protección", "Desamparo", "Empatía"};

  Menu() {
    createButtons();
  }

  void actualizar() {
    // Dibujar los botones
    for (Button button : buttons) {
      button.display();
    }
  }


  void createButtons() {
    int buttonWidth = width / 3;  // Ancho de cada botón
    int buttonHeight = height / 3;  // Alto de cada botón

    // Calcular las coordenadas de posición para cada botón
    int buttonIndex = 0;
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        int x = col * buttonWidth;
        int y = row * buttonHeight;
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

    Button(int x, int y, int width, int height, String label) {
      this.x = x;
      this.y = y;
      this.width = width;
      this.height = height;
      this.label = label;
    }

    void display() {
      // Dibujar el rectángulo del botón
      stroke(255);
      fill(0);
      rect(x, y, width, height);

      // Dibujar la etiqueta del botón
      textAlign(CENTER, CENTER);
      fill(0);
      text(label, x, y, width, height);
    }

    boolean isClicked(int mouseX, int mouseY) {
      // Verificar si el mouse está dentro del botón
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
