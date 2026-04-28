import 'package:cached_network_image_ce/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? color;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: imageUrl!,
                width: width ?? double.infinity,
                height: height ?? double.infinity,
                fit: fit,
                color: color ?? const Color(0xFFF3F5F7),
                colorBlendMode: BlendMode.multiply,
                placeholder: (context, url) => Container(
                  width: width ?? double.infinity,
                  height: height ?? double.infinity,
                  color: color ?? const Color(0xFFF3F5F7),
                ),
                errorWidget: (context, url, error) => _buildErrorWidget(),
              )
            : _buildErrorWidget(),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[200],
      child: const Icon(Icons.broken_image_outlined, color: Colors.grey),
    );
  }
}
