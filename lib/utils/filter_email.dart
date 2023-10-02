bool isEmailValid(String email) {
  // รูปแบบของอีเมลที่ต้องการตรวจสอบ
  RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');

  // ตรวจสอบรูปแบบของอีเมล
  if (emailRegex.hasMatch(email)) {
    return true;
  }

  return false;
}

bool checkEmailDomain(String email, String desiredDomain) {
  RegExp regExp = RegExp(r'@(.+)');
  String domain = regExp.firstMatch(email)?.group(1) ?? '';
  return domain == desiredDomain;
}
