import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/photo_entity.dart';
import '../../../splash/presentation/cubit/network_cubit.dart';
import '../cubit/photo_cubit.dart';
import '../cubit/photo_state.dart';

import '../../../splash/presentation/cubit/theme_cubit.dart';

class PhotoListScreen extends StatefulWidget {
  const PhotoListScreen({super.key});

  @override
  State<PhotoListScreen> createState() => _PhotoListScreenState();
}

class _PhotoListScreenState extends State<PhotoListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<PhotoCubit>().fetchPhotos(loadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Gallery'),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: 80,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.blue, width: 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (context.read<ThemeCubit>().state != AppTheme.light) {
                      context.read<ThemeCubit>().setTheme(AppTheme.light);
                    }
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: isDark
                          ? Border.all(color: Colors.black, width: 2)
                          : Border.all(color: Colors.blue, width: 2),
                      color: !isDark ? Colors.blue : null,
                    ),
                    child: const Icon(Icons.light_mode_outlined, size: 18),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (context.read<ThemeCubit>().state != AppTheme.dark) {
                      context.read<ThemeCubit>().setTheme(AppTheme.dark);
                    }
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: isDark
                          ? Border.all(color: Colors.blue, width: 2)
                          : Border.all(color: Colors.white, width: 2),
                      color: isDark ? Colors.blue : null,
                    ),
                    child: const Icon(Icons.dark_mode, size: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<NetworkCubit, NetworkStatus>(
            builder: (context, status) {
              if (status == NetworkStatus.offline) {
                return Container(
                  color: Colors.red,
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  child: const Text(
                    'You are offline',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          Expanded(
            child: BlocBuilder<PhotoCubit, PhotoState>(
              builder: (context, state) {
                if (state is PhotoLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PhotoLoaded) {
                  return _buildGrid(state.photos);
                } else if (state is PhotoError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(List<PhotoEntity> photos) {
    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        if (index == photos.length) {
          return const Center(child: CircularProgressIndicator());
        }
        final photo = photos[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: photo.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error, size: 50),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
