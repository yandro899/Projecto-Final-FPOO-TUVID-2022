/**
Clase abstracta Arma, de las que nacen todas las armas que este juego usa.
*/

abstract class Arma extends GameObject {
  protected ArrayList<Bala> municionCargada;    // Cargador balas
  protected int municionMax;                    // Municion maxima del arma
  protected int danoBala;                       // Daño de cada bala
  protected int velocidadBalas;                 // Velocidad de las balas
  protected boolean isReloading;                // Indica si el personaje esta recargando (Esto posiblemente se elimine)
  protected boolean isPickUp;                   // Indica si un arma fue agarrada (posiblemente se elimine, ya que es redundante con portador)
  protected Persona portador;                   // Persona que tiene el arma. Si es null, no tiene portador (esta en el suelo)
  protected SpriteRenderer sprite;
  protected AudioSample shootSound;
  
  /** Constructores parametrizados */
  // Inicializa Arma que no tiene portador (en el suelo)
  public Arma(int municionMax, int danoBala, int velocidad) {
    this.municionMax = municionMax;
    this.danoBala = danoBala;
    this.velocidadBalas = velocidad;
    this.municionCargada = new ArrayList<Bala>();
    for (int i=0; i<this.municionMax; i++) {
      this.municionCargada.add(new Bala(danoBala, this));
    }
    this.isReloading = false;
    this.isPickUp = false;
    this.portador = null;
  }
  
  // Inicializa Arma que tiene portador
  public Arma(int municionMax, int danoBala, int velocidad, Persona portador) {
    super(portador.getPosicion().x, portador.getPosicion().y);
    this.municionMax = municionMax;
    this.danoBala = danoBala;
    this.velocidadBalas = velocidad;
    this.municionCargada = new ArrayList<Bala>();
    for (int i=0; i<this.municionMax; i++) {
      this.municionCargada.add(new Bala(danoBala, this));
    }
    this.isReloading = false;
    this.isPickUp = true;
    this.portador = portador;
  }
  
  // Funcion que indica que el arma debe ser disparada. Su disparo depende del arma (clases hijas)
  public abstract void shootGun();
  
  // Funcion que indica que el arma se debe recargar (se debe eliminar)
  public abstract void reload();
  
  // Funcion que chequea las balas tanto disparadas como las que estan en el cargador sobre su
  // interaccion con el nivel
  public void chequeoBalas() {
    // Normalmente las otras armas al terminar de disparar sus cartuchos
    // no reponen sus balas.
    // A excepcion de la pistola (cada tiro afuera del mapa suma una bala mas)
    // todas las armas comparten la misma funcion de borrado de balas.
  }
  
  /** Metodos accesores */
  public Persona getPortador() {
    return this.portador;
  }
  
  public int getVelocidadBalas() {
    return this.velocidadBalas;
  }
  
  public void setPortador(Persona portador) {
    this.portador = portador;
    this.posicion = new PVector(portador.getPosicion().x, portador.getPosicion().y);
  }
}
