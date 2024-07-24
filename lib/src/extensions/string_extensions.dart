extension AppString on String {
  String toMediaTypeStr() {
    return toLowerCase().replaceAll(" ", "");
  }

  String toMediaUITypeStr() {
    return replaceAll("-", " ").toTitleCase();
  }

  String toTitleCase() {
    return split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }
}
