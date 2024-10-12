
//Methods for checking textfields
String TitleCheck(String text){
  if(text.isEmpty){return "Title cannot be empty";}
  return "";
}
String SubTitleCheck(String text){
  if(text.isEmpty){return "Subtitle cannot be empty";}

  return "";
}

String PasswordCheck(String text){
  if(text.isEmpty){return "Fill in password";}
  if(text.length<6){return "Password must be at least 6 characters";}
  return "";
}
/* Checking equal passwords
String RepeatPasswordCheck(String password, String password2){
  if(password2.isEmpty){return "Fill in password";}
  if(password != password2){return "Passwords dont match";}
  return "";
}*/

String EmailCheck(String text){
  if(text.isEmpty){return "Please fill in the email";}
  if(!text.validateEmail()){return "Enter the correct value";}
  return "";
}

//Checking email
extension RegexExt on String {
  bool validateEmail() => RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(this);
}