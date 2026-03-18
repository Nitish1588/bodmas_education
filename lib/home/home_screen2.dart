import 'package:flutter/material.dart';

import '../blog/blog_service.dart';
import '../blog/widgets/blog_card.dart';
import '../blog/widgets/blog_card_skeleton.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {

  List blogs = [];
  List paginationLinks = [];

  bool isLoading = true;

  int currentPage = 1;

  /// FETCH BLOGS

  Future<void> fetchBlogs(int page) async {

    setState(() {
      isLoading = true;
    });

    /// minimum skeleton time
    await Future.delayed(const Duration(seconds: 1));

    final data = await BlogService.fetchBlogs(page);

    setState(() {

      blogs = data["data"];
      paginationLinks = data["links"];

      currentPage = data["current_page"];

      isLoading = false;

    });
  }

  @override
  void initState() {
    super.initState();
    fetchBlogs(1);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Bodmas Education",style: TextStyle(color: Color(0xFFFFFFFF),
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        ),
        backgroundColor: Color(0xFF4CAF50),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFFFFFFFF)),
      ),

      body: Padding(
        padding: const EdgeInsets.all(15),

        child: Column(

          children: [

            /// BLOG GRID

            Expanded(

              child: isLoading

              /// SKELETON GRID

                  ? GridView.builder(

                itemCount: 10,

                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.9,
                ),

                itemBuilder: (context,index){

                  return const BlogCardSkeleton();

                },
              )

              /// BLOG GRID

                  : GridView.builder(

                itemCount: blogs.length,

                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.9,
                ),

                itemBuilder: (context,index){

                  return BlogCard(
                    blog: blogs[index],
                  );
                },
              ),

            ),

            const SizedBox(height: 10),

            /// PAGINATION BAR (Dynamic)

            if(!isLoading)

              SizedBox(
                height: 35,

                child: ListView.builder(

                  scrollDirection: Axis.horizontal,

                  itemCount: paginationLinks.length,

                  itemBuilder: (context,index){

                    var link = paginationLinks[index];

                    String label = link["label"]
                        .replaceAll("&laquo;", "«")
                        .replaceAll("&raquo;", "»");

                    bool isActive = link["active"];
                    bool isDisabled = link["url"] == null;

                    int page = currentPage;

                    if(link["url"] != null){

                      Uri uri = Uri.parse(link["url"]);

                      page = int.parse(
                          uri.queryParameters["page"] ?? "1");

                    }

                    return GestureDetector(

                      onTap: isDisabled
                          ? null
                          : (){
                        fetchBlogs(page);
                      },

                      child: Container(

                        margin: const EdgeInsets.symmetric(horizontal:4),

                        padding: const EdgeInsets.symmetric(
                            horizontal:12,
                            vertical:8),

                        decoration: BoxDecoration(

                          color: isActive
                              ? Colors.green
                              : Colors.grey.shade300,

                          borderRadius: BorderRadius.circular(5),

                        ),

                        child: Text(

                          label,

                          style: TextStyle(

                            color: isActive
                                ? Colors.white
                                : Colors.black,

                            fontWeight: FontWeight.w500,

                          ),

                        ),

                      ),
                    );
                  },
                ),
              ),

            const SizedBox(height: 40),

          ],
        ),
      ),
    );
  }
}