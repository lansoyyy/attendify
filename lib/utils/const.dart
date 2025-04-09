// import 'package:firebase_auth/firebase_auth.dart';

// String userId = FirebaseAuth.instance.currentUser!.uid;

String logo = 'assets/images/logo.png';
String label = 'assets/images/label.png';
String avatar = 'assets/images/avatar.png';
String icon = 'assets/images/icon.png';

List socials = [
  'assets/images/phone.png',
  'assets/images/apple.png',
  'assets/images/google.png',
  'assets/images/facebook.png'
];

List foodCategories = [
  'assets/images/fastfood.png',
  'assets/images/coffee.png',
  'assets/images/donut.png',
  'assets/images/bbq.png',
  'assets/images/pizza.png'
];
List foodCategoriesName = [
  'Fastfood',
  'Drinks',
  'Donut',
  'BBQ',
  'Pizza',
];

List shopCategories = [
  'Combo',
  'Meals',
  'Snacks',
  'Drinks',
  'Add-ons',
];

String home = 'assets/images/home.png';
String office = 'assets/images/office.png';
String groups = 'assets/images/groups.png';
String gcash = 'assets/images/image 5.png';
String paymaya = 'assets/images/image 6.png';
String bpi = 'assets/images/clarity_bank-solid.png';

List<int> getDaysInMonths(int year) {
  return List.generate(12, (index) {
    int month = index + 1;
    DateTime firstDayThisMonth = DateTime(year, month, 1);
    DateTime firstDayNextMonth =
        (month == 12) ? DateTime(year + 1, 1, 1) : DateTime(year, month + 1, 1);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  });
}

List<int> getWeekdayCountsPerMonth(int year) {
  return List.generate(12, (index) {
    int month = index + 1;
    int daysInMonth = DateTime(year, month + 1, 0).day;
    int weekdayCount = 0;

    for (int day = 1; day <= daysInMonth; day++) {
      DateTime date = DateTime(year, month, day);
      if (date.weekday >= DateTime.monday && date.weekday <= DateTime.friday) {
        weekdayCount++;
      }
    }

    return weekdayCount;
  });
}

List<int> weekdays = getWeekdayCountsPerMonth(DateTime.now().year);
