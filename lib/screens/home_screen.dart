import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_profile/providers/user_provider.dart';
import 'package:user_profile/widgets/user_profile_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
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
    return Scaffold(
      backgroundColor: const Color(0xFFFCF4F0),
      appBar: AppBar(
        title: Text(
          'User Profiles',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Column(
                children: [
                  Container(
                    height: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Theme.of(context).primaryColor),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.search),
                        hintText: 'search...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
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
    );
  }
}
