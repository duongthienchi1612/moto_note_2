class Database {
  static const accessories = 'accessories';
}

class PreferenceKey {
  static const language = 'LANGUAGE';
}

class ImagePath {
  static const gryImage = 'assets/images/gry_trans.png';
  static const ravImage = 'assets/images/rav_trans.png';
  static const hufImage = 'assets/images/huf_trans.png';
  static const slyImage = 'assets/images/sly_trans.png';
  static const background_question = 'assets/images/background_question.png';
  static const background_result = 'assets/images/background_result.png';
  static const splash_screen = 'assets/images/splash_screen.png';
  static const icon_hat = 'assets/images/icon_hat.png';

  static const houses = [gryImage, ravImage, hufImage, slyImage];

  static const allImage = [
    gryImage,
    ravImage,
    hufImage,
    slyImage,
    background_question,
    background_result,
    splash_screen,
    icon_hat
  ];
}

class ScreenName {
  static const home = '/home';
  static const result = '/result';
  static const question = '/question';
}