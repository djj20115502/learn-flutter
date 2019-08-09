abstract class Utils {
  static String buildImgUrl(String imgPath) {
    if (imgPath == null) {
      return "";
    }
    if (imgPath != null && imgPath.startsWith("http")) {
      return imgPath;
    }
    return "http://img.i.cacf.cn/" + imgPath;
  }
}
