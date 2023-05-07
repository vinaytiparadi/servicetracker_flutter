String? validateCustomerName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Name cannot be empty.';
  }
  return null;
}

String? validateCustomerPrimaryContactNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Contact Number cannot be empty.';
  }
  if (value.length != 10) {
    return 'Contact Number must be 10 digits.';
  }
  return null;
}

String? validateCustomerSecondaryContactNumber(String? value) {
  if (value != null && value.isNotEmpty && value.length != 10) {
    return 'Contact Number must be 10 digits.';
  }
  return null;
}

String? validateSmartPhoneBrand(String? value) {
  if (value == null || value.isEmpty) {
    return 'Smart Phone Brand cannot be empty.';
  }
  return null;
}

String? validateSmartPhoneModel(String? value) {
  if (value == null || value.isEmpty) {
    return 'SmartPhone Brand Model cannot be empty.';
  }
  return null;
}

String? validateRepairCost(String? value) {
  if (value == null || value.isEmpty) {
    return 'Cost cannot be empty.';
  }
  if (double.parse(value) < 0) {
    return 'Cost cannot be negative.';
  }
  return null;
}
