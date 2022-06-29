class Nivel extends GameObject {
  private int numNivel;
  private SpriteRenderer sprite;
  private RectCollider zonaJugable;
  private Jugador jugador;
  private ArrayList<Enemigo> enemigos;
  
  public Nivel(int nivel, String spriteStr, Jugador jugador, ArrayList<Enemigo> enemigos) {
    this.numNivel = nivel;
    this.sprite = new SpriteRenderer(spriteStr, width, height, width/2, height/2);
    this.zonaJugable = new RectCollider(this.posicion.x, this.posicion.y, height, width, true);
    this.jugador = jugador;
    this.enemigos = enemigos;
  }
  
  public void display() {
    if(this.sprite.isSpriteCharged()) this.sprite.displaySprite();
    else background(200);
    if (this.enemigos.isEmpty()) estadoJuego = MaquinaEstados.ESTADO_GANADO;
    
    //for (int i=0; i<enemigos.size(); i++) 
    for (int i = enemigos.size()-1; i>=0; i--) {
      if (enemigos.get(i).isDead()) {
        enemigos.remove(i);
        continue;
      }
      enemigos.get(i).display();
      enemigos.get(i).move();
    }
  }
  
  /** Metodos Accesores */
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
