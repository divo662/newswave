import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newswaves_app/features/home%20file/widgets/article_content_page.dart';
import '../../../router.dart';
import '../../../api/home_api.dart';
import '../../../models/article_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ArticleModel>> newsFuture;
  late List<Future<List<ArticleModel>>> categoryFutures;

  List<String> categories = [
    "Business",
    "Health",
    "Technology",
    "Science",
    "Entertainment"
  ];
  late NewsApiProvider newsApiProvider;

  @override
  void initState() {
    super.initState();
    newsApiProvider = NewsApiProvider('6505296e275e4624ba3f70c3680add18');
    newsFuture = newsApiProvider.getUSATopHeadlinesNews();
    categoryFutures = categories
        .map((category) => newsApiProvider.getCategoryNews(category))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "images/Logo.png",
              height: ScreenUtil().setHeight(140),
              width: ScreenUtil().setWidth(140),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.searchPage);
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.blue,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: ScreenUtil().setWidth(19),
                  child: const Icon(Icons.person),
                ),
              ],
            )
          ],
        ),
      ),
      body: FutureBuilder<List<ArticleModel>>(
        future: newsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                  'Failed to load news. Please check your internet connection.'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                children: [
                  const Text('No news available.'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.firstAuthScreen);
                    },
                    child: const Text("back"),
                  )
                ],
              ),
            );
          } else {
            return DefaultTabController(
              length: categories.length,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: ScreenUtil().setHeight(6),
                      ),
                      Text(
                        "Top Headlines",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenUtil().setSp(21),
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(6),
                      ),
                      CarouselSlider.builder(
                        itemCount: snapshot.data!
                            .where((article) => article.title.isNotEmpty)
                            .length,
                        options: CarouselOptions(
                          height: ScreenUtil().setHeight(365),
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration: const Duration(seconds: 1),
                          viewportFraction: 1,
                        ),
                        itemBuilder: (context, index, realIndex) {
                          final validArticles = snapshot.data!
                              .where((article) => article.title.isNotEmpty)
                              .toList();
                          final article = validArticles[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CustomInAppBrowser(
                                    article: article,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.all(ScreenUtil().setWidth(6)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: ScreenUtil().setHeight(250),
                                    child: (article.urlToImage != null)
                                        ? CachedNetworkImage(
                                            filterQuality: FilterQuality.high,
                                            imageUrl: article.urlToImage ?? "",
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Container(
                                              color: Colors.grey[200],
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(
                                              Icons.image_not_supported,
                                              size: 50,
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                  ),
                                  Text(
                                    article.title,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(15),
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      Text(
                        "Category",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenUtil().setSp(20),
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(6),
                      ),
                      TabBar(
                        labelColor: Colors.blue,
                        unselectedLabelColor: Colors.black,
                        tabs: categories
                            .map((category) => Tab(text: category))
                            .toList(),
                        isScrollable: true,
                        labelStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenUtil().setSp(15),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(6),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: categoryFutures.map(
                            (categoryFuture) {
                              return FutureBuilder<List<ArticleModel>>(
                                future: categoryFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return const Center(
                                      child: Text(
                                        'Failed to load news. Please check your internet connection.',
                                      ),
                                    );
                                  } else if (!snapshot.hasData ||
                                      snapshot.data!.isEmpty) {
                                    return const Center(
                                        child: Text('No news available.'));
                                  } else {
                                    return GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 8.0,
                                        mainAxisSpacing: 8.0,
                                        childAspectRatio: 0.51,
                                      ),
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        final article = snapshot.data![index];
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CustomInAppBrowser(
                                                  article: article,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Card(
                                            elevation:
                                                ScreenUtil().setWidth(3.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: double.infinity,
                                                  height: ScreenUtil()
                                                      .setHeight(153),
                                                  child: (article.urlToImage !=
                                                          null)
                                                      ? CachedNetworkImage(
                                                          filterQuality:
                                                              FilterQuality
                                                                  .high,
                                                          imageUrl: article
                                                                  .urlToImage ??
                                                              "",
                                                          fit: BoxFit.cover,
                                                          placeholder:
                                                              (context, url) =>
                                                                  Container(
                                                            color: Colors
                                                                .grey[200],
                                                            child: const Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            ),
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              const Icon(
                                                            Icons
                                                                .image_not_supported,
                                                            size: 50,
                                                          ),
                                                        )
                                                      : const SizedBox.shrink(),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(
                                                      ScreenUtil()
                                                          .setWidth(8.0)),
                                                  child: Text(
                                                    article.title,
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: ScreenUtil()
                                                          .setSp(14),
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
