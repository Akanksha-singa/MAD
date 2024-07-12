import 'package:flutter/material.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/utils/utils.dart';

class CustomPhoneNumber extends StatelessWidget {
  CustomPhoneNumber({Key? key, required this.country, required this.onTap}) : super(key: key);

  final Country country;
  final Function(Country) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => _openCountryPicker(context),
            child: Row(
              children: [
                CountryPickerUtils.getDefaultFlagImage(country),
                Padding(
                  padding: EdgeInsets.only(left: 8, bottom: 2),
                  child: Text(
                    "+${country.phoneCode}",
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
                Icon(Icons.arrow_drop_down, color: Colors.white),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _openCountryPicker(BuildContext context) => showDialog(
    context: context,
    builder: (context) => Theme(
      data: Theme.of(context).copyWith(
        dialogBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      child: CountryPickerDialog(
        titlePadding: EdgeInsets.all(8.0),
        searchCursorColor: Colors.white,
        searchInputDecoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: TextStyle(color: Colors.grey),
        ),
        isSearchable: true,
        title: Text('Select your phone code', style: TextStyle(color: Colors.white)),
        onValuePicked: (Country country) => onTap(country),
        itemBuilder: _buildDialogItem,
      ),
    ),
  );

  Widget _buildDialogItem(Country country) => Row(
    children: <Widget>[
      CountryPickerUtils.getDefaultFlagImage(country),
      SizedBox(width: 8.0),
      Text("+${country.phoneCode}", style: TextStyle(color: Colors.white)),
      SizedBox(width: 8.0),
      Flexible(child: Text(country.name, style: TextStyle(color: Colors.white))),
    ],
  );
}