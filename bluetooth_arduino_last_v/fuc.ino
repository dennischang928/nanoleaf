void fade(int device, int r , int g , int b, int brightness) {
  if (device == device_num) {
    for (int i = 0; i < device_num * 26; i++) {
      leds[i].setRGB(r, g, b);
      leds[i].maximizeBrightness(brightness);
    }
  } else {
    for (int c = device * 26; c < (device + 1) * 26; c++) {
      leds[c].setRGB(r, g, b);
      leds[c].maximizeBrightness(brightness);
    }
  }
}

void whole_led(int device, int r , int g , int b) {
  //  Serial.println(device_num);
  if (device == device_num) {
    for (int i = 0; i < device_num * 26; i++) {
      Serial.println(i);
      leds[i].maximizeBrightness(200);
      leds[i].setRGB(r, g, b);
    }
  } else {
    for (int c = device * 26; c < (device + 1) * 26; c++) {
      leds[c].maximizeBrightness(200);
      leds[c].setRGB(r, g, b);
    }
  }
}
