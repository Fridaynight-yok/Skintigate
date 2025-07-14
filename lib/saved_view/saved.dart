// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:skintigate/util/storage.dart';

// class Saved extends StatefulWidget {
//   const Saved({super.key});

//   @override
//   State<Saved> createState() => _SavedState();
// }

// class _SavedState extends State<Saved> {
//   String? userId;

//   @override
//   void initState() {
//     super.initState();
//     loadUserId();
//   }

//   void loadUserId() async {
//     final id = await Storage().getUserId();
//     setState(() {
//       userId = id;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(
//           "สินค้าที่ถูกใจ",
//           style: GoogleFonts.athiti(
//             fontSize: 24,
//             color: Color.fromRGBO(35, 96, 77, 1),
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//       ),
//       body: userId == null
//           ? Center(
//               child: GestureDetector(
//                 onTap: () {
//                   Get.toNamed('/login');
//                 },
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'กรุณาเข้าสู่ระบบ เพื่อดูสินค้าที่บันทึกไว้',
//                       style: GoogleFonts.athiti(
//                         fontSize: 18,
//                         color: Color.fromRGBO(35, 96, 77, 1),
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     ElevatedButton(
//                       onPressed: () {
//                         Get.toNamed("/login");
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color.fromRGBO(13, 152, 106, 1),
//                       ),
//                       child: SizedBox(
//                         width: 70,
//                         height: 40,
//                         child: Center(
//                           child: Text(
//                             "เข้าสู่ระบบ",
//                             style: GoogleFonts.athiti(
//                               fontSize: 16,
//                               color: Colors.white,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           : StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('favorites')
//                   .where('users', isEqualTo: userId)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return const Center(child: Text("ยังไม่มีสินค้าที่ถูกใจ 🥺"));
//                 }

//                 final products = snapshot.data!.docs
//                     .map((doc) => doc.data() as Map<String, dynamic>)
//                     .toList();
//                 // final docs = snapshot.data!.docs;

//                 return Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 8,
//                   ),
//                   child: GridView.builder(
//                     itemCount: products.length,
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           crossAxisSpacing: 16,
//                           mainAxisSpacing: 16,
//                           childAspectRatio: 0.7,
//                         ),
//                     itemBuilder: (context, index) {
//                       final item = products[index];
//                       return GestureDetector(
//                         onTap: () {
//                           Get.toNamed("/product", arguments: item);
//                         },
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               height: 120,
//                               decoration: BoxDecoration(
//                                 color: const Color.fromARGB(255, 249, 249, 249),
//                                 borderRadius: BorderRadius.circular(16),
//                                 boxShadow: const [
//                                   BoxShadow(
//                                     color: Colors.black26,
//                                     blurRadius: 4,
//                                     offset: Offset(0, 2),
//                                   ),
//                                 ],
//                               ),
//                               child: Center(
//                                 child: CachedNetworkImage(
//                                   imageUrl: item['image'] ?? '',
//                                   fit: BoxFit.cover,
//                                   placeholder: (context, url) =>
//                                       const CircularProgressIndicator(),
//                                   errorWidget: (context, url, error) =>
//                                       const Icon(Icons.error),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 6),
//                             Text(
//                               item['name'] ?? '',
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.w500,
//                                 color: Color.fromRGBO(32, 76, 75, 1),
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             Text(
//                               item['skinmatch'] ?? '',
//                               style: GoogleFonts.athiti(
//                                 fontSize: 13,
//                                 color: Colors.grey,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             const SizedBox(height: 2),
//                             Row(
//                               children: [
//                                 Flexible(
//                                   child: Text(
//                                     item['rating']?.toString() ?? '0.0',
//                                     style: GoogleFonts.athiti(
//                                       fontSize: 13,
//                                       color: Colors.grey,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                     maxLines: 1,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 4),
//                                 const Icon(
//                                   Icons.star,
//                                   color: Colors.amber,
//                                   size: 14,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skintigate/util/storage.dart';

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  String? userId;

  @override
  void initState() {
    super.initState();
    loadUserId();
  }

  void loadUserId() async {
    final id = await Storage().getUserId();
    setState(() {
      userId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "สินค้าที่ถูกใจ",
          style: GoogleFonts.athiti(
            fontSize: 24,
            color: const Color.fromRGBO(35, 96, 77, 1),
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: userId == null
          ? Center(
              child: GestureDetector(
                onTap: () {
                  Get.toNamed('/login');
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'กรุณาเข้าสู่ระบบ เพื่อดูสินค้าที่บันทึกไว้',
                      style: GoogleFonts.athiti(
                        fontSize: 18,
                        color: const Color.fromRGBO(35, 96, 77, 1),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed("/login");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(13, 152, 106, 1),
                      ),
                      child: SizedBox(
                        width: 70,
                        height: 40,
                        child: Center(
                          child: Text(
                            "เข้าสู่ระบบ",
                            style: GoogleFonts.athiti(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('favorites')
                  .where('users', isEqualTo: userId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("ยังไม่มีสินค้าที่ถูกใจ 🥺"));
                }

                final docs = snapshot.data!.docs;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: GridView.builder(
                    itemCount: docs.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.7,
                        ),
                    itemBuilder: (context, index) {
                      final doc = docs[index];
                      final item = doc.data() as Map<String, dynamic>;

                      return GestureDetector(
                        onTap: () {
                          Get.toNamed("/product", arguments: item);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                      255,
                                      249,
                                      249,
                                      249,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: CachedNetworkImage(
                                      imageUrl: item['image'] ?? '',
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection('favorites')
                                          .doc(doc.id)
                                          .delete();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              item['name'] ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(32, 76, 75, 1),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              item['skinmatch'] ?? '',
                              style: GoogleFonts.athiti(
                                fontSize: 13,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    item['rating']?.toString() ?? '0.0',
                                    style: GoogleFonts.athiti(
                                      fontSize: 13,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 14,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
