import 'dart:convert';

import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timetable/configuration/configuration.dart';
import 'package:timetable/models/country.dart';
import 'package:timetable/utils/type_defs/json.dart';

class CountryCodeInput extends StatefulWidget {
  const CountryCodeInput({
    Key? key,
    required this.onCountryChanged,
  }) : super(key: key);

  final ValueChanged<Country> onCountryChanged;

  @override
  _CountryCodeInputState createState() => _CountryCodeInputState();
}

class _CountryCodeInputState extends State<CountryCodeInput> {
  Country? _selectedCountry;
  List<Country>? _countries;

  @override
  void initState() {
    super.initState();
    initCountries();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showDialog(
          context: context,
          builder: (context) {
            return _CountriesDialog(
              countries: _countries ?? [],
              onCountrySelected: (country) {
                setState(() => _selectedCountry = country);
                context.router.pop();
              },
            );
          }),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppMargins.smallMargin),
        width: MediaQuery.of(context).size.width / 2,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.8,
              color: AppColors.indigo900,
            ),
          ),
        ),
        child: Text(
          _selectedCountry?.displaName ?? 'Select country',
          style: const TextStyle(fontSize: 18, letterSpacing: 1),
        ),
      ),
    );
  }

  Future<void> initCountries() async {
    final jsonString =
        await rootBundle.loadString('assets/json/country_codes.json');
    final countiesJson = List<Json>.from(json.decode(jsonString));

    final loadedCountries =
        countiesJson.map(Country.fromJson).toList(growable: false);

    setState(() {
      _countries = loadedCountries;
      _selectedCountry = loadedCountries.ukraine;
    });

    WidgetsBinding.instance?.addPostFrameCallback(
      (_) => widget.onCountryChanged(loadedCountries.ukraine),
    );
  }

}

class _CountriesDialog extends StatelessWidget {
  const _CountriesDialog({
    Key? key,
    required this.countries,
    required this.onCountrySelected,
  }) : super(key: key);

  final List<Country> countries;
  final ValueSetter<Country> onCountrySelected;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Выберите страну'),
      children: countries
          .map(
            (country) => _CountryItem(
              name: country.name,
              flag: country.flag,
              code: country.phoneCode,
              onPressed: () => onCountrySelected(country),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _CountryItem extends StatelessWidget {
  const _CountryItem({
    Key? key,
    required this.name,
    required this.flag,
    required this.onPressed,
    required this.code,
  }) : super(key: key);

  final String name;
  final String flag;
  final VoidCallback onPressed;
  final String code;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppMargins.margin,
          vertical: AppMargins.smallMargin,
        ),
        child: Row(
          children: [
            Text(flag),
            const SizedBox(width: AppMargins.margin),
            Expanded(child: Text(name, overflow: TextOverflow.ellipsis)),
            Text(code),
          ],
        ),
      ),
    );
  }
}

extension ListCountriesUkraine on List<Country> {
  Country get ukraine => firstWhere((c) => c.name == 'Ukraine');
}
