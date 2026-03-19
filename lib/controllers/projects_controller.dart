import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import '../models/project.dart';
import '../config/routes.dart';

class ProjectsController extends GetxController {
  final RxList<Project> projects = allProjects.obs;
  final Rx<Project?> selectedProject = Rx<Project?>(null);
  final RxBool isLoading = false.obs;
  final RxString activeFilter = 'All'.obs;
  final RxString searchQuery = ''.obs;

  List<String> get filters => ['All', 'Web', 'App'];

  List<Project> get filteredProjects {
    var list = projects.toList();

    // Filter by type
    if (activeFilter.value != 'All') {
      final ProjectType filterType = ProjectType.values.firstWhere(
        (type) =>
            type.toString().split('.').last ==
            activeFilter.value.toLowerCase(),
        orElse: () => ProjectType.web,
      );
      list = list.where((project) => project.type == filterType).toList();
    }

    // Filter by search query
    final q = searchQuery.value.trim().toLowerCase();
    if (q.isNotEmpty) {
      list = list.where((project) {
        final title = project.title.toLowerCase();
        final description = project.description.toLowerCase();
        final tech = project.technologies.join(' ').toLowerCase();
        return title.contains(q) ||
            description.contains(q) ||
            tech.contains(q);
      }).toList();
    }

    return list;
  }

  List<Project> get featuredProjects => projects.take(3).toList();

  void selectProject(Project project) {
    selectedProject.value = project;
  }

  void clearSelectedProject() {
    selectedProject.value = null;
  }

  void setFilter(String filter) {
    activeFilter.value = filter;
  }

  void setSearchQuery(String q) => searchQuery.value = q;

  void navigateToProjectDetail(String projectTitle) {
    Get.toNamed('${AppRoutes.works}?project=$projectTitle');
  }

  Project getProjectById(String title) {
    return projects.firstWhere(
      (project) => project.title == title,
      orElse: () => projects.first,
    );
  }

  void openProject(Project project) {
    Get.toNamed(AppRoutes.worksDetail, arguments: project);
  }

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
