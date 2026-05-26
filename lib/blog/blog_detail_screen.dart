import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:url_launcher/url_launcher_string.dart';
class BlogDetailScreen extends StatelessWidget {

  final Map blog;

  const BlogDetailScreen({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    String cleanedContent = blog["content"] ?? "";

// remove enquiry form
    cleanedContent = cleanedContent.replaceAll("[enquiry-form]", "");

// remove only Froala text, not full tag
    cleanedContent = cleanedContent.replaceAll(
      RegExp(r'<p[^>]*>[^<]*Powered by\s*<a[^>]*>Froala Editor<\/a><\/p>', caseSensitive: false),
      "",
    );
    return Scaffold(

      appBar: AppBar(
        title: Text(blog["title"],style: TextStyle(
          fontSize: 17,
        ),
        ),

      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(15),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Image.network(
              "https://bodmaseducation.com/images/feature/${blog["feature_image"]}",
            ),

            const SizedBox(height: 10),

            // Text(
            //   blog["title"],
            //   style: const TextStyle(
            //     fontSize: 22,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            //
            // const SizedBox(height: 20),
            //
            // Text(
            //   blog["content"] ?? "",
            //   style: const TextStyle(fontSize: 16),
            // ),

            Html(
              data: cleanedContent,

              extensions: const [
                TableHtmlExtension(),
              ],

              style: {

                "h1": Style(
                  fontSize: FontSize(18),
                  fontWeight: FontWeight.w600,
                ),

                "h2": Style(
                  fontSize: FontSize(16),
                  fontWeight: FontWeight.w600,
                ),

                "h3": Style(
                  fontSize: FontSize(14),
                  fontWeight: FontWeight.w600,
                ),
                "h4": Style(
                  fontSize: FontSize(14),
                  fontWeight: FontWeight.w600,

                ),
                "h5": Style(
                  fontSize: FontSize(14),
                  fontWeight: FontWeight.w600,

                ),

                "p": Style(
                  fontSize: FontSize(14),
                  color: Colors.black,
                ),

                "li": Style(
                  fontSize: FontSize(13),
                  color: Colors.black,
                ),

                /// TABLE STYLE
                "table": Style(
                  border: Border.all(color: Colors.grey.shade300),
                  backgroundColor: Colors.white,
                  margin: Margins.symmetric(vertical: 5),
                ),

                "th": Style(
                  padding: HtmlPaddings.all(6),
                  backgroundColor: Colors.blue.shade50,
                  border: Border.all(color: Colors.grey.shade300),
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),

                "td": Style(
                  padding: HtmlPaddings.all(6),
                  border: Border.all(color: Colors.grey.shade300),
                  fontSize: FontSize(13),
                ),

                /// Responsive Images
                "img": Style(
                  width: Width.auto(),
                ),
                "a": Style(
                  color: Colors.blue,
                  //textDecoration: TextDecoration.underline,
                ),
              },
              // ✅ Links handle
              onLinkTap: (url, attributes, element) async {
                if (url != null) {
                  if (await canLaunchUrlString(url)) {
                    await launchUrlString(url, mode: LaunchMode.externalApplication);
                  } else {

                    debugPrint("Cannot open this link: $url");
                  }
                }
              },

            ),



          ],
        ),
      ),
    );
  }
}