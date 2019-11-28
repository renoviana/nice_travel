class ApiConnection {
//  static const URL_API = "https://nice-travel2.herokuapp.com";
  static const URL_API = "http://192.168.25.185:8080";

  static String encodeFull(String url) {
    var urlFormatted = Uri.encodeFull(url);
    print(urlFormatted);
    return urlFormatted;
  }
}
