class UniversityModel {
  List<String> domains;
  String country;
  dynamic stateProvince;
  String alphaTwoCode;
  List<String> webPages;
  String name;

  UniversityModel({
    required this.domains,
    required this.country,
    this.stateProvince,
    required this.alphaTwoCode,
    required this.webPages,
    required this.name,
  });

  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    return UniversityModel(
      domains: List<String>.from(json['domains']),
      country: json['country'],
      stateProvince: json['state-province'],
      alphaTwoCode: json['alpha_two_code'],
      webPages: List<String>.from(json['web_pages']),
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'domains': domains,
    'country': country,
    'state-province': stateProvince,
    'alpha_two_code': alphaTwoCode,
    'web_pages': webPages,
    'name': name,
  };
}
