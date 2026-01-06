import 'package:ams_mobile/core/widgets/shimmer_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
// ignore: depend_on_referenced_packages
import 'package:cached_network_image_platform_interface/cached_network_image_platform_interface.dart';
import 'package:flutter/material.dart';

class ImageLoader extends StatelessWidget {
  final String imageUrl;
  final String alt;
  final bool? isProfileImage;
  final BoxFit fit;
  final BorderRadius radius;
  final Widget? loading;
  final Widget? error;
  final double? width;
  final double? height;
  final Color? color;
  final bool needShimmer;
  final String giftURL;

  const ImageLoader({
    super.key,
    required this.imageUrl,
    this.alt = 'AMS',
    this.isProfileImage = false,
    this.fit = BoxFit.cover,
    this.radius = BorderRadius.zero,
    this.loading,
    this.error,
    this.width,
    this.height,
    this.color,
    this.giftURL = '',
    this.needShimmer = true,
  });

  bool _isValidUrl(String url) {
    if (url.isEmpty) return false;
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && uri.hasAuthority;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isValidUrl(imageUrl)) {
      return SizedBox(
        width: width,
        height: height,
        child: ClipRRect(
          borderRadius: radius,
          child: error ?? const Icon(Icons.error),
        ),
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: radius,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: fit,
          color: color,
          colorBlendMode: BlendMode.darken,
          errorWidget: (context, err, obj) {
            if (error != null) return error!;
            return const Icon(Icons.error);
          },
          placeholder: (context, data) {
            if (loading != null) return loading!;
            return needShimmer
                ? ShimmerContainer(
                    width: width ?? 0,
                    height: height ?? 0,
                    radius: 20,
                  )
                : const SizedBox();
          },
          imageRenderMethodForWeb: ImageRenderMethodForWeb.HttpGet,
        ),
      ),
    );
  }
}
