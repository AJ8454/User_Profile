import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_profile/providers/theme_provider.dart';
import 'package:user_profile/providers/user_provider.dart';
import 'package:user_profile/screens/story_screen.dart';
import 'package:user_profile/widgets/user_profile_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool? showSearch = false;
  bool? isDark = false;
  List _allResult = [];
  List _searchResultList = [];
  List? data;
  Future? resultLoaded;
  var _isLoading = true;

  _refreshProducts() async {
    try {
      await Provider.of<UserProvider>(context, listen: false)
          .fetchAndSetUser()
          .then((_) {
        data = Provider.of<UserProvider>(context, listen: false).items;
        setState(() {
          _allResult = data!;
          _isLoading = false;
        });
      });
      searchResulList();
      return 'complete';
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    searchResulList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultLoaded = _refreshProducts();
  }

  searchResulList() {
    var showResult = [];
    if (_searchController.text != '') {
      showResult = _allResult.where((usr) {
        var usrFname = usr.fname!.toLowerCase();
        var usrLname = usr.lname!.toLowerCase();
        return usrFname.contains(_searchController.text.toLowerCase()) ||
            usrLname.contains(_searchController.text.toLowerCase());
      }).toList();
    } else {
      showResult = List.from(_allResult);
    }
    setState(() {
      _searchResultList = showResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              floating: true,
              title: Text(
                'User Profiles',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      showSearch = !showSearch!;
                    });
                  },
                  icon: Icon(
                    showSearch! ? Icons.cancel : Icons.search,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isDark = !isDark!;
                      themeProvider.toogleTheme(isDark!);
                    });
                  },
                  icon: Icon(
                    themeProvider.isDarkMode
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
              bottom: showSearch!
                  ? PreferredSize(
                      preferredSize: const Size.fromHeight(40),
                      child: Container(
                        height: 40,
                        margin: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: const [BoxShadow(color: Colors.black38)],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextField(
                          controller: _searchController,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.search,
                              color: Theme.of(context).primaryColor,
                            ),
                            hintText: 'search...',
                            hintStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    )
                  : PreferredSize(
                      preferredSize: const Size.fromHeight(40),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: _storyTile(),
                        ),
                      ),
                    ),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
          ],
          body: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2 / 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          itemCount: _searchResultList.length,
                          itemBuilder: (context, i) => UserProfile(
                            fname: _searchResultList[i].fname,
                            lname: _searchResultList[i].lname,
                            email: _searchResultList[i].email,
                            imageUrl: _searchResultList[i].imageUrl,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  List<Widget> _storyTile() {
    return List<Widget>.generate(
      _searchResultList.length,
      (i) => GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => StoryScreen(
                name: _searchResultList[i].fname,
                imageUrl: _searchResultList[i].imageUrl,
              ),
            ),
          );
        },
        child: CircleAvatar(
          backgroundImage: NetworkImage(_searchResultList[i].imageUrl),
        ),
      ),
    );
  }
}
