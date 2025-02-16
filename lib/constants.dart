class DatabaseName {
  DatabaseName._();
  static const moteNote = 'moto_note.db';
  static const masterData = 'master_data.db';
}

class DatabaseTable {
  DatabaseTable._();
  static const accessories = 'accessories';
  static const accessoriesType = 'accessories_type';
  static const devices = 'devices';
  static const users = 'users';
  static const sqlSemiColonEncode = r'\003B';
}

class PreferenceKey {
  PreferenceKey._();
  static const language = 'LANGUAGE';
  static const currentUserId = 'CURRENT_USER_ID';
  static const currentUserName = 'CURRENT_USER_NAME';
  static const currentKm = 'CURRENT_KM';
}

class ImagePath {
  ImagePath._();
  static const splash_screen = 'assets/images/splash_screen.png';
  static const contermet = 'assets/images/contermet.png';
  static const background7 = 'assets/images/background7.png';
}

class ScreenName {
  ScreenName._();
  static const home = '/home';
}

class Constants {
  Constants._();
  static const borderRadius = 22.0;
  static const rangeOfYear = 50;
  static const offsetShowIconDeleted = -80.0;
  static const archorKm = 400;
}

class SortField {
  SortField._();
  static const name = 'NAME';
  static const lastKm = 'LASTKM';
  static const lastDate = 'LASTDATE';
  static const nextKm = 'NEXTKM';
  static const aZ = 'AZ';
  static const Za = 'ZA';
}

class MotoAnimation {
  MotoAnimation._();

  static const movingFrame = 10;
  static const accelerateFrame = 12;
  static const brakeFrame = 14;
  static const Map<String, int> motoActionFrame = {
    accelerate: 12,
    brake: 14,
  };

  // moto color
  static const motoYellow = 'yellow';
  static const motoGreen = 'green';
  static const motoBlue = 'blue';
  static const motoRed = 'red';

  // moto action
  static const accelerate = 'accelerate';
  static const brake = 'brake';
  static const moving = 'moving';

  static const motoColors = [motoBlue, motoYellow, motoGreen, motoRed];
  static const motoAction = [accelerate, brake];
}
