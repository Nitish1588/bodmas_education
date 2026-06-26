import 'package:flutter/material.dart';
import '../blog/blog_service.dart';
import '../blog/blog_webview_screen.dart';
import '../widgets/rotating_waves.dart';
import 'quick_blog_card.dart';

class QuickBlogSection extends StatefulWidget {
  final VoidCallback onViewAll;

  const QuickBlogSection({super.key, required this.onViewAll});

  @override
  State<QuickBlogSection> createState() => _QuickBlogSectionState();
}

class _QuickBlogSectionState extends State<QuickBlogSection> {
  List blogs = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadBlogs();
  }

  Future<void> loadBlogs() async {
    try {
      final data = await BlogService.fetchBlogs(1);

      setState(() {
        blogs = data["data"] ?? [];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// HEADER
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade700, Colors.indigo.shade500],
                  ),
                  boxShadow: [
                    BoxShadow(color: Colors.blue.shade200, blurRadius: 12),
                  ],
                ),
                child: const Icon(
                  Icons.article_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),

              const SizedBox(width: 15),

              const Expanded(
                child: Text(
                  "Latest News",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
              ),

              InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: widget.onViewAll,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue.shade50,
                  ),
                  child: Text(
                    "View All",
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        /// LOADING
        if (isLoading)
          const SizedBox(
            height: 180,
            child: Center(
              child: RotatingWaves(
                size: 150,
                color: Colors.lightBlue,
                centered: true,
              ),
            ),
          )
        else
          /// BLOG LIST
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: blogs.length > 6 ? 6 : blogs.length,

              itemBuilder: (context, index) {
                final blog = blogs[index];

                return QuickBlogCard(
                  blog: blog,

                  onTap: () {
                    final slug = blog["slug"];

                    final url =
                        "https://bodmaseducation.com/blog_details/$slug";

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlogWebViewScreen(
                          url: url,
                          title: blog["title"] ?? "Blog",
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
