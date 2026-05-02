import 'package:flutter/widgets.dart';

class HomeBrand {
  const HomeBrand({
    required this.name,
    required this.logoUrl,
    required this.logoSize,
  });

  final String name;
  final String logoUrl;
  final Size logoSize;
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

  static const nissanLogo =
      'https://www.figma.com/api/mcp/asset/1466ce25-0517-489e-a5f6-c7dc2d002b1c';
  static const fordLogo =
      'https://www.figma.com/api/mcp/asset/189a808a-662e-4622-a6ea-8f9aca7771e4';
  static const mitsubishiLogo =
      'https://www.figma.com/api/mcp/asset/06c9f169-bfaa-4c8b-b2ca-5340225d6964';
  static const nissanLogoWhite =
      'https://www.figma.com/api/mcp/asset/20f67b07-5dd8-427d-b08c-b586c7072f59';
  static const toyotaLogo =
      'https://www.figma.com/api/mcp/asset/664890bf-dd7e-470b-9280-497cd0051f36';
  static const bmwLogo =
      'https://www.figma.com/api/mcp/asset/4e655193-018c-4233-8813-af21962a40e9';
  static const mercedesLogo =
      'https://www.figma.com/api/mcp/asset/effeba49-1c51-4df0-a877-76a90684340d';

  static const altima =
      'https://www.figma.com/api/mcp/asset/842a3431-f3c6-474d-90b8-a8ad1bb63f77';
  static const explorer =
      'https://www.figma.com/api/mcp/asset/db3282aa-edaa-4c22-b7ef-4bea47ed2767';
  static const triton =
      'https://www.figma.com/api/mcp/asset/c1214e6d-7225-4fab-af66-9c0f1b45e9e1';
  static const outlander =
      'https://www.figma.com/api/mcp/asset/d2807048-0bf2-44e9-8060-1134c9e745b2';
  static const corolla =
      'https://www.figma.com/api/mcp/asset/5d6f9083-809e-44b3-96c1-6a951616a7f1';
  static const bmw =
      'https://www.figma.com/api/mcp/asset/82885d0d-17a5-4c6c-aaa2-ff2525845acd';
  static const mercedes =
      'https://www.figma.com/api/mcp/asset/0c471a71-3d03-43a9-83c4-f65d8b8adc7e';
}
