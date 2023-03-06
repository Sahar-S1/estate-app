import 'package:estate/components/app_drawer.dart';
import 'package:estate/components/image_carousel.dart';
import 'package:estate/components/property_card.dart';
import 'package:estate/utils/directus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;

    Widget homeTab = Container(
      color: Colors.grey.shade900,
      child: Column(
        children: [
          Container(
            height: size.height * .4,
            child: FutureBuilder(
              future: getSliderImages(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("ERROR - ${snapshot.error}"),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.connectionState == ConnectionState.active) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                assert(snapshot.hasData);
                var sliderImages = snapshot.data!;

                return ImageCarousel(sliderImages);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getButton(
                onPressed: () {},
                icon: Icons.article,
                label: 'Terms & Conditions',
                background: Colors.red.shade700,
              ),
              getButton(
                onPressed: () {
                  context.push('/properties');
                },
                icon: Icons.house,
                label: 'Properties',
                background: Colors.green.shade700,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getButton(
                onPressed: () {},
                icon: Icons.search,
                label: 'Broker',
                background: Colors.blue.shade700,
              ),
              getButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = 3;
                  });
                },
                icon: Icons.person,
                label: 'Profile',
                background: Colors.yellow.shade700,
              ),
            ],
          ),
        ],
      ),
    );

    Widget favoritesTab = FutureBuilder(
      future: getProperties(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("ERROR - ${snapshot.error}"),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.active) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        assert(snapshot.hasData);
        var properties = snapshot.data!;

        return ListView.builder(
          itemCount: properties.length,
          itemBuilder: (ctx, idx) {
            var property = properties[properties.length - 1 - idx];
            return Padding(
              padding: const EdgeInsets.all(0.0),
              child: PropertyCard(
                property: property,
                right: idx % 2 != 0,
              ),
            );
          },
        );
      },
    );

    Widget searchTab = SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration.collapsed(
                      hintText: 'Search',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Icon(Icons.search),
              ],
            ),
          ),
          FutureBuilder(
            future: getProperties(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("ERROR - ${snapshot.error}"),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.connectionState == ConnectionState.active) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              assert(snapshot.hasData);
              var properties = snapshot.data!;

              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: properties.length,
                itemBuilder: (ctx, idx) {
                  var property = properties[properties.length - 1 - idx];
                  return Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: PropertyCard(
                      property: property,
                      right: idx % 2 != 0,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );

    Widget profileTab = Center(
      child: Icon(Icons.person, size: 50),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Estate"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      drawer: AppDrawer(),
      body: {
        0: homeTab,
        1: favoritesTab,
        2: searchTab,
        3: profileTab,
      }[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.favorite,
                  text: 'Favorites',
                ),
                GButton(
                  icon: Icons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Container getButton({
    required void Function()? onPressed,
    required IconData icon,
    required String label,
    Color? background,
    Color? foreground,
    Color? iconColor,
  }) {
    return Container(
      margin: const EdgeInsets.all(15),
      height: 120,
      width: 120,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: foreground,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: iconColor,
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
