import controlP5.*;
int state = 0; 
String result=""; 
final int stateNormal   = 0;
final int stateInputBox = 1;
//int state=stateNormal;
import g4p_controls.*;
button btn =new button();
boolean click = false;
boolean click_press =false;
boolean put = false;
color white = (#FFFFFF);
color black = (#000000);
int triwid = 100;
int uper_len =86;
int x_1[] = {100, 100+triwid/2, 100+triwid, 100+triwid};
int y_1[] = {100, 100-uper_len, 100, 100 };
int x[] = {100, 100+triwid/2, 100+triwid, 100+triwid, x_1[3]+triwid/2};
int y[] = {100, 100-uper_len, 100, 100, y_1[3]+uper_len };


nanoleaf leaf[] =new nanoleaf[5];
//TextBox tbox= new TextBox("string", 300, 300, 100, 40, 1, white, white, white, white);
void setup() {
  leaf[0]= new nanoleaf(x[0], y[0], x[0]+triwid/2, y[0]-uper_len, x[0]+triwid, y[0]);
  leaf[1]= new nanoleaf(x[1], y[1], x[1]+triwid/2, y[1]+uper_len, x[1]+triwid, y[1]);
  leaf[2]= new nanoleaf(x[2], y[2], x[2]+triwid/2, y[2]-uper_len, x[2]+triwid, y[2]);
  leaf[3]= new nanoleaf(x[3], y[3], x[3]+triwid/2, y[3]+uper_len, x[3]+triwid, y[3]);
  leaf[4]= new nanoleaf(x[4], y[4], x[4]+triwid/2, y[4]-uper_len, x[4]+triwid, y[4]);
  size(600, 600);
}  
void draw() {

  background(123);
  stroke(45);
  fill(200);
  leaf[0].display();
  leaf[1].display();
  leaf[2].display();
  leaf[3].display();
  leaf[4].display();
  //ellipse(x[4], y[4], 12, 12);
  noStroke();
  put=btn.detect(mouseX, mouseY);
  if ((btn.detect(mouseX, mouseY))&&click==true) {
    click_press=true;
  } else {
    click_press=false;
  }
  println(click_press);

  //btn.rectaddbtn(300, 300, 300, 100, 4, white, black, "button", 40);
  click = false;
}
void mousePressed() {
  click =true;
}
