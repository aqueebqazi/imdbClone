class GetShowId {
  String id;
  GetShowId({required this.id});
  factory GetShowId.FromJson(Map<String, dynamic> json) {
    return GetShowId(id: json["id"]);
  }
}
