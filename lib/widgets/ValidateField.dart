String validateRequiredField(String value) {
  if (value == null || value == "") {
    return "É necessário preencher esse campo.";
  }
  return null;
}
