import 'dart:convert';

import 'package:flutter/services.dart';

class VehicleCatalogEntry {
  const VehicleCatalogEntry({
    required this.makeEn,
    required this.makeLogo,
    required this.modelEn,
    required this.trim,
    required this.yearMin,
    required this.yearMax,
    required this.yearsSeen,
    required this.listingsCount,
  });

  factory VehicleCatalogEntry.fromJson(Map<String, dynamic> json) {
    return VehicleCatalogEntry(
      makeEn: (json['make_en'] as String?)?.trim() ?? '',
      makeLogo: (json['make_logo'] as String?)?.trim() ?? '',
      modelEn: (json['model_en'] as String?)?.trim() ?? '',
      trim: (json['trim'] as String?)?.trim() ?? '',
      yearMin: _parseInt(json['year_min']),
      yearMax: _parseInt(json['year_max']),
      yearsSeen: _parseYearsSeen(json['years_seen']),
      listingsCount: _parseInt(json['listings_count']),
    );
  }

  final String makeEn;
  final String makeLogo;
  final String modelEn;
  final String trim;
  final int yearMin;
  final int yearMax;
  final List<int> yearsSeen;
  final int listingsCount;

  static List<int> _parseYearsSeen(dynamic raw) {
    if (raw is! String) return const <int>[];
    final List<int> years = raw
        .split(',')
        .map((v) => int.tryParse(v.trim()))
        .whereType<int>()
        .toList();
    years.sort();
    return years;
  }

  static int _parseInt(dynamic raw) {
    if (raw is num) return raw.toInt();
    if (raw is String) return int.tryParse(raw.trim()) ?? 0;
    return 0;
  }
}

class VehicleMakeSummary {
  const VehicleMakeSummary({
    required this.makeEn,
    required this.makeLogo,
    required this.totalListingsCount,
  });

  final String makeEn;
  final String makeLogo;
  final int totalListingsCount;
}

class VehicleCatalogRepository {
  VehicleCatalogRepository._();

  static final VehicleCatalogRepository instance = VehicleCatalogRepository._();

  static const String _assetPath = 'assets/data/make_model_trim.json';

  List<VehicleCatalogEntry>? _cache;

  Future<List<VehicleCatalogEntry>> load() async {
    final cached = _cache;
    if (cached != null) return cached;

    final String raw = await rootBundle.loadString(_assetPath);
    final Object decoded = jsonDecode(raw);
    if (decoded is! List) return const <VehicleCatalogEntry>[];

    final List<VehicleCatalogEntry> entries = decoded
        .whereType<Map<String, dynamic>>()
        .map(VehicleCatalogEntry.fromJson)
        .where((e) => e.makeEn.isNotEmpty && e.modelEn.isNotEmpty)
        .toList(growable: false);

    _cache = entries;
    return entries;
  }

  Future<List<VehicleMakeSummary>> popularMakes({int limit = 12}) async {
    final entries = await load();
    final Map<String, ({String logo, int count})> totals = {};

    for (final e in entries) {
      final key = e.makeEn;
      final prev = totals[key];
      totals[key] = (
        logo: (prev?.logo.isNotEmpty ?? false) ? prev!.logo : e.makeLogo,
        count: (prev?.count ?? 0) + e.listingsCount,
      );
    }

    final List<VehicleMakeSummary> list =
        totals.entries
            .map(
              (kv) => VehicleMakeSummary(
                makeEn: kv.key,
                makeLogo: kv.value.logo,
                totalListingsCount: kv.value.count,
              ),
            )
            .toList()
          ..sort(
            (a, b) => b.totalListingsCount.compareTo(a.totalListingsCount),
          );

    return list.take(limit).toList(growable: false);
  }

  Future<List<String>> makes() async {
    final entries = await load();
    final set = <String>{};
    for (final e in entries) {
      if (e.makeEn.isNotEmpty) set.add(e.makeEn);
    }
    final list = set.toList()..sort();
    return list;
  }

  Future<Map<String, String>> makeLogos() async {
    final entries = await load();
    final Map<String, String> logos = {};
    for (final e in entries) {
      final String make = e.makeEn;
      if (make.isEmpty) continue;
      if (logos.containsKey(make)) continue;
      if (e.makeLogo.isEmpty) continue;
      logos[make] = e.makeLogo;
    }
    return logos;
  }

  Future<String?> makeLogoUrl(String makeEn) async {
    final entries = await load();
    for (final e in entries) {
      if (e.makeEn == makeEn && e.makeLogo.isNotEmpty) return e.makeLogo;
    }
    return null;
  }

  Future<List<String>> modelsForMake(String makeEn) async {
    final entries = await load();
    final set = <String>{};
    for (final e in entries) {
      if (e.makeEn == makeEn && e.modelEn.isNotEmpty) set.add(e.modelEn);
    }
    final list = set.toList()..sort();
    return list;
  }

  Future<List<String>> trimsFor(String makeEn, String modelEn) async {
    final entries = await load();
    final set = <String>{};
    for (final e in entries) {
      if (e.makeEn == makeEn && e.modelEn == modelEn) {
        set.add(e.trim.isEmpty ? 'Base' : e.trim);
      }
    }
    final list = set.toList()..sort();
    return list;
  }

  Future<List<int>> yearsFor(String makeEn, String modelEn) async {
    final entries = await load();
    final set = <int>{};
    for (final e in entries) {
      if (e.makeEn == makeEn && e.modelEn == modelEn) {
        set.addAll(e.yearsSeen);
      }
    }
    final list = set.toList()..sort();
    return list.reversed.toList(growable: false);
  }
}
