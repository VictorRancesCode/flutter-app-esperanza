class Person {
  Person(
      int id,
      String email,
      String first_name,
      String last_name,
      String nickname,
      String place,
      String date,
      String photo,
      String comment_photo,
      int age,
      String gender,
      String detail,
      String type_publication) {
    this.id = id;
    this.email = email;
    this.first_name = first_name;
    this.last_name = last_name;
    this.nickname = nickname;
    this.place = place;
    this.date = date;
    this.photo = photo;
    this.comment_photo = comment_photo;
    this.age = age;
    this.gender = gender;
    this.detail = detail;
    this.type_publication = type_publication;
  }

  int id;
  String email;
  String first_name;
  String last_name;
  String nickname;
  String place;
  String date;
  String photo;
  String comment_photo;
  int age;
  String gender;
  String detail;
  String type_publication;

  bool get isValid => id != null;
}
