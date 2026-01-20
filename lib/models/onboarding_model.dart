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
      imagePath: 'assets/images/onboarding1.png', // Replace with your actual image
    ),
    OnboardingModel(
      title: 'Easy to Use',
      description: 'Simple and intuitive interface for a seamless experience',
      imagePath: 'assets/images/onboarding2.png', // Replace with your actual image
    ),
    OnboardingModel(
      title: 'Get Started',
      description: 'Join thousands of satisfied users today',
      imagePath: 'assets/images/onboarding3.png', // Replace with your actual image
    ),
  ];
}
