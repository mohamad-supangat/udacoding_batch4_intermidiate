List<PopularVideo> popularVideosFromJson(List popularVideo) =>
    List<PopularVideo>.from(popularVideo.map((x) => PopularVideo.fromJson(x)));

class PopularVideo {
  String id;
  String title;
  String description;
  String thumbnailUrl;
  List<String> tags;

  PopularVideo({
    this.title,
    this.description,
    this.thumbnailUrl,
    this.tags,
    this.id,
  });

  PopularVideo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    thumbnailUrl = json['thumbnail_url'];
    tags = json['tags'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['thumbnail_url'] = this.thumbnailUrl;
    data['tags'] = this.tags;
    return data;
  }
}
