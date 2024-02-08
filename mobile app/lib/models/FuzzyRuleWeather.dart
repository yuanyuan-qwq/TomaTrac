// Fuzzy Logic Function for providing care recommendations
String provideCareRecommendations(
    int chanceOfRain, int AVGtemperature, int AVGhumidity, int AVGwindSpeed) {
  String result = '';

  // Fuzzy rules
  if (chanceOfRain >= 85 && AVGhumidity >= 90) {
    //High probability rain AND High Humidity
    result =
        'Get ready for rain! Protect your plants from overwatering with shields for their thriving growth.';
  } else if (AVGtemperature >= 28 && AVGhumidity <= 80) {
    //High temperature AND Low Humidity
    result =
        'Feeling the heat? Your plants are too! Treat them to a refreshing deep watering in the morning and evening.';
  } else if (AVGwindSpeed >= 25) {
    //Hight wind speed
    result =
        'Hold onto your gardening hats! Your green companions might need a shield from the gusty winds.';
  } else if (AVGtemperature >= 26) {
    //High temperature
    result = 'It\'s a hot one! Ensure tomato plants receive adequate watering.';
  } else {
    result = 'Your plants are chilling like plant villains!';
  }

  return result;
}
