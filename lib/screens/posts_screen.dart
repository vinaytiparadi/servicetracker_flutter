import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/FormModel.dart';
import '../providers/post_provider.dart';
import '../utils/widgets/glass_card.dart';

class PostListPage extends StatefulWidget {
  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

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
  }

  @override
  Widget build(BuildContext context) {
    final postsProvider = Provider.of<PostListProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextFormField(
              controller: _searchController,
              onChanged: (String query) {
                if (query == '') {
                  postsProvider.posts
                      .sort((a, b) => b.timestamp.compareTo(a.timestamp));
                  _refreshPosts();
                } else {
                  _searchPosts(query);
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ),
                labelText: 'Search using Customer Name',
                hintText: 'Enter Customer Name',
              ),
            ),
          ),
          Expanded(
            child: Consumer<PostListProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading && provider.posts.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                } else if (provider.hasError) {
                  return const Center(child: Text('Error loading posts'));
                } else {
                  final filteredPosts = provider.posts;
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: filteredPosts.length + 1,
                    itemBuilder: (context, index) {
                      if (index < filteredPosts.length) {
                        final post = filteredPosts[index];
                        // Display post data here
                        return GlassCard(data: post,);
                      } else if (provider.isLoading) {
                        return const Center(child: CircularProgressIndicator());
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
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
