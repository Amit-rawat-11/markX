import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mark_x/components/circular_elevated_button.dart';
import 'package:mark_x/components/homescreen_Cards.dart';
import 'package:mark_x/components/recent_entry_card.dart';
import 'package:mark_x/constant/colors.dart';
import 'package:mark_x/constant/datetime.dart';
import 'package:mark_x/data/sample_habit.dart';
import 'package:mark_x/data/sample_journal.dart';
import 'package:mark_x/perosnalization_logic/pet_selection.dart';
import 'package:mark_x/screens/account_screen.dart';

// import 'package:mark_x/screens/account_screen.dart';
// import 'package:mark_x/screens/food_logging_screen.dart';
// import 'package:mark_x/screens/goal_screen.dart';
// import 'package:mark_x/screens/journal_screen.dart';
import 'package:mark_x/theme/text_style.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Constants for static data
  final String name = '';
  final String petPath = PetSelection(pet: "Cat").petPath;
  User? user = FirebaseAuth.instance.currentUser;

  // Notification click handler
  _onNotificationClicked(BuildContext context) {
    //  Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => const AccountScreen(),
    //     ),
    //   );
    // Go to Account screen
  }

  // Example of a recent entry model

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Allows content to extend behind the app bar for visual effect
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent, // important to keep the transparency
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Circular button for user profile
            CircularElevatedButton(
              onpressed: _onNotificationClicked(context),
              iconData: LucideIcons.settings,
            ),
            const Text("Mark X"),
            // Circular button for notifications
            CircularElevatedButton(
              onpressed: _onNotificationClicked(context),
              iconData: LucideIcons.bell,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: GRBackground.grbackground, // Custom background for the app
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Greeting Text
                const SizedBox(height: 10),
                Text(
                  "Good Morning ${user?.displayName ?? "User"}",
                  style: MXTextStyles.heading,
                ),

                // Spacer between sections
                const SizedBox(height: 10),

                // Row for Streak and Pet Image
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Homescreen Card for Streak
                    HomescreenCards(
                      height: 110,
                      width: 160,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Streak:"),
                          Text(
                            "🔥3-Days streak!",
                            style: MXTextStyles.bodyBold,
                          ),
                        ],
                      ),
                    ),
                    // Transparent Card for displaying pet image
                    TransparentCard(
                      height: 145,
                      width: 165,
                      child: SvgPicture.asset(
                        "assets/images/svg/$petPath",
                        fit: BoxFit.cover,
                        clipBehavior: Clip.antiAlias,
                      ),
                    ),
                  ],
                ),

                // Spacer between sections
                const SizedBox(height: 20),

                // Recent Entries Section
                Text("Recent Entries", style: MXTextStyles.heading),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 198, 176, 230),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return RecentEntryCard(
                        text: demoJournalEntries[index].title,
                        subtitle: TimeUtils.formattedDate,
                      );
                    },
                  ),
                ),

                // Spacer between sections
                const SizedBox(height: 30),

                // Crushing Your Goals Section
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 198, 176, 230),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Heading for this section
                      Text(
                        "🔥 Crushing Your Goals",
                        style: MXTextStyles.heading,
                      ),

                      const SizedBox(height: 10),

                      // Row containing pet image and list of goals
                      SizedBox(
                        height: 280,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Pet Image
                            SizedBox(
                              width: 150,
                              child: CircularPercentIndicator(
                                radius: 75.0,
                                lineWidth: 27,
                                percent: 0.75,
                                progressColor: MXColors.progressbar,
                                backgroundColor: MXColors.background,
                                animation: true,
                                animationDuration: 3000,
                                circularStrokeCap: CircularStrokeCap.round,
                                center: Text(
                                  "75%",
                                  style: MXTextStyles.bodyBold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            // List of Goals
                            Expanded(
                              child: ListView.builder(
                                itemCount: 3,
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return RecentEntryCard(
                                    text: demohabits[index].title,
                                    subtitle: "${demohabits[index].progress}%",
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                // SvgPicture.asset(
                //   'assets/images/svg/unlcok_pro.svg',
                //   fit: BoxFit.contain,

                //   // width: double.infinity,
                //   // height: double.infinity,
                //   alignment: Alignment.center,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
