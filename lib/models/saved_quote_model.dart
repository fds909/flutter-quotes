class SavedQuotesModel {
  final int id;
  final String text;

  const SavedQuotesModel({
    required this.id,
    required this.text,
  });

  factory SavedQuotesModel.fromRecord(Map<String, dynamic> data) {
    final id = data['id'];
    final text = data['text'];

    return SavedQuotesModel(
      id: id,
      text: text,
    );
  }
}
