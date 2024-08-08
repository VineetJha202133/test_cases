import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_geeksynergy_task/modules/home%20module/controller/home_controller.dart';
import 'package:flutter_geeksynergy_task/modules/home%20module/widgets/company_info.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenController homeController = HomeScreenController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController.fetchMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeScreenController>(
      create: (BuildContext context) => homeController,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Movies'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return companyInfoDialog(context);
                    });
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () => homeController.fetchMovies(),
          child: homeController.movies.isEmpty || homeController.movies == null
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: homeController.movies['result'].length,
                  itemBuilder: (context, index) {
                    var movie = homeController.movies['result'][index];
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              children: <Widget>[
                                Column(
                                  children: [
                                    const Icon(
                                      Icons.arrow_drop_up,
                                      size: 50,
                                    ),
                                    Text(
                                      movie['voting'].toString(),
                                      style: const TextStyle(
                                          fontSize: 24,
                                          // color: Colors.grey,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const Icon(
                                      Icons.arrow_drop_down,
                                      size: 50,
                                    ),
                                    const Text(
                                      'Votes',
                                      style: TextStyle(
                                          fontSize: 14,
                                          // color: Colors.grey,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                movie['poster'].isNotEmpty
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: Image.network(
                                          movie['poster'],
                                          width: 80,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Container(
                                        width: 100,
                                        height: 150,
                                        color: Colors.grey,
                                      ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        movie['title'],
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const Text(
                                            'Genre: ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Container(
                                            constraints: const BoxConstraints(
                                                maxWidth: 110),
                                            child: Text(
                                              movie['genre']
                                                  .split(',') // Split on comma
                                                  .map((genre) => capitalize(genre
                                                      .trim())) // Capitalize each genre
                                                  .join(', '),
                                              maxLines: 1,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                overflow: TextOverflow.ellipsis,
                                                // color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const Text(
                                            'Director: ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Container(
                                            constraints: const BoxConstraints(
                                                maxWidth: 100),
                                            child: Text(
                                              '${movie['director'][0]}',
                                              maxLines: 1,
                                              style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          const Text(
                                            'Stars: ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Container(
                                            constraints: const BoxConstraints(
                                                maxWidth: 120),
                                            child: Text(
                                              '${movie['stars'].join(', ')}',
                                              maxLines: 1,
                                              style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Mins | ${movie['language']} | ${DateFormat('dd MMM').format(DateTime.fromMillisecondsSinceEpoch(movie['voted'][0]['updatedAt'] * 1000))} ',
                                        // 'Votes: ${movie['voting']}',
                                        maxLines: 1,
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '${movie['pageViews']} views | Voted by ${movie['voting']} people',
                                        // 'Votes: ${movie['voting']}',
                                        maxLines: 1,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 16,
                                            color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              // height: 40,
                              width: double.infinity,
                              child: const Center(
                                  child: Text(
                                'Watch Trailer',
                                style: TextStyle(color: Colors.white),
                              )),

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blue,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }

  String capitalize(String str) {
    return str.length > 0 ? str[0].toUpperCase() + str.substring(1) : str;
  }
}
