import 'package:bodmas_education/event/event_screen.dart';
import 'package:flutter/material.dart';
import 'blog_service.dart';
import 'widgets/blog_card.dart';
import 'widgets/blog_card_skeleton.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {

  List blogs = [];
  bool initialLoading = true;
  bool loadMoreLoading = false;
  int page = 1;
  bool isLoading = false;
  bool hasMore = true;

  Future<void> fetchBlogs() async {

    if (loadMoreLoading || !hasMore) return;

    if(page == 1){
      initialLoading = true;
    }else{
      loadMoreLoading = true;
    }

    setState(() {});



    final data = await BlogService.fetchBlogs(page);

    List newBlogs = data["data"];

    setState(() {

      blogs.addAll(newBlogs);

      if(data["next_page_url"] == null){
        hasMore = false;
      }else{
        page++;
      }

      initialLoading = false;
      loadMoreLoading = false;

    });

  }

  @override
  void initState() {
    super.initState();
    fetchBlogs();
  }
  Future<void> refreshBlogs() async {
    page = 1;
    blogs.clear();
    hasMore = true;

    await fetchBlogs();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Blogs")),

      body: Padding(
        padding: const EdgeInsets.all(10),

        child: Column(
          children: [

            // SizedBox(
            //   width: double.infinity,
            //   height: 45,
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: const Color(0xFF4CAF50), // Green background
            //       foregroundColor: const Color(0xFFFFFFFF), // White text
            //     ),
            //     child: const Text("Home-2"),
            //     onPressed: () {
            //
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (_) => const HomeScreen2()),
            //       );
            //
            //     },
            //   ),
            // ),



            /// BLOG GRID
            Expanded(

                child: RefreshIndicator(
                  onRefresh: refreshBlogs,
                  child: initialLoading

                  ? GridView.builder(
                itemCount: 10,

                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.9,
                ),

                itemBuilder: (context,index){



                  return const BlogCardSkeleton();

                },
              )

              /// BLOG LIST

                  : GridView.builder(

                itemCount: blogs.length +

                    (loadMoreLoading ? 4 : 0),

                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.85,
                ),

                itemBuilder: (context,index){

                  /// pagination skeleton

                  if(index >= blogs.length){

                    return const BlogCardSkeleton();

                  }

                  return BlogCard(
                    blog: blogs[index],
                  );

                },
              ),
            ),
            ),
            const SizedBox(height: 10),

            /// LOAD MORE BUTTON
            if(hasMore && !loadMoreLoading)
              SizedBox(
                width: double.infinity,
                height: 35,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50), // Green background
                    foregroundColor: const Color(0xFFFFFFFF), // White text
                  ),
                  onPressed: fetchBlogs,
                  child: const Text("Load More"),
                ),
              ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50), // Green background
                  foregroundColor: const Color(0xFFFFFFFF), // White text
                ),
                child: const Text("Events"),
                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EventScreen()),
                  );

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}