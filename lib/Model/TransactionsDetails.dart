class TransactionModel {
  final String userName;
  final String type; // e.g. Audio, Video, Exclusive, Message
  final double amount;
  final String date;
  final String category; // e.g. All Calls, Scheduled, History

  TransactionModel({
    required this.userName,
    required this.type,
    required this.amount,
    required this.date,
    required this.category,
  });
}