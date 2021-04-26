import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:masjid_tv/services/image_service.dart';

class Carousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FutureBuilder(
        future: getImage(),
        builder: (context, snapshot) {
          return snapshot.hasData
            ? CarouselWidget(imageFiles: snapshot.data)
            : Center(child: CircularProgressIndicator());
        }
      )
    );
  }
}

class CarouselWidget extends StatelessWidget {
  final List<FileSystemEntity> imageFiles;
  
  CarouselWidget({
    Key key,
    @required this.imageFiles
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 1,
        autoPlay: true,
      ),
      items: imageFiles.map((imageFile) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Image.file(
                File(imageFile.path)
              )
            );
          },
        );
      }).toList(),
    );
  }
}