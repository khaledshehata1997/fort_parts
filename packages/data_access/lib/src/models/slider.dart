class Slider {
  Slider({
    required this.title,
    required this.subTitle,
    required this.image,
  });

  final String title;
  final String subTitle;
  final String image;

  factory Slider.fromJson(Map<String, dynamic> json) {
    return Slider(
      title: json['title'],
      subTitle: json['sub_title'],
      image: json['image'],
    );
  }
}
