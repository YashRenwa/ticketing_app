part of 'ticket_bloc.dart';

sealed class TicketState extends Equatable {
  const TicketState();

  @override
  List<Object> get props => [];
}

final class TicketInitial extends TicketState {}

final class TicketLoaded extends TicketState {
  final List<TicketModel> tickets;

  const TicketLoaded({required this.tickets});

  @override
  List<Object> get props => [tickets];
}

final class AddTicketLoading extends TicketState {}

final class AddTicketSuccess extends TicketState {}

final class AddTicketError extends TicketState {}

final class ViewTicketFileLoading extends TicketState {}

final class ViewTicketFileLoaded extends TicketState {
  final File pdfFile;

  const ViewTicketFileLoaded({required this.pdfFile});
  @override
  List<Object> get props => [pdfFile];
}

final class ViewTicketFileError extends TicketState {}
