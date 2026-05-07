import 'package:flutter/widgets.dart';

class HomeBrand {
  const HomeBrand({
    required this.name,
    required this.logoUrl,
    required this.logoSize,
    this.isNetworkLogo = false,
  });

  HomeBrand.network({
    required this.name,
    required this.logoUrl,
    required this.logoSize,
  }) : isNetworkLogo = true;

  final String name;
  final String logoUrl;
  final Size logoSize;
  final bool isNetworkLogo;
}

class HomeVehicle {
  const HomeVehicle({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.brandLogoUrl,
    required this.brandLogoSize,
  });

  final String name;
  final String price;
  final String imageUrl;
  final String brandLogoUrl;
  final Size brandLogoSize;
}

class HomeData {
  const HomeData();

  static const popularBrands = [
    HomeBrand(
      name: 'Nissan',
      logoUrl: HomeAssets.nissanLogo,
      logoSize: Size(32, 27),
    ),
    HomeBrand(
      name: 'Ford',
      logoUrl: HomeAssets.fordLogo,
      logoSize: Size(40, 16),
    ),
    HomeBrand(
      name: 'Mitsubishi',
      logoUrl: HomeAssets.mitsubishiLogo,
      logoSize: Size(28, 24),
    ),
    HomeBrand(
      name: 'Nissan',
      logoUrl: HomeAssets.nissanLogo,
      logoSize: Size(32, 27),
    ),
    HomeBrand(
      name: 'Ford',
      logoUrl: HomeAssets.fordLogo,
      logoSize: Size(40, 16),
    ),
    HomeBrand(
      name: 'Mitsubishi',
      logoUrl: HomeAssets.mitsubishiLogo,
      logoSize: Size(28, 24),
    ),
  ];

  static const featuredVehicles = [
    HomeVehicle(
      name: 'Altima',
      price: r'$16,800',
      imageUrl: HomeAssets.altima,
      brandLogoUrl: HomeAssets.nissanLogoWhite,
      brandLogoSize: Size(24, 20),
    ),
    HomeVehicle(
      name: 'Explorer',
      price: r'$16,800',
      imageUrl: HomeAssets.explorer,
      brandLogoUrl: HomeAssets.fordLogo,
      brandLogoSize: Size(40, 16),
    ),
    HomeVehicle(
      name: 'Triton',
      price: r'$16,800',
      imageUrl: HomeAssets.triton,
      brandLogoUrl: HomeAssets.mitsubishiLogo,
      brandLogoSize: Size(23, 20),
    ),
    HomeVehicle(
      name: 'Outlander',
      price: r'$16,800',
      imageUrl: HomeAssets.outlander,
      brandLogoUrl: HomeAssets.mitsubishiLogo,
      brandLogoSize: Size(23, 20),
    ),
  ];

  static const feedVehicles = [
    HomeVehicle(
      name: 'Altima',
      price: r'$16,800',
      imageUrl: HomeAssets.altima,
      brandLogoUrl: HomeAssets.nissanLogoWhite,
      brandLogoSize: Size(24, 20),
    ),
    HomeVehicle(
      name: 'Explorer',
      price: r'$16,800',
      imageUrl: HomeAssets.explorer,
      brandLogoUrl: HomeAssets.fordLogo,
      brandLogoSize: Size(40, 16),
    ),
    HomeVehicle(
      name: 'Triton',
      price: r'$16,800',
      imageUrl: HomeAssets.triton,
      brandLogoUrl: HomeAssets.mitsubishiLogo,
      brandLogoSize: Size(23, 20),
    ),
    HomeVehicle(
      name: 'Outlander',
      price: r'$16,800',
      imageUrl: HomeAssets.outlander,
      brandLogoUrl: HomeAssets.mitsubishiLogo,
      brandLogoSize: Size(23, 20),
    ),
    HomeVehicle(
      name: 'Corolla',
      price: r'$16,800',
      imageUrl: HomeAssets.corolla,
      brandLogoUrl: HomeAssets.toyotaLogo,
      brandLogoSize: Size(24, 20),
    ),
    HomeVehicle(
      name: '520i',
      price: r'$16,800',
      imageUrl: HomeAssets.bmw,
      brandLogoUrl: HomeAssets.bmwLogo,
      brandLogoSize: Size(20, 20),
    ),
    HomeVehicle(
      name: 'E-Class',
      price: r'$16,800',
      imageUrl: HomeAssets.mercedes,
      brandLogoUrl: HomeAssets.mercedesLogo,
      brandLogoSize: Size(20, 20),
    ),
    HomeVehicle(
      name: 'Outlander',
      price: r'$16,800',
      imageUrl: HomeAssets.outlander,
      brandLogoUrl: HomeAssets.mitsubishiLogo,
      brandLogoSize: Size(23, 20),
    ),
  ];
}

class HomeAssets {
  const HomeAssets();

  static const nissanLogo = 'assets/figma/brands/nissan_logo_color.png';
  static const fordLogo = 'assets/figma/brands/ford_logo.png';
  static const mitsubishiLogo = 'assets/figma/brands/mitsubishi_logo.png';
  static const nissanLogoWhite = 'assets/figma/brands/nissan_logo_white.png';
  static const toyotaLogo = 'assets/figma/brands/toyota_logo.png';
  static const bmwLogo = 'assets/figma/brands/bmw_logo.png';
  static const mercedesLogo = 'assets/figma/brands/mercedes_logo.png';

  static const altima = 'assets/figma/home/altima.png';
  static const explorer = 'assets/figma/home/explorer.png';
  static const triton = 'assets/figma/home/triton.png';
  static const outlander = 'assets/figma/home/outlander.png';
  static const corolla = 'assets/figma/home/corolla.png';
  static const bmw = 'assets/figma/home/bmw_520i.png';
  static const mercedes = 'assets/figma/home/mercedes_e_class.png';
}
