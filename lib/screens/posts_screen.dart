import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_tracker/utils/widgets/glass_card.dart';

import '../models/FormModel.dart';
import '../providers/post_provider.dart';

class PostListPage extends StatefulWidget {
  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

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
    provider.clearFilters();
    provider.resetPosts();
  }

  void _searchPosts(String query) {
    final provider = Provider.of<PostListProvider>(context, listen: false);
    provider.searchPosts(query);
  }

  void _filterPostsByDate() {
    final provider = Provider.of<PostListProvider>(context, listen: false);
    provider.filterPostsByDate(_startDate!, _endDate!);
  }

  @override
  Widget build(BuildContext context) {
    final postsProvider = Provider.of<PostListProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Data'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _searchController,
                    onChanged: (String query) {
                      if (query == '') {
                        postsProvider.posts.sort(
                                (a, b) => b.timestamp.compareTo(a.timestamp));
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
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    ).then((dateRange) {
                      if (dateRange != null) {
                        setState(() {
                          _startDate = dateRange.start;
                          _endDate = dateRange.end;
                        });
                        _filterPostsByDate();
                      }
                    });
                  },
                  child: Text('Filter By Date'),
                ),
              ],
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
                  final filteredPosts = provider.getFilteredPostsByDate();
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: filteredPosts.length + 1,
                    itemBuilder: (context, index) {
                      if (index < filteredPosts.length) {
                        final post = filteredPosts[index];
                        // Display post data here
                        return GlassCard(data: post);
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
