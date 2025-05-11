import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import '../models/project.dart';
import '../config/routes.dart';

class ProjectsController extends GetxController {
  // Observable list of all projects
  final RxList<Project> projects = allProjects.obs;

  // Observable for selected project (if needed)
  final Rx<Project?> selectedProject = Rx<Project?>(null);

  // Observable for loading state
  final RxBool isLoading = false.obs;

  // Observable for active filter
  final RxString activeFilter = 'All'.obs;

  // Available filters
  List<String> get filters => ['All', 'Web', 'App'];

  // Get filtered projects based on active filter
  List<Project> get filteredProjects {
    if (activeFilter.value == 'All') {
      return projects;
    }

    final ProjectType filterType = ProjectType.values.firstWhere(
      (type) => type.toString().split('.').last == activeFilter.value.toLowerCase(),
      orElse: () => ProjectType.web,
    );

    return projects.where((project) => project.type == filterType).toList();
  }

  // Get featured projects (first 3 projects)
  List<Project> get featuredProjects => projects.take(3).toList();

  // Method to select a project
  void selectProject(Project project) {
    selectedProject.value = project;
  }

  // Method to clear selected project
  void clearSelectedProject() {
    selectedProject.value = null;
  }

  // Method to filter projects by search query
  List<Project> filterProjects(String query) {
    if (query.isEmpty) return projects;

    return projects.where((project) {
      final title = project.title.toLowerCase();
      final description = project.description.toLowerCase();
      final searchQuery = query.toLowerCase();

      return title.contains(searchQuery) || description.contains(searchQuery);
    }).toList();
  }

  // Method to set active filter
  void setFilter(String filter) {
    activeFilter.value = filter;
  }

  // Method to navigate to project detail
  void navigateToProjectDetail(String projectTitle) {
    Get.toNamed('${AppRoutes.works}?project=$projectTitle');
  }

  // Method to get project by title
  Project getProjectById(String title) {
    return projects.firstWhere(
      (project) => project.title == title,
      orElse: () => projects.first,
    );
  }

  // Method to open project (either live link or github link)
  void openProject(Project project) {
    if (project.liveLink != null) {
      launchProjectLink(project.liveLink!);
    } else if (project.githubLink != null) {
      launchProjectLink(project.githubLink!);
    } else {
      Get.snackbar(
        'Info',
        'No external links available for this project',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey[900],
        colorText: Colors.white,
      );
    }
  }

  // Method to launch external URLs
  Future<void> launchProjectLink(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Could not launch $url: $e');
      Get.snackbar(
        'Error',
        'Could not open the link',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey[900],
        colorText: Colors.white,
      );
    }
  }
}
