class Employe {

  final int id;

  final String firstName;

  final String lastName;

  final String emailId;

  const Employe({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.emailId
  });

  factory Employe.fromJson(Map<String, dynamic> json){

    return Employe(id: json['id'], firstName:json['firstName'], lastName: json['lastName'],emailId: json['emailId']);
  }


}