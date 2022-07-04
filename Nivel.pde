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
  private ArrayList<Pared> paredes;     // Paredes en el nivel
  
  /** Contructor parametrizado */
  public Nivel(int nivel, String spriteStr, Jugador jugador) {
    this.numNivel = nivel;
    this.sprite = new SpriteRenderer(spriteStr, width, height-Interfaz.altoInterfaz, width/2, height/2+Interfaz.altoInterfaz/2, true);
    this.zonaJugable = new RectCollider(this.posicion.x, this.posicion.y+Interfaz.altoInterfaz, height, width, true);
    this.jugador = jugador;
    this.enemigos = new ArrayList<Enemigo>();
    this.paredes = new ArrayList<Pared>();
  }
  
  // Dibuja el nivel y los enemigos dentro de el (si estan vivos)
  public void display() {
    if(this.sprite.isSpriteCharged()) this.sprite.displaySprite();
    else background(200);
    
    // Si no hay enemigos en el nivel, el jugador gano el nivel.
    if (this.enemigos.isEmpty()) {
      estadoJuego = MaquinaEstados.ESTADO_GANADO;
      nivelActual++;
    }
    
    // DEBUG: dibuja la colision de las paredes en pantalla
    //for (int i=0; i<paredes.size(); i++) {
    //  paredes.get(i).display();
    //}
    
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
  
  /** Agrega enemigos al nivel con su recorrido. Puede tener uno, varios o ningun punto de recorrido (null) */
  public void addEnemigo(Enemigo enemigo, PVector[] puntos) {
    this.enemigos.add(enemigo);
    if (puntos == null) return;
    for (int i=0; i<puntos.length; i++) {
      puntos[i].y += Interfaz.altoInterfaz;
      this.enemigos.get(this.enemigos.size()-1).addRecorrido(puntos[i]);
    }
  }
  
  /** Agrega una pared rectangular con colision al nivel. */
  public void addPared(Pared pared) {
    pared.setPosicion(pared.getPosicion().x, pared.getPosicion().y+Interfaz.altoInterfaz);
    pared.getCollider().setPosicion(pared.getPosicion().x, pared.getPosicion().y);
    this.paredes.add(pared);
  }
  
  /** Metodos Accesores */
  public RectCollider getZonaJugable() {
    return this.zonaJugable;
  }
  
  public ArrayList<Enemigo> getEnemigos() {
    return this.enemigos;
  }
  
  public ArrayList<Pared> getParedes() {
    return this.paredes;
  }
  
  public Jugador getJugador() {
    return this.jugador;
  }
  
  public int getNumNivel() {
    return this.numNivel;
  }
}
