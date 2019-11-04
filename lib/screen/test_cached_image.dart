import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestCachedImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        color: Colors.red,
        child: Center(
          child: CachedNetworkImage(
            imageUrl:
                'https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg',
          ),
        ),
      );
}
