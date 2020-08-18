class button {
  float x;
  float y;
  int wit;
  int len;
  float radius;
  color og_Color;
  color pres_Color;
  int btn_type = 5;
  void rectaddbtn (float x_, float y_, int wit_, int len_, float radius_, color og_Color_, color pres_Color_, String text, int text_size) {
    rectMode(CENTER);
    if (put==false) {
      fill(og_Color_);
      rect(x_, y_, wit_, len_, radius_);
      fill(pres_Color_);
      //textMode(CENTER);
      textSize(text_size);
      textAlign(CENTER, CENTER);
      text(text, x_, y_);
    } else {
      fill(pres_Color_);
      rect(x_, y_, wit_, len, radius_);
      fill(og_Color_);
      textSize(text_size);
      textAlign(CENTER, CENTER);
      text(text, x_, y_);
      put=true;
    }


    x = x_-wit_/2;
    y=y_-len_/2;
    wit = wit_;
    len = len_;
    radius = radius_;
    og_Color= og_Color_;
    pres_Color=pres_Color_;
    btn_type=0;
  }
  void circleaddbtn (float x_, float y_, int wit_, int len_, color og_Color_, color pres_Color_) {
    y=y_;
    wit = wit_;
    len = len_;
    og_Color= og_Color_;
    pres_Color=pres_Color_;
    btn_type=0;
    fill(og_Color_);
    ellipse(x, y, wit, len);
    btn_type=1;
  }
  boolean detect (float Mouse_x, float Mouse_y ) {
    if (btn_type ==0) {
      if (Mouse_x >= x && Mouse_x <= x+wit && 
        Mouse_y >= y && Mouse_y <= y+len ) {
        return true;
      } else {
        //println(x);
        //println(y);

        return false;
      }
    } else if (btn_type==1) {
      float disX = x - Mouse_x;
      float disY = y - Mouse_x;
      if (sqrt(sq(disX) + sq(disY)) < len/2 ) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
