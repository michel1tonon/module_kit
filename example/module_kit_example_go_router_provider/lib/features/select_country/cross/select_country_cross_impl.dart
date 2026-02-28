import 'package:flutter/material.dart';

import '../../../shared/cross/select_country_cross.dart';

class SelectCountryCrossImpl implements SelectCountryCross {
  static const _countries = <(String code, String name)>[
    ('BR', 'Brazil'),
    ('US', 'United States'),
    ('PT', 'Portugal'),
    ('ES', 'Spain'),
  ];

  @override
  Future<String?> call(SelectCountryInput param) {
    return showModalBottomSheet<String>(
      context: param.context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: ListView(
            children: [
              const ListTile(
                title: Text('Select country'),
              ),
              for (final country in _countries)
                ListTile(
                  title: Text('${country.$1} (${country.$2})'),
                  trailing: param.initialCountryCode == country.$1
                      ? const Icon(Icons.check)
                      : null,
                  onTap: () => Navigator.of(context).pop(country.$1),
                ),
            ],
          ),
        );
      },
    );
  }
}
