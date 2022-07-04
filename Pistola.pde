/** Clase Pistola:
Hereda de Arma para hacer su propia identidad de comportamiento
*/

class Pistola extends Arma {
  
  /** Constructor por defecto */
  public Pistola() {
    super(35, 1, 7);
  }
  
  /** Constructor paramentrizado */
  public Pistola(Persona portador) {
    super(35, 1, 15, portador);
  }
  
  /** Dispara la pistola */
  public void shootGun() {
    for(int i=0; i<this.municionMax; i++) {
      if (!this.municionCargada.get(i).isShooted()) {
        this.municionCargada.get(i).shootBullet();
        break;
      }
    }
  }
  
  /** Recarga el arma (NO SE VA A USAR */
  public void reload() {
    
  }
  
  /** Dibuja la pistola en pantalla */
  public void display() {
    square(this.posicion.x, this.posicion.y, 10);
    //println(this.municionCargada.get(0).getPosicion().x + " " + this.municionCargada.get(0).getPosicion().y);
    for(int i=0; i<this.municionMax; i++) {
      this.municionCargada.get(i).display();
    }
    this.chequeoBalas();
  }
  
  /** Implementacion propia de chequeo de balas de esta arma */
  // Como tiene municion infinita, la idea es que el arma "recicle" las
  // balas que ya salieron fuera del mapa o ya impactaron contra algo.
  @Override
  public void chequeoBalas() {
    for (int i=0; i<this.municionMax; i++) {
      if(!this.municionCargada.get(i).getCollider().collideWith(this.portador.getNivel().getZonaJugable()) ||
      this.municionCargada.get(i).impactSomeThing()) {
        this.municionCargada.get(i).unShoot();
        
        // Vuelve la bala y su hitbox al cargador al salir del mapa
        this.municionCargada.get(i).setPosicion(this.posicion.x, this.posicion.y);
        this.municionCargada.get(i).getCollider().setPosicion(this.posicion.x, this.posicion.y);
      }
    }
  }
  
}
