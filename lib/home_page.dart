import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'auth_action.dart';
import 'guest_book.dart';
import 'widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Meetup'),
      ),
      body: ListView(
        children: [
          Image.asset('assets/header.png'),
          const IconAndDetail(Icons.calendar_month, '1er Avril'),
          const IconAndDetail(Icons.location_city, 'Annecy'),
          Consumer<ApplicationState>(builder: (context, appState, _) {
            return AuthAction(
              loggedIn: appState.loggedIn,
              signOut: () {
                FirebaseAuth.instance.signOut();
              },
            );
          }),
          const Divider(
            height: 8,
            thickness: 1,
            indent: 4,
            endIndent: 4,
            color: Colors.grey,
          ),
          const Header('Au programme'),
          const Paragraph(
              "Rejoignez-nous pour une journée pleine d'échanges et de pizza !"),
          const Header('Discussion'),
          Consumer<ApplicationState>(builder: (context, appState, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (appState.loggedIn) ...[
                  const Header('Discussion'),
                  GuestBook(
                      addMessage: (message) =>
                          appState.addMessageToGuestBook(message)),
                ],
              ],
            );
          }),
        ],
      ),
    );
  }
}
