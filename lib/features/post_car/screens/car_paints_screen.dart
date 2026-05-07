import 'package:flutter/material.dart';

import 'package:motogo_app/design_system/app_widgets.dart';
import 'package:motogo_app/features/post_car/widgets/post_car_shared_widgets.dart';

class CarPaintsScreen extends StatefulWidget {
  const CarPaintsScreen({super.key, required this.onContinueChanged});

  final ValueChanged<bool> onContinueChanged;

  @override
  State<CarPaintsScreen> createState() => _CarPaintsScreenState();
}

class _CarPaintsScreenState extends State<CarPaintsScreen> {
  static const List<int> _partsCounts = <int>[1, 2, 3, 4, 5, 6, 7, 8];
  static const List<String> _partOptions = <String>[
    'Left Driver Door',
    'Right Driver Door',
    'Right Pass Door',
    'Left Pass Door',
    'Hood',
    'Trunk',
    'Front Bumper',
    'Rear Bumper',
  ];
  static const List<String> _paintOptions = <String>[
    'Full Paint',
    'Sard',
    'Kart',
    '1 Pala',
  ];

  int _targetCount = 4;
  final List<_PaintRow> _rows = <_PaintRow>[];

  @override
  void initState() {
    super.initState();
    _ensureRows();
  }

  void _ensureRows() {
    if (_rows.length > _targetCount) {
      _rows.removeRange(_targetCount, _rows.length);
      return;
    }

    while (_rows.length < _targetCount) {
      _rows.add(const _PaintRow());
    }
  }

  int _visibleRowCount() {
    for (int i = 0; i < _rows.length; i++) {
      if (!_rows[i].isComplete) {
        return i + 1;
      }
    }
    return _rows.length;
  }

  void _setTargetCount(int value) {
    setState(() {
      _targetCount = value;
      _ensureRows();
    });
  }

  void _updateRow(int index, _PaintRow row) {
    setState(() {
      _rows[index] = row;
      _ensureRows();
    });
  }

  @override
  Widget build(BuildContext context) {
    final int visibleCount = _visibleRowCount();
    final bool canContinue = _rows.every((row) => row.isComplete);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onContinueChanged(canContinue);
    });

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PostCarTitleBlock(
            title: 'Car Paints',
            description:
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
          ),
          const SizedBox(height: 36),
          AppSelectField<int>(
            label: 'Number of Paints',
            value: _targetCount,
            options: [
              for (final count in _partsCounts)
                AppSelectOption(value: count, label: '$count Parts'),
            ],
            onChanged: _setTargetCount,
          ),
          const SizedBox(height: 16),
          for (int index = 0; index < visibleCount; index++) ...[
            _PaintRowCard(
              index: index,
              row: _rows[index],
              partOptions: _partOptions,
              paintOptions: _paintOptions,
              onChanged: (value) => _updateRow(index, value),
            ),
            if (index != visibleCount - 1) const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}

class _PaintRowCard extends StatelessWidget {
  const _PaintRowCard({
    required this.index,
    required this.row,
    required this.partOptions,
    required this.paintOptions,
    required this.onChanged,
  });

  final int index;
  final _PaintRow row;
  final List<String> partOptions;
  final List<String> paintOptions;
  final ValueChanged<_PaintRow> onChanged;

  @override
  Widget build(BuildContext context) {
    final String label = 'Paint ${index + 1}';
    final String? part = row.part;
    final String? paint = row.paint;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: AppSelectField<String>(
                label: label,
                value: part ?? partOptions.first,
                options: [
                  for (final option in partOptions)
                    AppSelectOption(value: option, label: option),
                ],
                onChanged: (value) {
                  onChanged(row.copyWith(part: value));
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AppSelectField<String>(
                label: label,
                value: paint ?? paintOptions.first,
                options: [
                  for (final option in paintOptions)
                    AppSelectOption(value: option, label: option),
                ],
                onChanged: (value) {
                  onChanged(row.copyWith(paint: value));
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

@immutable
class _PaintRow {
  const _PaintRow({this.part, this.paint});

  final String? part;
  final String? paint;

  bool get isComplete => part != null && paint != null;

  _PaintRow copyWith({String? part, String? paint}) {
    return _PaintRow(part: part ?? this.part, paint: paint ?? this.paint);
  }
}
