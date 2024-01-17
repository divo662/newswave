import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../widgets/custom_textform_field.dart';
import '../../../api/home_api.dart';
import '../../../models/article_model.dart';
import '../../home file/widgets/article_content_page.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchText = '';
  String selectedCategory = 'general';
  List<ArticleModel> searchResults = [];
  bool isLoading = false;
  bool hasError = false;
  late NewsApiProvider newsApiProvider;
  TextEditingController controller = TextEditingController();
  List<String> categories = [
    'general',
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology',
  ];

  @override
  void initState() {
    super.initState();
    newsApiProvider = NewsApiProvider('6505296e275e4624ba3f70c3680add18');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Browse",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 17.sp),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Browse",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                      fontSize: 24.sp),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextFormField(
                  hintText: "Search...",
                  controller: controller,
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                  hintTextFontSize: 16.sp,
                  labelText: "Search",
                  labelColor: Colors.black,
                  labelTextFontSize: 16.sp,
                  inputColor: Colors.black,
                  prefixIcon: const Icon(Icons.search),
                ),
                 SizedBox(height: 16.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: _performSearch,
                  child: const Text('Search'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildSearchResults(),
        ],
      ),
    );
  }


  Widget _buildSearchResults() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (hasError) {
      return Center(
        child: Text(
          'Error: Failed to load search results.',
          style: GoogleFonts.poppins(
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w500),
        ),
      );
    } else if (searchResults.isEmpty) {
      return Center(
        child: Text(
          'Your results will appear here after you search.',
          style: GoogleFonts.poppins(
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w500),
        ),
      );
    } else {
      return _buildSearchResultsGrid();
    }
  }

  Widget _buildSearchResultsGrid() {
    return Expanded(
      child: GridView.builder(
        itemCount: searchResults.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 1.31,
        ),
        itemBuilder: (context, index) {
          return _buildSearchResultItem(searchResults[index]);
        },
      ),
    );
  }

  Widget _buildSearchResultItem(ArticleModel article) {
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
      child: Card(
        elevation: ScreenUtil().setWidth(3.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: ScreenUtil().setHeight(153),
              child: (article.urlToImage != null)
                  ? CachedNetworkImage(
                      filterQuality: FilterQuality.high,
                      imageUrl: article.urlToImage ?? "",
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.image_not_supported,
                        size: 50,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            Text(
              article.title,
              style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  void _performSearch() async {
    setState(() {
      isLoading = true;
      hasError = false;
      searchResults.clear();
    });

    try {
      List<ArticleModel> results = await newsApiProvider.searchNews(searchText);
      setState(() {
        searchResults = results;
      });
    } catch (e) {
      debugPrint('Error searching news: $e');
      setState(() {
        hasError = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
