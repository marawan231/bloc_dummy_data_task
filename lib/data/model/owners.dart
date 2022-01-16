class Owners {
  bool isFav = false;
  late int id;

  late String fullName;

  late Owner owner;

  Owners.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    fullName = json['full_name'];

    owner = (json['owner'] != null ? Owner.fromJson(json['owner']) : null)!;
  }
}

class Owner {
  late String avatarUrl;

  Owner.fromJson(Map<String, dynamic> json) {
    avatarUrl = json['avatar_url'];
  }
}
