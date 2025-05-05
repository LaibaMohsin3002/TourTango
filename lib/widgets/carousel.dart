// widgets/carousel_slider_widget.dart
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/packages.dart';

class CarouselSliderWidget extends StatelessWidget {
  final List<Package> packages;
  final Function(dynamic) onPackageTap;

  const CarouselSliderWidget(
      {super.key, required this.packages, required this.onPackageTap});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: packages.length,
      options: CarouselOptions(
        height: 400,
        enlargeCenterPage: true,
        autoPlay: true,
        viewportFraction: 0.8,
      ),
      itemBuilder: (context, index, realIndex) {
        final package = packages[index];
        return GestureDetector(
          onTap: () => onPackageTap(package),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(package.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: Text(
                  package.packageName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 6.0,
                        color: Colors.black.withOpacity(0.8),
                        offset: const Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
