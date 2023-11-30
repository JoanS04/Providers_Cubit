class DataStateLogin {
  String usuario = "";


  DataStateLogin();
}

class CorrectLoginDataState extends DataStateLogin{
  final String username;

  CorrectLoginDataState(this.username);
}



class ErrorDataState extends DataStateLogin{
  final String error;

  ErrorDataState(this.error);
}