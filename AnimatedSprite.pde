/** Clase AnimatedSprite: 
Es la clase contraladora de todas las animaciones mostradas.
*/

class AnimatedSprite extends SpriteRenderer {
  private int frameX;             // Cuadros por segundo en X 
  private int frameY;             // Cuadros por segundo en Y
  private boolean isAnimated;     // Indica si hay Animaciones
  private int fpsSprite;          // Indica la duración de un objeto por cuadro 
  
  /** Constructor parametrizado */
  //Indica el inicio de la animación (ya sea de comienzo o final de juego)
  public AnimatedSprite(String str_image, int widthFrame, int heightFrame, float posX, float posY, int fpsSprite, boolean isDisplay, boolean isAnimated) {
    super(str_image, widthFrame, heightFrame, posX, posY, isDisplay);
    this.frameX = 0;
    this.frameY = 0;
    this.fpsSprite = fpsSprite;
    this.isAnimated = isAnimated;
  }
  
  // Controla la reproducción de la animación
  public void displaySprite() {
    
    // No mustra por pantalla si esta esta desactivada
    if (!this.isDisplay) return;
    
    // Dibuja sprite
    imageMode(CENTER);
    image(this.sprite.get(this.frameX, this.frameY, this.widthFrame, this.heightFrame), this.posicionX, this.posicionY);
    
    // Dibuja la animacion cada x frames.
    if (frameCount%(60/this.fpsSprite)==0 && this.isAnimated) {
      this.frameX += this.widthFrame;
      if (this.frameX>=this.sprite.width) {
        this.frameX = 0;
        this.frameY += this.heightFrame;
        if (this.frameY>=this.sprite.height) this.frameY = 0;
      }
    }
  }
  
  /** Metodos accesores */
  public void animSprite(boolean isAnim) {
    this.isAnimated = isAnim;
  }
  
  public boolean isAnimated() {
    return this.isAnimated;
  }
}
