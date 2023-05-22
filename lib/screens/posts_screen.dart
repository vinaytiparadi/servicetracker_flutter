import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/FormModel.dart';
import '../providers/post_provider.dart';


class PostListPage extends StatefulWidget {
  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final provider = Provider.of<PostListProvider>(context, listen: false);
      provider.loadMorePosts();
    }
  }

  void _refreshPosts() {
    final provider = Provider.of<PostListProvider>(context, listen: false);
    provider.resetPosts();
  }

  void _searchPosts(String query) {
    final provider = Provider.of<PostListProvider>(context, listen: false);
    provider.searchPosts(query);
    setState(() {
      _searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: EdgeInsets.all(8.0),
          //   child: TextField(
          //     controller: _searchController,
          //     decoration: InputDecoration(
          //       labelText: 'Search by customer name',
          //       suffixIcon: IconButton(
          //         icon: Icon(Icons.search),
          //         onPressed: () {
          //           _searchPosts(_searchController.text.trim());
          //         },
          //       ),
          //     ),
          //   ),
          // ),
          TextFormField(
            controller: _searchController,
            decoration: InputDecoration(),
            onChanged: (String text){
              _searchPosts(_searchController.text.trim());
            },
          ),
          Expanded(
            child: Consumer<PostListProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading && provider.posts.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                } else if (provider.hasError) {
                  return Center(child: Text('Error loading posts'));
                } else {
                  List<FormData> filteredPosts = provider.posts;
                  if (_searchQuery.isNotEmpty) {
                    filteredPosts = provider.filterPosts(_searchQuery);
                  }
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: filteredPosts.length + 1,
                    itemBuilder: (context, index) {
                      if (index < filteredPosts.length) {
                        final post = filteredPosts[index];
                        // Display post data here

                        return ListTile(
                          title: Text(post.customerName),
                          subtitle: Text(post.customerPrimaryContactNumber),
                          // Display other post fields as needed
                        );
                      } else if (provider.isLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return Container();
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshPosts,
        child: Icon(Icons.refresh),
      ),
    );
  }
}

