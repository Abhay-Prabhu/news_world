// class newsCategoryModel {
//   String? status;
//   int? totalResults;
//   List<Results>? results;
//   Null nextPage;

//   newsCategoryModel(
//       {this.status, this.totalResults, this.results, this.nextPage});

//   newsCategoryModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     totalResults = json['totalResults'];
//     if (json['results'] != null) {
//       results = <Results>[];
//       json['results'].forEach((v) {
//         results!.add(new Results.fromJson(v));
//       });
//     }
//     nextPage = json['nextPage'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['totalResults'] = this.totalResults;
//     if (this.results != null) {
//       data['results'] = this.results!.map((v) => v.toJson()).toList();
//     }
//     data['nextPage'] = this.nextPage;
//     return data;
//   }
// }

// class Results {
//   String? id;
//   String? name;
//   String? url;
//   String? icon;
//   int? priority;
//   String? description;
//   List<String>? category;
//   List<String>? language;
//   List<String>? country;
//   String? lastFetch;

//   Results(
//       {this.id,
//       this.name,
//       this.url,
//       this.icon,
//       this.priority,
//       this.description,
//       this.category,
//       this.language,
//       this.country,
//       this.lastFetch});

//   Results.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     url = json['url'];
//     icon = json['icon'];
//     priority = json['priority'];
//     description = json['description'];
//     category = json['category'].cast<String>();
//     language = json['language'].cast<String>();
//     country = json['country'].cast<String>();
//     lastFetch = json['last_fetch'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['url'] = this.url;
//     data['icon'] = this.icon;
//     data['priority'] = this.priority;
//     data['description'] = this.description;
//     data['category'] = this.category;
//     data['language'] = this.language;
//     data['country'] = this.country;
//     data['last_fetch'] = this.lastFetch;
//     return data;
//   }
// }



class newsCategoryModel {
  Pagination? pagination;
  List<Data>? data;

  newsCategoryModel({this.pagination, this.data});

  newsCategoryModel.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pagination {
  int? limit;
  int? offset;
  int? count;
  int? total;

  Pagination({this.limit, this.offset, this.count, this.total});

  Pagination.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    offset = json['offset'];
    count = json['count'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    data['count'] = this.count;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  String? author;
  String? title;
  String? description;
  String? url;
  String? source;
  String? image;
  String? category;
  String? language;
  String? country;
  String? publishedAt;

  Data(
      {this.author,
      this.title,
      this.description,
      this.url,
      this.source,
      this.image,
      this.category,
      this.language,
      this.country,
      this.publishedAt});

  Data.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    source = json['source'];
    image = json['image'];
    category = json['category'];
    language = json['language'];
    country = json['country'];
    publishedAt = json['published_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['source'] = this.source;
    data['image'] = this.image;
    data['category'] = this.category;
    data['language'] = this.language;
    data['country'] = this.country;
    data['published_at'] = this.publishedAt;
    return data;
  }
}
