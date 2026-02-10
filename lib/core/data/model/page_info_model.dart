class PageInfoModel {
  bool hasNextPage;
  bool hasPreviousPage;
  String startCursor;
  String endCursor;

  PageInfoModel({
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.startCursor,
    required this.endCursor,
  });

  factory PageInfoModel.fromJson(Map<String, dynamic> json) => PageInfoModel(
        hasNextPage: json["hasNextPage"],
        hasPreviousPage: json["hasPreviousPage"],
        startCursor: json["startCursor"] ?? "",
        endCursor: json["endCursor"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "hasNextPage": hasNextPage,
        "hasPreviousPage": hasPreviousPage,
        "startCursor": startCursor,
        "endCursor": endCursor,
      };
}
