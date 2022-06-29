/**
Parte sujeta a cambios
*/

private Nivel nivel1;
private Jugador jugador;
private Interfaz interfaz;
private int estadoJuego;

void setup() {
  size(600, 600);
  estadoJuego = MaquinaEstados.ESTADO_INICIO;
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
      nivel1 = null;
      jugador = null;
      interfaz = null;
      background(0);
      text("GANASTEEEEEEE", width/2, height/2);
      break;
    case MaquinaEstados.ESTADO_PERDIDO:
      background(0);
      text("PERDISTE BOBO", width/2, height/2);
      break;
  }
}

void inicio() {
  ArrayList<Enemigo> enemigos = new ArrayList<Enemigo>();
  jugador = new Jugador(3, 7, null);
  nivel1 = new Nivel(1, "/images/bg/grass.jpg", jugador, enemigos);
  enemigos.add(new SoldadoNormal(500, 500, nivel1));
  enemigos.add(new SoldadoNormal(200, 200, nivel1));
  enemigos.add(new SoldadoNormal(200, 500, nivel1));
  jugador.setNivel(nivel1);
  interfaz = new Interfaz();
}

void keyPressed() {
  if (key == ESC) exit();
  if (estadoJuego == MaquinaEstados.ESTADO_INICIO) {
    estadoJuego = MaquinaEstados.ESTADO_JUGANDO;
    inicio();
  }
  if (estadoJuego == MaquinaEstados.ESTADO_GANADO) {
    exit();
  }
}

void mousePressed() {
  if (mousePressed && mouseButton == LEFT && estadoJuego == MaquinaEstados.ESTADO_JUGANDO) jugador.shoot();
}
