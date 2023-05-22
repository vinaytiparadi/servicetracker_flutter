import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/post_provider.dart';


class PostListPage extends StatefulWidget {
  const PostListPage({Key? key}) : super(key: key);

  @override
  // _PostListPageState createState() => _PostListPageState();
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _refreshPosts() {
    final provider = Provider.of<PostListProvider>(context, listen: false);
    provider.resetPosts();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final provider = Provider.of<PostListProvider>(context, listen: false);
      provider.loadMorePosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshPosts,
        child: Icon(Icons.refresh),
      ),
      body: Consumer<PostListProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading && provider.posts.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.hasError) {
            return Center(child: Text('Error loading posts'));
          } else {
            return ListView.builder(
              controller: _scrollController,
              itemCount: provider.posts.length + 1,
              itemBuilder: (context, index) {
                if (index < provider.posts.length) {
                  final post = provider.posts[index];
                  // Display post data here
                  return ListTile(
                    title: Text(post.customerName),
                    subtitle: Text(post.customerPrimaryContactNumber),
                    // Display other post fields as needed
                  );
                } else if (provider.isLoading) {
                  return const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return Container();
                }
              },
            );
          }
        },
      ),
    );
  }
}
