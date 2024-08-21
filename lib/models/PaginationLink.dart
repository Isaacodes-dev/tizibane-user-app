class PaginationLink {
  String? url;
  String label;
  bool active;

  PaginationLink({
    this.url,
    required this.label,
    required this.active,
  });

  factory PaginationLink.fromJson(Map<String, dynamic> json) {
    return PaginationLink(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'label': label,
      'active': active,
    };
  }
}

class Pagination {
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<PaginationLink> links;

  Pagination({
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    var linksFromJson = json['links'] as List;
    List<PaginationLink> linkList = linksFromJson.map((linkJson) => PaginationLink.fromJson(linkJson)).toList();

    return Pagination(
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      links: linkList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_page_url': firstPageUrl,
      'from': from,
      'last_page': lastPage,
      'last_page_url': lastPageUrl,
      'links': links.map((link) => link.toJson()).toList(),
    };
  }
}
