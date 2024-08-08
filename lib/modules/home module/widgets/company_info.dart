import 'package:flutter/material.dart';

Widget companyInfoDialog(BuildContext context) {
  return const AlertDialog(
    contentPadding: EdgeInsets.zero,
    // backgroundColor: PrimaryColors().lightGreyColor,
    content: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Company Information',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.business, color: Colors.blue),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Geeksynergy Technologies Pvt Ltd',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.blue),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Sanjayanagar, Bengaluru-56',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.phone, color: Colors.blue),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'XXXXXX09',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.email, color: Colors.blue),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'XXXXXX@gmail.com',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
