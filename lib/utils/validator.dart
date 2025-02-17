class Validators {
  static String? validateAmount(String? str) {
    if (str!.isEmpty) {
      return 'Amount field is Required';
    } else if (str.startsWith('0')) {
      return 'Please enter valid amount';
    }
    return null;
  }

  static String? validateMobile(String? value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(patttern);
    if (value!.isEmpty) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  static String? validatePanno(String? value) {
    String patttern = r"^([a-zA-Z]){5}([0-9]){4}([a-zA-Z]){1}?$";
    RegExp regExp = RegExp(patttern);
    if (value!.isEmpty) {
      return "Pan Number field is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Please enter a valid Pan Number";
    }
    return null;
  }

  static String? validateGstinNo(String value) {
    String patttern =
        r"^([0]{1}[1-9]{1}|[1-2]{1}[0-9]{1}|[3]{1}[0-7]{1})([a-zA-Z]{5}[0-9]{4}[a-zA-Z]{1}[1-9a-zA-Z]{1}[zZ]{1}[0-9a-zA-Z]{1})+$";
    RegExp regExp = RegExp(patttern);
    if (value.isEmpty) {
      return null;
    } else if (!regExp.hasMatch(value) && value.isEmpty) {
      return "Please enter a valid Gstin Number";
    }
    return null;
  }

  static String? validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Mobile Number field is Required";
    } else if (value.length != 10) {
      return "Please enter a valid Mobile Number";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return "Email ID field is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Please enter a valid Email ID";
    }
    return null;
  }

  static validatePassword(String? value) {
    String pattern =
        r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@$!+=_#^%*?&])([a-zA-Z0-9@$!+=_#^%*?&]{8,})$';

    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return "Password field is Required";
    }
    // else if (value.length < 4) {
    //   return "Password should be more than 4 characters";
    // }
    else if (!regExp.hasMatch(value)) {
      return "Password must contain eight characters,one capital letter,\none number and one special character";
    }
    return null;
  }

  static String? validateName(String value) {
    if (value.isEmpty) {
      return "First name field is required";
    }
    return null;
  }

  static String? validateLastName(String value) {
    if (value.isEmpty) {
      return "Last name field is required";
    }
    return null;
  }

  static String? validatePinCode(String? value) {
    if (value!.isEmpty) {
      return "Pin Code field is Required";
    } else if (value.length < 6) {
      return "Please enter a valid Pin Code";
    }
    return null;
  }

  static String? validateAccIfsc(String? value) {
    String pattern = r'^[A-Z]{4}0[A-Z0-9]{6}$';
    RegExp regExp = RegExp(pattern);

    if (value!.isEmpty) {
      return 'IFSC Field is required';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid IFSC code';
    }
    return null;
  }

  static String? validateMrId(String? value) {
    String pattern = r"^([a-zA-Z]){2}([0-9]){5}?$";
    String pattern2 = r"([0-9]){10}?$";
    RegExp regExp = RegExp(pattern);
    RegExp regExp2 = RegExp(pattern2);
    if (value!.isEmpty) {
      return "Mobile number field is Required";
    } else if (!regExp.hasMatch(value) && !regExp2.hasMatch(value)) {
      return "Please enter a valid Mobile no";
    }
    return null;
  }

  static String? aadharNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Aadhar Number field is Required";
    } else if (value.length != 12) {
      return "Please enter a valid Aadhar Number";
    }
    return null;
  }
}
