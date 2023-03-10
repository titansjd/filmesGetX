import 'package:app_filmes/application/ui/theme_extensions.dart';
import 'package:app_filmes/models/cast_model.dart';
import 'package:flutter/material.dart';

class MovieCast extends StatelessWidget {
  final CastModel? cast;
  const MovieCast({Key? key, required this.cast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              scale: 1.0,
              cast!.image,
              width: 85,
              height: 85,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/no_image.jpg',
                  fit: BoxFit.fill,
                  width: 85,
                  height: 85,
                );
              },
            ),
          ),
          Text(
            cast?.name ?? '',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            cast?.character ?? '',
            style: TextStyle(
              fontSize: 12,
              color: context.themeGrey,
            ),
          ),
        ],
      ),
    );
  }
}
