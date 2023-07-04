class Credentials {
  final Email email;
  final String password;

  Credentials(this.email, this.password);
}

class Email {
  final String value;

  Email(this.value);

  bool call() {
    // return EmailValidator.validate(value);
    return true;
  }
}
