import 'package:encrypt/encrypt.dart';
import 'package:defenders/utils/api_path.dart';

String encrypt({required String text}) {
  final key = Key.fromUtf8(ApiPath.secretKey);
  final encrypter = Encrypter(
    AES(key, mode: AESMode.ecb),
  );
  final iv = IV.fromLength(16);
  final ecnryptText = encrypter.encrypt(text, iv: iv);
  return ecnryptText.base64;
}

String decryptMethod({required String text}) {
  final key = Key.fromUtf8(ApiPath.secretKey);
  final encrypter = Encrypter(
    AES(key, mode: AESMode.ecb),
  );
  final iv = IV.fromLength(16);
  final ecnryptText = encrypter.decrypt(Key.fromBase64(text), iv: iv);
  return ecnryptText;
}

String asciiToHex(String asciiStr) {
  List<int> chars = asciiStr.codeUnits;
  StringBuffer hex = StringBuffer();
  for (int ch in chars) {
    hex.write(ch.toRadixString(16).padLeft(2, '0'));
  }
  return hex.toString();
}
