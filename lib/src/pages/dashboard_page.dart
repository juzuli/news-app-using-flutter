import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:citizens/src/bloc/articles/articles_cubit.dart';
import 'package:citizens/src/bloc/featured/featured_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../bloc/grid/grid_cubit.dart';
import '../custom_ui/carousel_card.dart';
import '../custom_ui/horizontal_list_view_card.dart';
import '../custom_ui/vertical_list_view_card.dart';
import 'search_delegate.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int index = 1;

  final pages = [
    const Center(
      child: Text('Notification'),
    ),
    const HomePage(),
    const Center(
      child: Text('Profile'),
    ),
  ];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (index) => setState(
          () => this.index = index,
        ),
        height: 65,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            selectedIcon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outlined),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  fetchData() {
    BlocProvider.of<ArticlesCubit>(context).fetchArticles();
    BlocProvider.of<FeaturedCubit>(context).fetchFeatured();
    BlocProvider.of<GridCubit>(context).fetchGrid();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activePage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 256,
              actions: [
                IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: MySearchDelegate(),
                    );
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                centerTitle: true,
                title: const Text('News App'),
                background: BlocBuilder<FeaturedCubit, FeaturedState>(
                  builder: (context, state) {
                    if (state is FeaturedLoading) {
                      return Column(
                        children: [
                          CarouselSlider.builder(
                            itemCount: 4,
                            itemBuilder: (context, itemIndex, realIndex) {
                              return Shimmer.fromColors(
                                baseColor: Colors.black12,
                                highlightColor: Colors.white,
                                child: Container(
                                  color: Colors.black,
                                ),
                              );
                            },
                            options: CarouselOptions(
                              viewportFraction: 1,
                              enableInfiniteScroll: true,
                              autoPlay: true,
                              onPageChanged: (page, reason) {
                                setState(() {
                                  activePage = page;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: indicators(4, activePage),
                            ),
                          ),
                        ],
                      );
                    } else if (state is FeaturedError) {
                      return const Center(
                        child: Icon(Icons.close),
                      );
                    } else if (state is FeaturedLoaded) {
                      final data = state.data;

                      return Column(
                        children: [
                          CarouselSlider.builder(
                            itemCount: 4,
                            itemBuilder: (context, itemIndex, realIndex) {
                              return CarouselCard(
                                imageUrl: data[itemIndex].urlToImage ?? '',
                                argument: data[itemIndex],
                              );
                            },
                            options: CarouselOptions(
                              viewportFraction: 1,
                              enableInfiniteScroll: true,
                              autoPlay: true,
                              onPageChanged: (page, reason) {
                                setState(() {
                                  activePage = page;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: indicators(4, activePage),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ];
        },
        body: RefreshIndicator(
          onRefresh: () {
            fetchData();
            return Future.value();
          },
          child: ListView(
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: Text(
                  'Highlights',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              GridWidget(),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: Text(
                  'Featured',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              FeaturedWidget(),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: Text(
                  'Latest News',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              NewsWidget(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(
      imagesLength,
      (index) {
        return Container(
          margin: const EdgeInsets.all(3),
          width: 20,
          height: 2,
          decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.black26,
            shape: BoxShape.rectangle,
          ),
        );
      },
    );
  }

  fetchData() {
    BlocProvider.of<ArticlesCubit>(context).fetchArticles();
    BlocProvider.of<FeaturedCubit>(context).fetchFeatured();
    BlocProvider.of<GridCubit>(context).fetchGrid();
  }

}

class GridWidget extends StatelessWidget {
  const GridWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GridCubit, GridState>(
      builder: (context, state) {
        if (state is GridLoading) {
          return GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(10),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: List.generate(4, (index) {
              return Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Shimmer.fromColors(
                      baseColor: Colors.black12,
                      highlightColor: Colors.white,
                      child: Container(
                        color: Colors.black,
                      ),
                    )),
              );
            }),
          );
          //CircularProgressIndicator();
        } else if (state is GridError) {
          return const Center(
            child: Icon(Icons.close),
          );
        } else if (state is GridLoaded) {
          final data = state.data;

          return GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(10),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: List.generate(4, (index) {
              return Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: data[index].urlToImage??'',
                    )),
              );
            }),
          );
          // return GridView.count(
          //   crossAxisCount: 2,
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   padding: const EdgeInsets.all(10),
          //   crossAxisSpacing: 10,
          //   mainAxisSpacing: 10,
          //   children: List.generate(data.length, (index) {
          //     return GridViewCard(
          //       imageUrl: data[index].urlToImage ?? '',
          //       argument: data[index],
          //     );
          //   }),
          // );
        } else {
          return Container();
        }
      },
    );
  }
}

class FeaturedWidget extends StatelessWidget {
  const FeaturedWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: BlocBuilder<FeaturedCubit, FeaturedState>(
        builder: (context, state) {
          if (state is FeaturedLoading) {
            return SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    height: 200,
                    width: 319,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey, //New
                            blurRadius: 25.0,
                            offset: Offset(0, -10))
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Shimmer.fromColors(
                      baseColor: Colors.black12,
                      highlightColor: Colors.white,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: 100,
                            width: 100,
                            color: Colors.black,
                          )),
                    ),
                  );
                },
              ),
            );
          } else if (state is FeaturedError) {
            return const Center(
              child: Icon(Icons.close),
            );
          } else if (state is FeaturedLoaded) {
            final data = state.data;

            return SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return HorizontalListViewCard(
                    imageUrl: data[index].urlToImage ?? '',
                    argument: data[index],
                    title: data[index].title ?? '',
                  );
                },
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class NewsWidget extends StatelessWidget {
  const NewsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticlesCubit, ArticlesState>(
      builder: (context, state) {
        if (state is ArticlesLoading) {
          return ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Shimmer.fromColors(
                        baseColor: Colors.black12,
                        highlightColor: Colors.white,
                        child: Container(
                          color: Colors.black,
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                    title: Shimmer.fromColors(
                      baseColor: Colors.black12,
                      highlightColor: Colors.white,
                      child: Container(
                        color: Colors.black,
                        width: 500,
                        height: 10,
                      ),
                    ),
                    subtitle: Shimmer.fromColors(
                      baseColor: Colors.black12,
                      highlightColor: Colors.white,
                      child: Container(
                        color: Colors.black,
                        width: 500,
                        height: 8,
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              );
            },
          );
          // const Center(
          // child: CircularProgressIndicator(),
          // );
        } else if (state is ArticlesError) {
          return const Center(
            child: Icon(Icons.close),
          );
        } else if (state is ArticlesLoaded) {
          final data = state.data;

          return ListView.builder(
            itemCount: data.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return VerticalListViewCard(
                imageUrl: data[index].urlToImage ?? '',
                argument: data[index],
                title: data[index].title ?? '',
                subtitle: data[index].description ?? '',
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
