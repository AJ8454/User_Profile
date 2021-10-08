import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  final String? fname;
  final String? lname;
  final String? email;
  final String? imageUrl;
  const UserProfile({
    Key? key,
    this.fname,
    this.lname,
    this.email,
    this.imageUrl,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.network(imageUrl!, width: 90),
          ),
          const SizedBox(height: 15),
          Text(
            '$fname $lname',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            email!,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}
