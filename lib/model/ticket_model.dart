import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class TicketModel extends Equatable {
  String problemTitle;
  String problemDescription;
  String location;
  String date;
  String attachmentUrl;

  TicketModel({
    required this.problemTitle,
    required this.problemDescription,
    required this.location,
    required this.date,
    required this.attachmentUrl,
  });

  factory TicketModel.fromMap(Map<String, dynamic> map) {
    return TicketModel(
      problemTitle: map['problemTitle'] as String,
      problemDescription: map['problemDescription'] as String,
      location: map['location'] as String,
      date: map['date'] as String,
      attachmentUrl: map['attachmentUrl'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'problemTitle': problemTitle,
      'problemDescription': problemDescription,
      'location': location,
      'date': date,
      'attachmentUrl': attachmentUrl,
    };
  }

  @override
  List<Object?> get props => [
        problemTitle,
        problemDescription,
        location,
        date,
        attachmentUrl,
      ];
}
