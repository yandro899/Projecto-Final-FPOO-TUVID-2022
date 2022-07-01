/**
Parte sujeta a cambios
*/

private Jugador jugador;
private Interfaz interfaz;
private int estadoJuego;
private int nivelActual;
private Nivel [] niveles;

void setup() {
  size(600, 600);
  estadoJuego = MaquinaEstados.ESTADO_INICIO;
  nivelActual = 1;
  niveles = new Nivel[2];
}

void draw() {
  switch (estadoJuego) {
    case MaquinaEstados.ESTADO_INICIO:
      background(0);
      text("INICIOOOO", width/2, height/2);
      break;
    case MaquinaEstados.ESTADO_JUGANDO:
      niveles[nivelActual-1].display();
      jugador.display();
      jugador.move();
      interfaz.display();
      break;
    case MaquinaEstados.ESTADO_GANADO:
      limpiarPantalla();
      text("GANASTEEEEEEE", width/2, height/2);
      text(String.format("Puntaje: %d", jugador.getPuntaje()), width/2, height/2);
      // TODO: Puntaje adicional por vida
      // TODO: puntaje adicionar por tiros usados
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
  
  // Dependiendo el nivel en curso, se dibuja e instancia en pantalla
  // su nivel correspondiente y tambien sus enemigos y obstaculos.
  switch (nivelActual) {
    case 1:
      // NIVEL 1
      niveles[0] = new Nivel(1, "/images/bg/grass.jpg", jugador);
      PVector[] puntos = {new PVector(500,500), new PVector(500,100)};
      niveles[0].addEnemigo(new SoldadoNormal(400, 500, niveles[nivelActual-1]), puntos);
      PVector[] puntos2 = {new PVector(100,500), new PVector(100,100)};
      niveles[0].addEnemigo(new SoldadoNormal(200, 200, niveles[nivelActual-1]), puntos2);
      jugador.setNivel(niveles[0]);
    break;
  }
  
  // Dibuja la interfaz en pantalla
  interfaz = new Interfaz();
}

// Libera los recursos de lo que no se va a usar
void limpiarPantalla() {
  niveles[nivelActual-1] = null;
  //jugador = null;
  interfaz = null;
  background(0);
}

void keyPressed() {
  if (key == ESC) exit();
  if (estadoJuego == MaquinaEstados.ESTADO_INICIO) {
    estadoJuego = MaquinaEstados.ESTADO_JUGANDO;
    inicio();
  }
  if ((estadoJuego == MaquinaEstados.ESTADO_GANADO || estadoJuego == MaquinaEstados.ESTADO_PERDIDO) && keyCode == ENTER) {
    exit();
  }
}

void mousePressed() {
  if (mousePressed && mouseButton == LEFT && estadoJuego == MaquinaEstados.ESTADO_JUGANDO) jugador.shoot();
}
