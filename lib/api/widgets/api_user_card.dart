import 'package:flutter/material.dart';
import 'package:fluttercourse/api/models/api_user.dart';
import 'package:fluttercourse/api/widgets/section_tile.dart';

class ApiUserCard extends StatelessWidget {
  final ApiUser user;

  const ApiUserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,

      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),

        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.blue.shade100,
          child: Text(
            user.id.toString(),
            style: TextStyle(
              color: Colors.blue.shade800,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),

        title: Text(
          user.name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        subtitle: Text(
          "@${user.username}",
          style: const TextStyle(fontSize: 16),
        ),

        children: [
          const Divider(height: 1),

          // USER INFORMATION
          SectionTile(icon: Icons.person, title: "User Info"),

          InfoTile(icon: Icons.numbers, label: "ID", value: user.id.toString()),

          InfoTile(icon: Icons.person_outline, label: "Name", value: user.name),

          InfoTile(
            icon: Icons.alternate_email,
            label: "Username",
            value: user.username,
          ),

          InfoTile(
            icon: Icons.email_outlined,
            label: "Email",
            value: user.email,
          ),

          InfoTile(
            icon: Icons.phone_outlined,
            label: "Phone",
            value: user.phone,
          ),

          InfoTile(icon: Icons.language, label: "Website", value: user.website),

          // ADDRESS
          SectionTile(icon: Icons.location_on_outlined, title: "Address"),

          InfoTile(
            icon: Icons.home_outlined,
            label: "Street",
            value: user.address.street,
          ),

          InfoTile(
            icon: Icons.home_work_outlined,
            label: "Suite",
            value: user.address.suite,
          ),

          InfoTile(
            icon: Icons.location_city,
            label: "City",
            value: user.address.city,
          ),

          InfoTile(
            icon: Icons.location_on,
            label: "Zipcode",
            value: user.address.zipcode,
          ),

          // COMPANY
          SectionTile(icon: Icons.business_outlined, title: "Company"),

          InfoTile(
            icon: Icons.business,
            label: "Company Name",
            value: user.company.name,
          ),

          InfoTile(
            icon: Icons.lightbulb_outline,
            label: "Catch Phrase",
            value: user.company.catchPhrase,
          ),

          InfoTile(
            icon: Icons.work_outline,
            label: "Business",
            value: user.company.bs,
          ),
        ],
      ),
    );
  }
}
