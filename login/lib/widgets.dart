import 'package:flutter/material.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomPhoneNumber extends StatelessWidget {
  CustomPhoneNumber({
    Key? key,
    required this.country,
    required this.onTap,
    required this.controller,
  }) : super(key: key);

  final Country country;
  final Function(Country) onTap;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => _openCountryPicker(context),
            child: Row(
              children: [
                CountryPickerUtils.getDefaultFlagImage(country),
                SizedBox(width: 8),
                Text(
                  "+${country.phoneCode}",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                SizedBox(width: 4),
                SvgPicture.asset(
                  "assets/images/arrow_down.svg",
                  width: 12,
                  height: 12,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "7X-XXXXXXX",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openCountryPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Theme(
        data: Theme.of(context).copyWith(
          dialogBackgroundColor: Colors.black,
        ),
        child: CountryPickerDialog(
          titlePadding: EdgeInsets.all(8.0),
          searchCursorColor: Colors.white,
          searchInputDecoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          ),
          isSearchable: true,
          title: Text('Select your phone code', style: TextStyle(color: Colors.white)),
          onValuePicked: (Country country) => onTap(country),
          itemBuilder: _buildDialogItem,
        ),
      ),
    );
  }

  Widget _buildDialogItem(Country country) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              country.name,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            width: 60,
            child: Text(
              "+${country.phoneCode}",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}