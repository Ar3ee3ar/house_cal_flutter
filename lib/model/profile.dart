class Profile{
  String? username;
  String? password;

  Profile({this.username, this.password});

  String? getUsername(){
    username = this.username;
    return username;
  }
}