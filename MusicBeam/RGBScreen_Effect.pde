class RGBScreen_Effect extends Effect
{
  String getName() {
    return "RGB Screen";
  }

  char triggeredByKey() {
    return '9';
  }

  RGBScreen_Effect(MusicBeam ctrl, int y)
  {
    super(ctrl, y);

    manualButton = cp5.addButton("manual"+getName()).setSize(195, 195).setPosition(0, 5).setGroup(controlGroup);
    manualButton.getCaptionLabel().set("Manual Trigger").align(ControlP5.CENTER, ControlP5.CENTER);

    hatToggle = cp5.addToggle("hat"+getName()).setSize(195, 45).setPosition(200, 5).setGroup(controlGroup);
    hatToggle.getCaptionLabel().set("Hat").align(ControlP5.CENTER, ControlP5.CENTER);

    snareToggle = cp5.addToggle("snare"+getName()).setSize(195, 45).setPosition(200, 55).setGroup(controlGroup);
    snareToggle.getCaptionLabel().set("Snare").align(ControlP5.CENTER, ControlP5.CENTER);

    kickToggle = cp5.addToggle("kick"+getName()).setSize(195, 45).setPosition(200, 105).setGroup(controlGroup);
    kickToggle.getCaptionLabel().set("Kick").align(ControlP5.CENTER, ControlP5.CENTER);
    kickToggle.setState(true);

    onsetToggle = cp5.addToggle("onset"+getName()).setSize(195, 45).setPosition(200, 155).setGroup(controlGroup);
    onsetToggle.getCaptionLabel().set("Peak").align(ControlP5.CENTER, ControlP5.CENTER);
    onsetToggle.setState(true);

    delaySlider = cp5.addSlider("delay"+getName()).setRange(0.01,1).setValue(0.3).setPosition(0, 205).setSize(395, 45).setGroup(controlGroup);
    delaySlider.getCaptionLabel().set("Speed").align(ControlP5.RIGHT, ControlP5.CENTER);

  }

  float[] rx = {0,0};
  float[] ry = {0,0};
  float[] rc = {0,0};

  float timer = 0;

  float fader = 0;

  Button manualButton;

  Toggle hatToggle, snareToggle, kickToggle, onsetToggle;

  Slider delaySlider;

  float radius = 0;

  void draw()
  {
    //radius = stg.getMinRadius()*radiusSlider.getValue();
    radius = stg.width;
    translate(-stg.width/2, -stg.height/2);

    if (timer<=0 && (isTriggeredByBeat() || isTriggeredManually()))
    {
      rc[0] = random(0, 6);
      timer = delaySlider.getValue()*frameRate*3;
      fader = frameRate/4;
    }

  stg.fill(60*rc[0], 100, 100);
  stg.rect(0, 0, stg.width, stg.height);


    if (timer>0)
      timer--;
    if (fader>0)
      fader--;
  }

  boolean isTriggeredManually()
  {
    return manualButton.isPressed() || effect_manual_triggered;
  }

  boolean isTriggeredByBeat()
  {
    return
      hatToggle.getState() && isHat() ||
      snareToggle.getState() && isSnare() ||
      kickToggle.getState() && isKick() ||
      onsetToggle.getState() && isOnset();
  }
}
