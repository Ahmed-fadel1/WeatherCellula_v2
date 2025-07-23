double weatherConditionToDouble(String condition) {
  switch (condition.toLowerCase()) {
    case 'clear':
      return 0.0;
    case 'cloudy':
      return 1.0;
    case 'rain':
      return 2.0;
    case 'snow':
      return 3.0;
    case 'sunny':
      return 4.0;
    default:
      return 5.0;
  }
}
