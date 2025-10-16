class ResponseModel<T extends Serializable> {
  T? data;

  ResponseModel({
    this.data,
  });

  ResponseModel.fromJson(
      Map<String, dynamic> json, Function(Map<String, dynamic>) create) {
    if (json['data'] != null) {
      data = create(json['data']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['data'] = data?.toJson();
    return json;
  }
}

class ListResponseModel<T extends Serializable> {
  String? status;
  int? totalResults;
  List<T>? articles;

  ListResponseModel({this.status, this.totalResults, this.articles});

  ListResponseModel.fromJson(
      Map<String, dynamic> json, List<T> Function(List<dynamic>) build) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = build(json['articles']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['status'] = status;
    json['totalResults'] = totalResults;
    json['articles'] = articles?.map((e) => e.toJson()).toList();
    return json;
  }
}

abstract class Serializable {
  Map<String, dynamic> toJson();
}
