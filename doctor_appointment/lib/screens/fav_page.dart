import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../components/doctor_card.dart";
import "../models/auth_model.dart";

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
          Icon(Icons.favorite, color: Colors.redAccent, size: 28),
          SizedBox(width: 10),
          Text(
            'My Favorite Doctors',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: Colors.black87,
            ),
          ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Consumer<AuthModel>(
          builder: (context, auth, child) {
            final favList = auth.getFav ?? [];
            if (favList.isEmpty) {
              return Center(
                child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.sentiment_dissatisfied,
                  color: Colors.grey, size: 60),
              SizedBox(height: 12),
              Text(
                "No favorite doctors yet.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
                ),
              );
            }
            return ListView.separated(
              itemCount: favList.length,
              separatorBuilder: (context, index) =>
            const SizedBox(height: 16),
              itemBuilder: (context, index) => DoctorCard(
                doctor: favList[index],
                isFav: true,
              ),
            );
          },
              ),
            ),
          ],
        ),
        ),
    );
  }
}
