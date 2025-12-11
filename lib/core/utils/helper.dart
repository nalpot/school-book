bool isValidImage(String url) {
  final validExtension =
      url.contains('.png') || url.contains('.jpg') || url.contains('.jpeg');
  final validProtocol = url.startsWith('http');
  return validExtension && validProtocol;
}
