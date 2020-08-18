#include <FastLED.h>
#include <SoftwareSerial.h>
#include <EasyTransfer.h>
#define LED_PIN     4
#define NUM_LEDS    109
#define BRIGHTNESS  200
#define LED_TYPE    WS2811
#define COLOR_ORDER GRB
#define UPDATES_PER_SECOND 10

EasyTransfer ET;
SoftwareSerial bluetooth(bttx, btrx);
CRGBPalette16 currentPalette;
TBlendType    currentBlending;
CRGB leds[NUM_LEDS];
extern CRGBPalette16 myRedWhiteBluePalette;
extern const TProgmemPalette16 myRedWhiteBluePalette_p PROGMEM;





struct audio {
  double a1;
  double a2;
  double a3;
  double a4;
};
boolean led_start_1 = false;
int bttx = 10;  //tx of blue_inputtooth module is connected to pin 9 of arduino
int btrx = 11;
byte led_state[] = {2, 4, 8, 3, 6};
int device_num = 4;
boolean  bt_test_fin = true;
boolean start = false;
long timer = 0;
int bluetooth_times = 0 ;
int i = 58;
int blue_input [7];
boolean all = false;
int r[5];
int g[5] ;
int b[5] ;
int mode_state[5];
int device_state;
int condition_state;
int r_a , g_a, b_a;
audio tx;
audio rx ;



void setup() {
  Serial.begin(9600);
  bluetooth.begin(9600);
  ET.begin(details(tx), &Serial);
  FastLED.addLeds<LED_TYPE, LED_PIN, COLOR_ORDER>(leds, NUM_LEDS).setCorrection( TypicalLEDStrip );
  FastLED.setBrightness(BRIGHTNESS );
  currentPalette = RainbowColors_p;
  currentBlending = LINEARBLEND;
  timer = millis();
  pinMode(5, OUTPUT);
  pinMode(13, OUTPUT);
  for (int i = 0; i < device_num + 1; i++) {
    mode_state[i] = 7;
  }
  mode_state[0] = 7;
}
void loop() {
  if (ET.receiveData()) {
    rx = tx;
    Serial.println(tx.a1);
  }
  if (bluetooth.available() > 0) {
    led_start_1 = false;
    blue_input[bluetooth_times] = (String(bluetooth.read())).toInt();
    bluetooth.write(byte(100));
    bluetooth_times++;
    if (bluetooth_times == 7 && blue_input[6] == 10) {
      led_start_1 = true;
      for (int i = 0; i < 7; i++) {
        Serial.println(blue_input[i]);
      }
      bluetooth_times = 0;
      Serial.println(blue_input[1]);
      Serial.println("-------------------");
      device_state = blue_input[1];
      condition_state = blue_input[5];
      r_a = blue_input[2];
      g_a = blue_input[3];
      b_a = blue_input[4];
    }
  }
  if (blue_input[1] != device_num && led_start_1 == true) {
    r[blue_input[1]] = blue_input[2];
    g[blue_input[1]] = blue_input[3];
    b[blue_input[1]] = blue_input[4];
    mode_state[blue_input[1]] = blue_input[5];
    int r_match [device_num + 1];
    int g_match [device_num + 1];
    int b_match [device_num + 1];
    int mode_match[device_num + 1];
    int r_match_1 [device_num + 1];
    int g_match_1 [device_num + 1];
    int b_match_1 [device_num + 1];
    int mode_match_1[device_num + 1];
    int nums = 0;
    int nums_1 = 0;
    for (int i = 0; i < device_num + 1; i++) {
      if (mode_state[i] == 0) {
        mode_match[nums] = i;
        nums++;
      }
      if (mode_state[i] == 1) {

        mode_match_1[nums_1] = i;
        nums_1++;
      }
    }
    for (int i = 0; i < nums_1; i++) {
      whole_led(mode_match_1[i], r[mode_match_1[i]], g[mode_match_1[i]], b[mode_match_1[i]]);
    }
    for (int c = 0; c < 25; c++) {
      for (int i = 0; i < nums; i++) {
        fade(mode_match[i], r[mode_match[i]], g[mode_match[i]], b[mode_match[i]], 200 - c * 8); //
      }
      delay(3);
      FastLED.show();
    }
    for (int c = 0; c < 25; c++) {
      for (int i = 0; i < nums; i++) {
        fade(mode_match[i], r[mode_match[i]], g[mode_match[i]], b[mode_match[i]], c * 8 ); //
      }
      delay(3);
      FastLED.show();
    }
    nums = 0;
  } else if (led_start_1 == true) {

    device_state = blue_input[1];
    condition_state = blue_input[5];
    r_a = blue_input[2];
    g_a = blue_input[3];
    b_a = blue_input[4];
    if (condition_state == 0) {
      for (int c = 0; c < 25; c++) {
        if (condition_state == 0) {
          fade(device_state, r_a, g_a, b_a, 200 - c * 8);
          delay(10);
          FastLED.show();
        }
      }
      for (int c = 0; c < 25; c++) {
        if (condition_state == 0) {
          fade(device_state, r_a, g_a, b_a, c * 8);
          delay(10);
          FastLED.show();
        }
      }
    } else if (condition_state == 1) {
      whole_led(device_state, r_a, g_a, b_a);
      FastLED.show();
    } else if (condition_state == 2) {
      int color_r[] = {249, 255, 218};
      int color_g[] = {199, 93, 0};
      int color_b[] = {255, 0, 42};
      int color_code = random(0, 3);
      int start = random(0, device_num + 1 / 2) * 26;
      int fin = random(device_num + 1 / 2, device_num + 1) * 26;
      for (int c = start; c < fin; c++) {
        leds[c].setRGB( color_r[color_code],  color_g[color_code],  color_b[color_code]);
        FastLED.show();
        delay(random(4, 8));
      }
      for (int c = start; c < fin; c++) {
        leds[fin - c].setRGB(0, 0, 0);
        FastLED.show();
        delay(random(4, 8));
      }
    } else if (condition_state == 3) {
      int color_r[] = {0, 0, 0};
      int color_g[] = {172, 255, 0};
      int color_b[] = {255, 255, 255};
      int color_code = random(0, 3);
      int start = random(0, device_num + 1 / 2) * 26;
      int fin = random(device_num + 1 / 2, device_num + 1) * 26;
      for (int c = start; c < fin; c++) {
        leds[c].setRGB( color_r[color_code],  color_g[color_code],  color_b[color_code]);
        FastLED.show();
        delay(random(4, 8));
      }
      for (int c = start; c < fin; c++) {
        leds[fin - c].setRGB(0, 0, 0);
        FastLED.show();
        delay(random(4, 8));
      }
    } else if (condition_state == 4) {

      digitalWrite(5, LOW);
      if (ET.receiveData()) {

        
        fade(0, r_a, g_a, b_a, tx.a1);
        fade(1, r_a, g_a, b_a, tx.a2);
        fade(2, r_a, g_a, b_a, tx.a3);
        fade(3, r_a, g_a, b_a, tx.a4);


        FastLED.show();
        fade(0, 0, 0, 0, tx.a1);
        fade(1, 0, 0, 0, tx.a2);
        fade(2, 0, 0, 0, tx.a3);
        fade(3, 0, 0, 0, tx.a4);
      } else {
      }
    }
  }
}
