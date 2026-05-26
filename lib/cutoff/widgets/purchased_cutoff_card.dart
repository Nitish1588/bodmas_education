import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../../env.dart';
import '../model/purchased_cutoff_model.dart';

class PurchasedCutoffCard extends StatelessWidget {
  final PurchasedCutoffModel item;
  final String token;
  final String downloadUrl;

  const PurchasedCutoffCard({
    super.key,
    required this.item,
    required this.token,
    required this.downloadUrl,
  });
  Future<void> downloadAndOpenPDF(String url, {String? token}) async {
    try {
      final response = await http.get(
        Uri.parse(url),

        headers: {if (token != null) 'Authorization': 'Bearer $token'},
      );

      final dir = await getTemporaryDirectory();

      final file = File("${dir.path}/cutoff.pdf");

      await file.writeAsBytes(response.bodyBytes);

      await OpenFile.open(file.path);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPaid = item.status.toLowerCase() == 'paid';

    return Container(
      margin: const EdgeInsets.only(bottom: 14),

      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),

        gradient: LinearGradient(
          colors: isPaid
              ? [const Color(0xff5B86E5), const Color(0xff36D1DC)]
              : [const Color(0xffFF9966), const Color(0xffFF5E62)],
        ),
      ),

      child: Row(
        children: [
          /// IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(8),

            child: Image.network(
              "${Env.imgCutoff}/${item.image}",
              width: 60,
              height: 60,

              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          /// DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  item.productName,

                  maxLines: 2,

                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    Text(
                      "₹${item.amount}",

                      style: const TextStyle(color: Colors.white70),
                    ),

                    //const SizedBox(height: 4),
                    Spacer(),

                    Text(
                      DateFormat(
                        'dd MMM yy',
                      ).format(DateTime.parse(item.createdAt)),

                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          /// DOWNLOAD
          if (isPaid)
            InkWell(
              // onTap: () {
              //   final url = "$downloadUrl/${item.packageId}";
              //
              //   Navigator.push(
              //     context,
              //
              //     MaterialPageRoute(
              //       builder: (_) {
              //         return Scaffold(
              //           appBar: AppBar(title: Text(item.productName)),
              //
              //           body: SfPdfViewer.network(
              //             url,
              //
              //             headers: {'Authorization': 'Bearer $token'},
              //             canShowScrollHead: true,
              //             canShowPaginationDialog: true,
              //           ),
              //         );
              //       },
              //     ),
              //   );
              // },
              onTap: () {
                final pdfUrl = "$downloadUrl/${item.packageId}";

                downloadAndOpenPDF(pdfUrl, token: token);
              },

              child: Container(
                padding: const EdgeInsets.all(10),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(50),
                ),

                child: const Icon(Icons.download_rounded, color: Colors.blue),
              ),
            ),

          /// PENDING
          if (!isPaid)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(30),
              ),

              child: const Text(
                "PENDING",

                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
