class OnboardingModel {
  final String title;
  final String description;
  final String imagePath;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.imagePath,
  });

  static List<OnboardingModel> onboardingItems = [
    OnboardingModel(
      title: 'Welcome to BharatPlus',
      description: 'Discover amazing features and services at your fingertips',
      imagePath: 'https://f9tech.blr1.digitaloceanspaces.com/vv/images/activities/644-banner-image-_oiryc1n8g.jpg', // Replace with your actual image
    ),
    OnboardingModel(
      title: 'Easy to Use',
      description: 'Simple and intuitive interface for a seamless experience',
      imagePath: 'https://f9tech.blr1.digitaloceanspaces.com/vv/images/activities/644-banner-image-_oiryc1n8g.jpg', // Replace with your actual image
    ),
    OnboardingModel(
      title: 'Get Started',
      description: 'Join thousands of satisfied users today',
      imagePath: 'https://f9tech.blr1.digitaloceanspaces.com/vv/images/activities/644-banner-image-_oiryc1n8g.jpg', // Replace with your actual image
    ),
  ];
}
