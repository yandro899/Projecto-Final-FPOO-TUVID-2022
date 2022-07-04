/** Clase SpriteRenderer:
Clase que dibuja en pantalla los sprites.
Acoplable a otras clases
*/

// TODO: Que dependa de GameObject
class SpriteRenderer {
  protected PImage sprite;    // Imagen a usar en sprite
  protected int widthFrame;   // Ancho sprite
  protected int heightFrame;  // Alto sprite
  protected float posicionX;  // Posicion en x
  protected float posicionY;  // Posicion en y
  protected boolean isDisplay;
  
  /** Constructor paramentrizado */
  public SpriteRenderer(String str_image, int widthFrame, int heightFrame, float posX, float posY, boolean isDisplay) {
    this.sprite = requestImage(str_image);
    this.widthFrame = widthFrame;
    this.heightFrame = heightFrame;
    this.posicionX = posX;
    this.posicionY = posY;
    this.isDisplay = isDisplay;
  }
  
  /** Dibuja el sprite en pantalla */
  public void displaySprite() {
    if (!this.isDisplay) return;
    imageMode(CENTER);
    image(this.sprite, this.posicionX, this.posicionY, this.widthFrame, this.heightFrame);
  }
  
  /* Comprueba si el sprite fue cargado con exito */
  public boolean isSpriteCharged() {
    if (this.sprite.width > 0) return true;
    else return false;
  }
  
  /** Metodos accesores */
  public void setDisplay(boolean isDisp) {
    this.isDisplay = isDisp;
  }
  
  public void setPosicion(float x, float y) {
    this.posicionX = x;
    this.posicionY = y;
  }
  
  public boolean isDisplay() {
    return this.isDisplay;
  }
  
  
}
