import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_website/widgets/dotted_line.dart';
import '../models/resource.dart';
import '../widgets/nav_bar.dart';
import '../widgets/footer.dart';
import '../utils/responsive_helper.dart';
import '../controllers/theme_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Data class for goal items
class GoalItem {
  final String text;
  final bool completed;
  final String? date;

  GoalItem({required this.text, required this.completed, this.date});
}

class ResourceDetailScreen extends StatelessWidget {
  final Resource resource;
  final ThemeController themeController = Get.find<ThemeController>();

  ResourceDetailScreen({super.key, required this.resource});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = themeController.isDarkMode;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF18181B) : Colors.white,
      body: Column(
        children: [
          // Navigation bar
          const NavBar(currentIndex: 3),

          // Main content
          Expanded(
            child: SingleChildScrollView(
              child: Responsive.responsiveContainer(
                context: context,
                child: Padding(
                  padding: Responsive.responsivePadding(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Header section
                      const SizedBox(height: 40),
                      _buildHeader(context),
                      const SizedBox(height: 36),

                      // Resource content based on type
                      _buildResourceContent(context),

                      // Footer
                      const SizedBox(height: 80),
                      const Footer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isDarkMode = themeController.isDarkMode;

    return Column(
      children: [
        // Title with emoji and angle brackets
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Left arrow
            Text(
              "›",
              style: TextStyle(
                color: isDarkMode ? Colors.grey : Colors.grey,
                fontSize: 24,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(width: 8),

            // Emoji
            Text(resource.emoji ?? "🔮", style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 12),

            // Title text
            Text(
              resource.title,
              style: TextStyle(
                fontFamily: 'HankenGrotesk',
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(width: 8),

            // Right arrow
            Text(
              "‹",
              style: TextStyle(
                color: isDarkMode ? Colors.grey : Colors.grey,
                fontSize: 24,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Description (only for Design Tips)
        if (resource.title == "Design Tips")
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              "A collection of design tips that I've learned over the years",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'HankenGrotesk',
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color:
                    isDarkMode
                        ? themeController.textSecondaryColor
                        : themeController.textSecondaryColor,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildResourceContent(BuildContext context) {
    // Different content based on resource type
    if (resource.title == "Design Tips") {
      return _buildDesignTipsList(context);
    } else if (resource.title == "Visual Ideas") {
      return _buildComingSoon(context);
    } else if (resource.title == "My Impossible List") {
      return _buildImpossibleList(context);
    } else {
      return _buildComingSoon(context);
    }
  }

  Widget _buildDesignTipsList(BuildContext context) {
    final isDarkMode = themeController.isDarkMode;
    final isMobile = Responsive.isMobile(context);

    // Design tips from the screenshot
    final designTips = [
      "Be kind",
      "Take a 1-hour walk every day",
      "Keep learning, even when you think you're an expert",
      "Invest in a quality mouse",
      "Take care of your mind",
      "Stay hungry, stay foolish",
      "Invest in a quality chair",
      "Don't skip meals",
      "Use a wrist rest",
      "Keep a water bottle at your desk",
      "Experiment and have fun",
      "Take frequent stretch breaks",
      "Recreate a design",
      "Your worth is more than you think",
      "Practice empathy",
      "Make time for hobbies outside of design",
      "Don't overuse colors",
      "Maintain good posture",
      "Don't be afraid to iterate",
      "Always carry a pocket notebook & pen",
      "Don't put too much pressure on yourself. Just do the best you can (for you, your team, your people)",
      "Don't compare yourself to others",
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < designTips.length; i++)
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${i + 1}. ",
                        style: TextStyle(
                          fontFamily: 'HankenGrotesk',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          designTips[i],
                          style: TextStyle(
                            fontFamily: 'HankenGrotesk',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Add dotted line after each item except the last one
                if (i < designTips.length - 1)
                  CustomPaint(
                    painter: DottedLinePainter(
                      color:
                          isDarkMode
                              ? Colors.grey.withOpacity(0.3)
                              : Colors.grey.withOpacity(0.4),
                    ),
                    size: const Size(double.infinity, 1),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildComingSoon(BuildContext context) {
    final isDarkMode = themeController.isDarkMode;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Column(
          children: [
            FaIcon(
              FontAwesomeIcons.hammer,
              size: 48,
              color: isDarkMode ? Colors.grey : Colors.grey[600],
            ),
            const SizedBox(height: 16),
            Text(
              "Coming Soon",
              style: TextStyle(
                fontFamily: 'HankenGrotesk',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "This section is currently under development",
              style: TextStyle(
                fontFamily: 'HankenGrotesk',
                fontSize: 16,
                color:
                    isDarkMode
                        ? themeController.textSecondaryColor
                        : themeController.textSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImpossibleList(BuildContext context) {
    final isDarkMode = themeController.isDarkMode;
    final isMobile = Responsive.isMobile(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Introduction text
          Text(
            "My personal bucket list of challenging goals and aspirations",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'HankenGrotesk',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color:
                  isDarkMode
                      ? themeController.textSecondaryColor
                      : themeController.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 32),

          // Call to action
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontFamily: 'HankenGrotesk',
                fontSize: 16,
                height: 1.5,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              children: [
                TextSpan(
                  text:
                      "I will be updating this list regularly. If you are someone who can help me make one of these a reality, please ",
                ),
                TextSpan(
                  text: "get in touch",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: isDarkMode ? Colors.blue.shade300 : Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Last updated
          Text(
            "Last updated on May 4, 2025",
            style: TextStyle(
              fontFamily: 'HankenGrotesk',
              fontSize: 16,
              color:
                  isDarkMode
                      ? themeController.textSecondaryColor
                      : themeController.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 32),

          // Life Goals section
          _buildGoalSection(
            context,
            "LIFE GOALS",
            isDarkMode,
            emoji: "😀",
            goals: [
              GoalItem(
                text: "Read 100 books",
                completed: true,
                date: "JUL 11, 2024",
              ),
              GoalItem(
                text: "Change 1 Person's Life For The Better",
                completed: false,
              ),
              GoalItem(
                text: "Own a Kindle reader",
                completed: true,
                date: "OCT 14, 2023",
              ),
              GoalItem(
                text: "Own an iPad",
                completed: true,
                date: "SEPT 07, 2024",
              ),
              GoalItem(
                text: "Own a MacBook",
                completed: true,
                date: "JUL 07, 2023",
              ),
              GoalItem(
                text: "Own an Apple Watch",
                completed: true,
                date: "DEC 17, 2023",
              ),
              GoalItem(
                text: "Own an iPhone",
                completed: true,
                date: "DEC 05, 2022",
              ),
              GoalItem(text: "Give a TEDx Talk", completed: false),
              GoalItem(text: "Attend an Apple Event", completed: false),
              GoalItem(
                text: "Spend 11 days without phone",
                completed: true,
                date: "SEP 11, 2023",
              ),
              GoalItem(
                text: "Spend one week without internet",
                completed: false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGoalSection(
    BuildContext context,
    String title,
    bool isDarkMode, {
    required String emoji,
    required List<GoalItem> goals,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header with dotted line
        Row(
          children: [
            Text(
              "$emoji $title",
              style: TextStyle(
                fontFamily: 'HankenGrotesk',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomPaint(
                painter: DottedLinePainter(
                  color:
                      isDarkMode
                          ? Colors.grey.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.4),
                ),
                size: const Size(double.infinity, 1),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Goals list
        ...goals.map((goal) => _buildGoalItem(context, goal, isDarkMode)),
      ],
    );
  }

  Widget _buildGoalItem(BuildContext context, GoalItem goal, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Checkbox
          Container(
            margin: const EdgeInsets.only(top: 3),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: goal.completed ? Colors.green : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color:
                    goal.completed
                        ? Colors.green
                        : (isDarkMode ? Colors.grey : Colors.grey.shade400),
                width: 2,
              ),
            ),
            child:
                goal.completed
                    ? const Icon(Icons.check, size: 14, color: Colors.white)
                    : null,
          ),
          const SizedBox(width: 12),

          // Goal text and date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  goal.text,
                  style: TextStyle(
                    fontFamily: 'HankenGrotesk',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? Colors.white : Colors.black,
                    decoration:
                        goal.completed ? TextDecoration.lineThrough : null,
                    decorationColor: Colors.grey,
                    decorationThickness: 2,
                  ),
                ),
                if (goal.date != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      children: [
                        Text(
                          "✦",
                          style: TextStyle(
                            color:
                                isDarkMode ? Colors.grey : Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          goal.date!,
                          style: TextStyle(
                            fontFamily: 'HankenGrotesk',
                            fontSize: 14,
                            color:
                                isDarkMode ? Colors.grey : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for dotted line

