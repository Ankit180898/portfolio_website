class UserProfile {
  final String name;
  final String title;
  final String description;
  final String avatarUrl;
  final List<SocialLink> socialLinks;
  final String email;

  UserProfile({
    required this.name,
    required this.title,
    required this.description,
    required this.avatarUrl,
    required this.socialLinks,
    required this.email,
  });
}

class SocialLink {
  final String name;
  final String url;
  final String icon;

  SocialLink({required this.name, required this.url, required this.icon});
}

final UserProfile profile = UserProfile(
  name: "Ankit Kumar",
  title: "Product Designer, Illustrator & Developer",
  description: "Currently shaping user experiences at Brainfish.",
  avatarUrl: "assets/images/avatar.png",
  socialLinks: [
    SocialLink(
      name: "GitHub",
      url: "https://github.com/Ankit180898",
      icon: "github",
    ),
    SocialLink(
      name: "LinkedIn",
      url: "https://linkedin.com/in/yourusername",
      icon: "linkedin",
    ),
    SocialLink(
      name: "Twitter",
      url: "https://twitter.com/yourusername",
      icon: "twitter",
    ),
  ],
  email: "hello@ankitkumar.com",
);
