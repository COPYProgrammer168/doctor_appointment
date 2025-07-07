import 'package:doctor_appointment/utils/config.dart' show Config;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../components/appointment_card.dart';
import '../components/doctor_card.dart';
import '../models/auth_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> user = {};
  Map<String, dynamic> doctor = {};
  List<dynamic> favList = [];

  final List<Map<String, dynamic>> medCat = [
    {"icon": FontAwesomeIcons.userDoctor, "category": "General"},
    {"icon": FontAwesomeIcons.heartPulse, "category": "Cardiology"},
    {"icon": FontAwesomeIcons.lungs, "category": "Respirations"},
    {"icon": FontAwesomeIcons.hand, "category": "Dermatology"},
    {"icon": FontAwesomeIcons.personPregnant, "category": "Gynecology"},
    {"icon": FontAwesomeIcons.teeth, "category": "Dental"},
  ];

  @override
  void initState() {
    super.initState();
    final auth = Provider.of<AuthModel>(context, listen: false);
    user = auth.getUser ?? {};
    doctor = auth.getAppointment ?? {};
    favList = auth.getFav ?? [];
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('Hi ${user["name"] ?? "Guest"} 👋',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 20),

            // Category section
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: medCat.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue.shade100,
                          radius: 28,
                          child: Icon(medCat[index]['icon'], color: Colors.blue),
                        ),
                        const SizedBox(height: 8),
                        Text(medCat[index]['category']),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text(
                "Upcoming Appointment",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                  ),
              ),
              Icon(Icons.calendar_today, color: Colors.blue[400], size: 20),
              ],
            ),
            const SizedBox(height: 12),
            doctor.isNotEmpty
              ? AppointmentCard(
                doctor: doctor,
                color: Colors.blue.shade400,
                )
              : Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                  Icon(Icons.info_outline, color: Colors.blue[300]),
                  const SizedBox(width: 10),
                  const Text(
                    "No upcoming appointments.",
                    style: TextStyle(color: Colors.black54),
                  ),
                  ],
                ),
                ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text(
                "Favorite Doctors",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.pink[700],
                  ),
              ),
              Icon(FontAwesomeIcons.heart, color: Colors.pink[300], size: 20),
              ],
            ),
            const SizedBox(height: 12),
            favList.isNotEmpty
              ? Column(
                children: favList
                  .map(
                    (doc) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: DoctorCard(
                      doctor: doc,
                      isFav: true,
                    ),
                    ),
                  )
                  .toList(),
                )
              : Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                  Icon(Icons.info_outline, color: Colors.pink[200]),
                  const SizedBox(width: 10),
                  const Text(
                    "No favorites added.",
                    style: TextStyle(color: Colors.black54),
                  ),
                  ],
                ),
                ),
          ],
        ),
      ),
    );
  }
}
