import 'package:estate/components/app_drawer.dart';
import 'package:estate/components/image_carousel.dart';
import 'package:estate/utils/directus.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Estate"),
      ),
      drawer: AppDrawer(),
      body: Container(
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
          ],
        ),
      ),
    );
  }
}
