import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:motogo_app/design_system/app_design_system.dart';
import 'package:motogo_app/design_system/app_widgets.dart';
import 'package:motogo_app/features/post_car/widgets/post_car_shared_widgets.dart';

class CarPicturesScreen extends StatefulWidget {
  const CarPicturesScreen({
    super.key,
    required this.onContinueChanged,
    required this.onImagesChanged,
  });

  final ValueChanged<bool> onContinueChanged;
  final ValueChanged<List<XFile>> onImagesChanged;

  @override
  State<CarPicturesScreen> createState() => _CarPicturesScreenState();
}

class _CarPicturesScreenState extends State<CarPicturesScreen> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _images = <XFile>[];

  Future<void> _pickFromGallery() async {
    try {
      final List<XFile> picked = await _picker.pickMultiImage();
      if (!mounted || picked.isEmpty) return;
      setState(() => _images.addAll(picked));
      widget.onImagesChanged(List<XFile>.unmodifiable(_images));
    } on MissingPluginException {
      // Plugin not registered yet (hot reload) or unsupported platform.
      final XFile? single = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      if (!mounted || single == null) return;
      setState(() => _images.add(single));
      widget.onImagesChanged(List<XFile>.unmodifiable(_images));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Could not open gallery. Restart app if you just added plugin.',
            style: AppTextStyles.caption.copyWith(color: Colors.white),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onContinueChanged(_images.isNotEmpty);
    });

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PostCarTitleBlock(
            title: 'Car Pictures',
            description:
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
          ),
          const SizedBox(height: 36),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(AppRadius.card),
              onTap: _pickFromGallery,
              child: AppSurface(
                height: 192,
                width: double.infinity,
                color: context.appSurface,
                borderRadius: AppRadius.card,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: context.appSurfaceRaised,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          LucideIcons.imagePlus,
                          size: 20,
                          color: context.appTextPrimary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Add Your Car Image',
                        style: AppTextStyles.value.copyWith(
                          color: context.appTextPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: 220,
                        child: Text(
                          'Lorem Ipsum is simply dummy text of the printing industry.',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.caption.copyWith(
                            color: context.appTextSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 8,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final XFile? image = index < _images.length
                  ? _images[index]
                  : null;
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(22.557),
                  onTap: _pickFromGallery,
                  child: AppSurface(
                    color: context.appSurface,
                    borderRadius: 22.557,
                    child: Center(
                      child: image == null
                          ? Icon(
                              LucideIcons.imagePlus,
                              size: 22,
                              color: context.appTextPrimary.withValues(
                                alpha: 0.55,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(22.557),
                              child: Image.file(
                                File(image.path),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    LucideIcons.imageOff,
                                    size: 22,
                                    color: context.appTextPrimary.withValues(
                                      alpha: 0.55,
                                    ),
                                  );
                                },
                              ),
                            ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
