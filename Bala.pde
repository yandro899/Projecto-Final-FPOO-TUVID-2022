/**
Clase Bala: es capaz de hacer daño al jugador y a los enemigos, dependiendo quien dispare el arma.
Por ahora, todas las balas tienen el mismo tamaño y sprite, pero la idea es que sea distinta por arma
*/
class Bala extends GameObject {
  private int dano;                  // Daño producido por la bala
  private boolean isShooted;         // Indica si una bala salio del arma y puede causar daño
  private boolean impactSomeEnemy;   // Indica impacto con algun enemigo
  private PVector velocidad;         // Velocidad de las balas
  private CircleCollider collider;   // Colision que se activa cuando el arma fue soltada (para que el jugador la agarre)
  private Arma armaDisparada;        // Puntero al arma de la que el arma salio
  
  /** Constructor parametrizado */
  // Las balas se crean (son cargadas en el arma), pero no son disparadas aun
  public Bala(int dano, Arma armaDisparada) {
    super(armaDisparada.getPosicion().x, armaDisparada.getPosicion().y);
    this.dano = dano;
    this.isShooted = false;
    this.armaDisparada = armaDisparada;
    this.collider = new CircleCollider(this.posicion.x, this.posicion.y, 5, false);
    this.impactSomeEnemy = false;
  }
  
  // Dibuja el arma en pantalla (ademas, controla las colisiones con otras personas.
  public void display() {
    if(this.isShooted) {
      fill(#ffff00);
      circle(this.posicion.x, this.posicion.y, 10);
      fill(255);
      this.posicion.add(this.velocidad);
      this.collider.setPosicion(this.posicion.x, this.posicion.y);
      
      // Controla las balas disparadas por el jugador contra los enemigos
      if (this.armaDisparada.getPortador().isPlayer()) {
        for (int i=this.armaDisparada.getPortador().getNivel().getEnemigos().size()-1; i>=0; i--) {
          // Analiza la colision entre los enemigos en el nivel (vivos) y esta bala
          boolean hayColision = this.armaDisparada.getPortador().getNivel().getEnemigos().get(i).
            getCollider().collideWith(this.collider);
          
          // Si hay colision, el enemigo sufre daño
          if (hayColision) {
            this.armaDisparada.getPortador().getNivel().getEnemigos().get(i).damage(this.dano);
            this.impactSomeEnemy = true;
          }
        }
      }
      // Controla las balas disparadas por los enemigos contra el jugador
      else {
        // Analiza la colision entre jugador y esta bala
        boolean hayColision = this.armaDisparada.getPortador().getNivel().getJugador().getCollider().collideWith(this.collider);
        
        // Si hay colision, el jugador sufre daño
          if (hayColision) {
            this.armaDisparada.getPortador().getNivel().getJugador().damage(this.dano);
            this.impactSomeEnemy = true;
          }
      }
    }
  }
  
  // Setea una bala para que no esta disparada
  public void unShoot() {
    this.isShooted = false;
    this.collider.setCollideActive(false);
    this.impactSomeEnemy = false;
  }
  
  // Accion que define la velocidad y direccion del disparo
  public void shootBullet() {
    this.isShooted = true;
    this.collider.setCollideActive(true);
    this.posicion = new PVector(this.armaDisparada.getPosicion().x, this.armaDisparada.getPosicion().y);
    
    //BUG: disparar desde el jugador (poner la mira EN el jugador) hace que las balas esten quietas.
    //CAUSA: Vector direccion nulo
    // Las balas se disparan a la direccion que determina la ubicacion del jugador y su mira.
    // Esto se logra con resta de vectores.
    this.velocidad = this.armaDisparada.getPortador().direccionDisparo().mult(this.armaDisparada.getVelocidadBalas());
  }
  
  /** Metodos accesores */
  public boolean isShooted() {
    return this.isShooted;
  }
  
  public boolean impactSomeEnemy() {
    return this.impactSomeEnemy;
  }
  
  public CircleCollider getCollider() {
    return this.collider;
  }
}
