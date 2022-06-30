/**
Clase que se encarga del mapeado del nivel
Puede tener uno o varios enemigos y obstaculos
*/

class Nivel extends GameObject {
  private int numNivel;                 // Numero nivel
  private SpriteRenderer sprite;        // Dibujo del nivel
  private RectCollider zonaJugable;     // Indica la zona de juego
  private Jugador jugador;              // Puntero al jugador
  private ArrayList<Enemigo> enemigos;  // Enemigos dentro del nivel
  
  /** Contructor parametrizado */
  public Nivel(int nivel, String spriteStr, Jugador jugador) {
    this.numNivel = nivel;
    this.sprite = new SpriteRenderer(spriteStr, width, height, width/2, height/2);
    this.zonaJugable = new RectCollider(this.posicion.x, this.posicion.y, height, width, true);
    this.jugador = jugador;
    this.enemigos = new ArrayList<Enemigo>();
  }
  
  // Dibuja el nivel y los enemigos dentro de el (si estan vivos)
  public void display() {
    if(this.sprite.isSpriteCharged()) this.sprite.displaySprite();
    else background(200);
    
    // Si no hay enemigos en el nivel, el jugador gano el nivel.
    if (this.enemigos.isEmpty()) estadoJuego = MaquinaEstados.ESTADO_GANADO;
    
    // Dibuja cada enemigo en pantalla
    for (int i = enemigos.size()-1; i>=0; i--) {
      // Si un enemigo murió, se lo elimina del nivel
      if (enemigos.get(i).isDead()) {
        enemigos.remove(i);
        continue;
      }
      enemigos.get(i).display();
      enemigos.get(i).move();
    }
  }
  
  /** Metodos Accesores */
  public void addEnemigo(Enemigo enemigo, PVector[] puntos) {
    this.enemigos.add(enemigo);
    for (int i=0; i<puntos.length; i++) {
      this.enemigos.get(this.enemigos.size()-1).addRecorrido(puntos[i]);
    }
  }
  
  public RectCollider getZonaJugable() {
    return this.zonaJugable;
  }
  
  public ArrayList<Enemigo> getEnemigos() {
    return this.enemigos;
  }
  
  public Jugador getJugador() {
    return this.jugador;
  }
  
  public int getNumNivel() {
    return this.numNivel;
  }
}
