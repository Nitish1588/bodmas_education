import 'package:flutter/material.dart';
import '../model/course_model.dart';
import '../model/state_model.dart';



class FilterSection extends StatelessWidget {

  final List<CourseModel> courses;
  final List<StateModel> states;

  final int? selectedCourse;
  final int? selectedState;

  final Function(int?) onCourseChanged;
  final Function(int?) onStateChanged;

  final VoidCallback onSearch;

  const FilterSection({
    super.key,
    required this.courses,
    required this.states,
    required this.selectedCourse,
    required this.selectedState,
    required this.onCourseChanged,
    required this.onStateChanged,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF3B82F6),
            Color(0xFF2563EB),
          ],
        ),

        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        children: [

          Row(
            children: [

              Expanded(
                child: dropdownCourse(),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: dropdownState(),
              ),
            ],
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,

            child: ElevatedButton.icon(

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
              ),

              onPressed: onSearch,

              icon: const Icon(Icons.search),

              label: const Text("Search Cutoff"),
            ),
          ),
        ],
      ),
    );
  }

  Widget dropdownCourse() {

    return dropdownContainer(
      child: DropdownButton<int>(
        value: selectedCourse,

        isExpanded: true,
        menuMaxHeight: 350,
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(10),
        style: const TextStyle(
          color: Colors.white,
        ),

        hint: const Text(
          "Course",
          style: TextStyle(color: Colors.white),
        ),

        iconEnabledColor: Colors.black,

        underline: const SizedBox(),

        items: [

          const DropdownMenuItem<int>(
            value: null,
            child: Text(
              "All Courses",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),

          ...courses.map((course) {

            return DropdownMenuItem<int>(
              value: course.id,

              child: Text(
                course.title,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            );

          }),
        ],

        onChanged: onCourseChanged,
      )
    );
  }

  Widget dropdownState() {

    return dropdownContainer(
      child: DropdownButton<int>(
        value: selectedState,
        isExpanded: true,
        menuMaxHeight: 350,
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(10),

        style: const TextStyle(
          color: Colors.white,
        ),

        hint: const Text(
          "State",
          style: TextStyle(color: Colors.white),
        ),

        iconEnabledColor: Colors.black,

        underline: const SizedBox(),

        items: [

          const DropdownMenuItem<int>(
            value: null,
            child: Text(
              "All States",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),

          ...states.map((state) {

            return DropdownMenuItem<int>(
              value: state.id,

              child: Text(
                state.name,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            );

          }),
        ],

        onChanged: onStateChanged,
      )
    );
  }

  Widget dropdownContainer({
    required Widget child,
  }) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),

      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(10),
      ),

      child: child,
    );
  }
}