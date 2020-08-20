
import processing.serial.*;
Serial btserial;
int device_state = 0;
int condition_state = 0;
PFont maTypo;
String result="";
slideBar[][] controls;
button btn =new button();
boolean click = false;
boolean click_press =false;
boolean put = false;
color white = (#FFFFFF);
color black = (#000000);
int triwid = 200;
int uper_len =173;
int ypos = 200;
int xpos =250;



//103
//15:08:44.786 -> 0
//15:08:44.786 -> 0

int x_1[] = {xpos, xpos+triwid/2, xpos+triwid, xpos+triwid};
int y_1[] = {ypos, ypos-uper_len, ypos, ypos };
int x[] = {xpos, xpos+triwid/2, xpos+triwid, xpos+triwid, x_1[3]+triwid/2};
int y[] = {ypos, ypos-uper_len, ypos, ypos, y_1[3]+uper_len };
int device_num = 4;
boolean send_press =false;
button_change send = new button_change();
nanoleaf leaf[] =new nanoleaf[5];
button_change state[] = new button_change [device_num+1];
int send_times=0;
int condition_num=1;
int condition_true = 0;
button_change all = new button_change();
int size_l = 800;
int size_h = 800;
String condition_text [][] = new String[device_num+1][5];
//int nanoleaf_state [] = new int[];
button_change[][]condition_btn = new button_change [device_num+1][5];
int condition_num_ar[]= new int [device_num+1];
void setup() {
  btserial=new Serial(this, Serial.list()[0], 9600);
  printArray(Serial.list());

  for (int x = 0; x<device_num+1; x++) {
    for (int y = 0; y<5; y++) {
      condition_text[x][y]=new String(); 
    }
  }
  for (int i = 0; i<device_num+1; i++) {
    condition_text[i][0] = "breatinglight";
    condition_text[i][1] = "color_change";
  }
  condition_text[device_num][0] = "breatinglight";
  condition_text[device_num][1] = "color_change";
  condition_text[device_num][2] = "fire";
  condition_text[device_num][3] = "water";
  condition_text[device_num][4] = "music_relative";
  maTypo=createFont("arial", 10, false);
  textFont(maTypo, 10);
  controls=new slideBar[device_num+1][3];
  for (int x = 0; x<device_num+1; x++) {
    if (x==device_num) {
      condition_num_ar[x]=5;
    } else {
      condition_num_ar[x]=2;
    }
  }
  for (int i = 0; i<device_num+1; i++) {
    state[i]=new button_change();
  }
  for (int x=0; x<device_num+1; x++) {
    for (int y=0; y<5; y++) {
      condition_btn[x][y]= new button_change();
    }
  }
  for (int i = 0; i<device_num+1; i++) {
    controls[i][0] = new slideBar(50, 550, 200, 40, 0, 255);
    controls[i][1] = new slideBar(50, 600, 200, 40, 0, 255);
    controls[i][2] = new slideBar(50, 650, 200, 40, 0, 255);
  }
  leaf[0]= new nanoleaf(x[0], y[0], x[0]+triwid/2, y[0]-uper_len, x[0]+triwid, y[0]);
  leaf[1]= new nanoleaf(x[1], y[1], x[1]+triwid/2, y[1]+uper_len, x[1]+triwid, y[1]);
  leaf[2]= new nanoleaf(x[2], y[2], x[2]+triwid/2, y[2]-uper_len, x[2]+triwid, y[2]);
  leaf[3]= new nanoleaf(x[3], y[3], x[3]+triwid/2, y[3]+uper_len, x[3]+triwid, y[3]);
  leaf[4]= new nanoleaf(x[4], y[4], x[4]+triwid/2, y[4]-uper_len, x[4]+triwid, y[4]);
  size(800, 800);
}
float x_4 = 350;
//int c =0
int c = 0;
boolean send_start =false;
boolean commuication = false;
void draw() {
  background(255);
  //println(device_state);
  //println(condition_state);

  stroke(45);
  fill(200);
  for (int y = 0; y<device_num; y++) {
    leaf[y].display();
  }
  rect(0, size_l/2, size_l, size_l/2);
  for (int y = 0; y<condition_num_ar[device_state]; y++) {
    if (y==condition_state) {
      condition_btn[device_state][y].rectaddbtn(500, 600+y*30, 100, 30, 3, 0, 255, condition_text[device_state][y], 15, true);
    } else {
      condition_btn[device_state][y].rectaddbtn(500, 600+y*30, 100, 30, 3, 0, 255, condition_text[device_state][y], 15, false);
    }
  }
  all.rectaddbtn(size_l/2, 470, 100, 30, 3, 0, 255, "all", 15, false);
  if (device_state==device_num) {
    all.rectaddbtn(size_l/2, 470, 100, 30, 3, 0, 255, "all", 15, true);
  }
  x_4 = size_l/2-(device_num/2*100-50);
  c=1;
  for (int i = 0; i<device_num; i++) {
    if (i==device_state) {
      state[i].rectaddbtn(x_4, 500, 100, 30, 3, 0, 255, i+1+"", 15, true);
      x_4+=100;
      c++;
    } else {
      state[i].rectaddbtn(x_4, 500, 100, 30, 3, 0, 255, i+1+"", 15, false);
      x_4+=100;
      c++;
    }
  }
  if (device_state!=device_num) {
    textSize(20);
  }
  if (click==true) {
    for (int y = 0; y<condition_num_ar[device_state]; y++) {
      if (condition_btn[device_state][y].detect(mouseX, mouseY)) {
        condition_state = y;
      }
    }
    for (int i = 0; i<device_num; i++) {
      if (state[i].detect(mouseX, mouseY)) {
        //println("yeah");
        device_state=i;
        condition_state=0;
      }
    }
    if (send.detect(mouseX, mouseY)) {
      send_press=true;
    } else {
      send_press=false;
    }
    if (all.detect(mouseX, mouseY)) {
      device_state=device_num;
    }
    //println(device_state);
  } else {  
    send_press=false;
  }

  send.rectaddbtn(size_l-70, size_h-70, 100, 30, 3, 0, 255, "send", 32, send_press);
  for (int a=0; a<3; a++) {
    controls[device_state][a].dessine();
  }
  noStroke();
  put=send.detect(mouseX, mouseY);
  if (send_press==true) {
    //println(send_press);
  }
  if (click==true) {
    for (int a=0; a<3; a++) {
      controls[device_state][a].lache();
    }
  }
  //breathing_light(123, 45, 4, 1);



  if (send_press==true) {
    commuication=true;
    send_times=0;
  }
  if (commuication==true) {
    if (send_times==0) {
      //btserial.write(byte(2));
      println((send_byte(round(controls[device_state][0].val), round(controls[device_state][1].val), round(controls[device_state][2].val), device_state, send_times, condition_state)));
      println(":"+send_times);
      btserial.write(send_byte(round(controls[device_state][0].val), round(controls[device_state][1].val), round(controls[device_state][2].val), device_state, send_times, condition_state));
      send_times++;
    }
  }
  //if (commuication==true) {
  //  //if (btserial.available()>0) {
  //  if (btserial.read()==byte(0)) {
  //    send_start=true;
  //  }
  //  //println(btserial.read());
  //  //}
  //  if (send_times==0) {
  //    //btserial.write(byte(2));
  //    btserial.write(breathing_light(123, 45, 4, 1, send_times));
  //    send_times++;
  //  }

  //  if (send_start==true) {
  //    if (breathing_light(123, 45, 4, 1, send_times)!=byte(0)) {
  //      btserial.write((breathing_light(round(controls[0].val), round(controls[1].val), round(controls[2].val), 1, send_times)));
  //      println((breathing_light(round(controls[0].val), round(controls[1].val), round(controls[2].val), 1, send_times)));
  //    } else {
  //      println("-------------");
  //      send_start=false;
  //      commuication=false;
  //      send_times=0;
  //    }
  //    send_times++;
  //  }
  //}

  //while (btserial.available() > 0) {
  //if (btserial.read()==byte(100)) {
  //println("w3");
  if (commuication==true) {
    if (btserial.read()==byte(100)) {
      println("yeah_100");
      if (send_byte(round(controls[device_state][0].val), round(controls[device_state][1].val), round(controls[device_state][2].val), device_state, send_times, condition_state)!=byte(123)) {
        btserial.write((send_byte(round(controls[device_state][0].val), round(controls[device_state][1].val), round(controls[device_state][2].val), device_state, send_times, condition_state)));
        println((send_byte(round(controls[device_state][0].val), round(controls[device_state][1].val), round(controls[device_state][2].val), device_state, send_times, condition_state)));
      } else {
        println("-------------");
        send_start=false;
        commuication=false;
        send_times=0;
      }
      send_times++;
      //}
      //}
    }
  }
  send_press =false;

  click = false;

  //void serialEvent(Serial p) {
  //if (p.readBytes()==byte(0));

  //}
}
void mouseReleased() {

  click =true;
}

void keyPressed() {
}

byte send_byte(int r, int g, int b, int device, int times, int mode) {
  //String output = ;
  byte output []= new byte[7];
  byte c = 1;
  output[0] = byte(9);
  output[1] = byte(device);
  output[2] = byte(r);
  output[3] = byte(g);
  output[4] = byte(b);
  output[5] = byte(mode);
  output[6] = byte(10);
  //println(byte(r));
  if (times<=6) {
    return(output[times]);
  } else {
    return(byte(123));
  }
}
