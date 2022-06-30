/**
Parte sujeta a cambios
*/

private Nivel nivel1;
private Jugador jugador;
private Interfaz interfaz;
private int estadoJuego;
private int nivelActual;

void setup() {
  size(600, 600);
  estadoJuego = MaquinaEstados.ESTADO_INICIO;
  nivelActual = 1;
}

void draw() {
  switch (estadoJuego) {
    case MaquinaEstados.ESTADO_INICIO:
      background(0);
      text("INICIOOOO", width/2, height/2);
      break;
    case MaquinaEstados.ESTADO_JUGANDO:
      nivel1.display();
      jugador.display();
      jugador.move();
      interfaz.display();
      break;
    case MaquinaEstados.ESTADO_GANADO:
      limpiarPantalla();
      nivelActual++;
      text("GANASTEEEEEEE", width/2, height/2);
      break;
    case MaquinaEstados.ESTADO_PERDIDO:
      limpiarPantalla();
      text("PERDISTE BOBO", width/2, height/2);
      break;
  }
}

void inicio() {
  // Se crea al jugador
  jugador = new Jugador(5, 7, null);
  
  // Dependiendo el nivel en curso, se diubuja e instancia en pantalla
  // su nivel correspondiente y tambien sus enemigos y obstaculos.
  switch (nivelActual) {
    case 1:
      nivel1 = new Nivel(1, "/images/bg/grass.jpg", jugador);
      PVector[] puntos = {new PVector(500,500), new PVector(500,100)};
      nivel1.addEnemigo(new SoldadoNormal(400, 500, nivel1), puntos);
      PVector[] puntos2 = {new PVector(100,500), new PVector(100,100)};
      nivel1.addEnemigo(new SoldadoNormal(200, 200, nivel1), puntos2);
      jugador.setNivel(nivel1);
    break;
  }
  
  // Dibuja la interfaz en pantalla
  interfaz = new Interfaz();
}

// Libera los recursos de lo que no se va a usar
void limpiarPantalla() {
  nivel1 = null;
  jugador = null;
  interfaz = null;
  background(0);
}

void keyPressed() {
  if (key == ESC) exit();
  if (estadoJuego == MaquinaEstados.ESTADO_INICIO) {
    estadoJuego = MaquinaEstados.ESTADO_JUGANDO;
    inicio();
  }
  if (estadoJuego == MaquinaEstados.ESTADO_GANADO || estadoJuego == MaquinaEstados.ESTADO_PERDIDO) {
    exit();
  }
}

void mousePressed() {
  if (mousePressed && mouseButton == LEFT && estadoJuego == MaquinaEstados.ESTADO_JUGANDO) jugador.shoot();
}
