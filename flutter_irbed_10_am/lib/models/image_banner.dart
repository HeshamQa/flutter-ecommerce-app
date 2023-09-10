class ImageBanner {
  var Id;
  var ImageUrl;
  var URL;

  ImageBanner({
    required this.Id,
    required this.ImageUrl,
    required this.URL,
  });

  factory ImageBanner.fromJson(var json) {
    return ImageBanner(
      Id: json['Id'],
      ImageUrl: json['ImageUrl'],
      URL: json['URL'],
    );
  }
}
