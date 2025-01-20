class OnBoarding {
  OnBoarding({
    required this.title,
    required this.subTitle,
    required this.image,
  });

  final String title;
  final String subTitle;
  final String image;

  factory OnBoarding.fromJson(Map<String, dynamic> json) {
    return OnBoarding(
      title: json['title'],
      subTitle: json['sub_title'],
      image: json['image'],
    );
  }
}
