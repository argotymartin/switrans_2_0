class UsuarioRequest {
  final String identity;
  final String password;
  final String token;

  const UsuarioRequest({
    this.identity = '',
    this.password = '',
    this.token = '',
  });

  Map<String, dynamic> toJson() => {
        'identity': identity,
        'password': password,
        'token': token,
      };
}
