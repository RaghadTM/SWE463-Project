# Prayer+

Prayer+ is a simple Flutter application designed to help users access daily prayer times,
view a random Ayah or Hadith, submit personal notes, 
and customize their app experience through settings such as dark mode and font size.

# Features
- Ayah / Hadith of the Day that is fetched automatically from online APIs
- Live Prayer Times based on the user's location
- Submit Notes / Ayah / Hadith and save them in Firestore
- Optional Notifications for prayer alerts and daily hadith reminders
- Customizable Appearance, Dark mode + Adjustable font size

# Project Structure
The app is organized into multiple screens:
- Home Page, displays the daily Ayah/Hadith and saved notes
- Prayer Times Page, shows prayer timings fetched from AlAdhan API
- Submit Page, allows the user to submit content to Firestore
- Settings Page, manages theme, font size, and notification preferences

# The project also includes services for:
- Fetching API content
- Retrieving prayer times
- Managing local notifications
- Handling Firestore submissions

# Requirements
Before running the project, make sure you have:
- Flutter SDK installed
- A configured Firebase project
- Enabled Firestore and added the Firebase configuration files
- Permissions set up for location services and notifications
- clone the GitHun repository to your machine
- open using Android Studio
- run the app

