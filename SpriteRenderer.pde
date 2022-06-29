class SpriteRenderer {
  protected PImage sprite;
  protected int widthFrame;
  protected int heightFrame;
  protected int posicionX;
  protected int posicionY;
  
  public SpriteRenderer(String str_image, int widthFrame, int heightFrame, int posX, int posY) {
    this.sprite = requestImage(str_image);
    this.widthFrame = widthFrame;
    this.heightFrame = heightFrame;
    this.posicionX = posX;
    this.posicionY = posY;
  }
  
  public void displaySprite() {
    imageMode(CENTER);
    image(this.sprite, this.posicionX, this.posicionY, this.widthFrame, this.heightFrame);
  }
  
  public boolean isSpriteCharged() {
    if (this.sprite.width > 0) return true;
    else return false;
  }
}
