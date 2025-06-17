class Config {
  /*
  -----------Global-----------
  */
  static String appname = 'SATU';
  static String dbPassword = "DerfREwge4";

  static bool isDev = env == "development";

  static String storeUrl = "itms-apps://itunes.apple.com/app/satu/6466696271";
  static String privacyUrl = "https://cmms.satu-innovative.com/privacy";

  /*
  -----------Development-----------
  */
  // static String env = "development";
  // static String restUrl = "http://192.168.1.36:5401";

  /*
  -----------Production-----------
  */
  static String env = "production";
  static String restUrl = "https://cmms.satu-innovative.com/api";
}
