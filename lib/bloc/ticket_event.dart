part of 'ticket_bloc.dart';

abstract class TicketEvent extends Equatable {
  const TicketEvent();

  @override
  List<Object> get props => [];
}

class InitTicket extends TicketEvent {
  @override
  List<Object> get props => [];
}

class AddTicket extends TicketEvent {
  final TicketModel ticket;
  final File attachmentPath;

  const AddTicket(this.ticket, this.attachmentPath);

  @override
  List<Object> get props => [ticket, attachmentPath];
}

class ViewTicketPDFEvent extends TicketEvent {
  final String ticketUrl;

  const ViewTicketPDFEvent(this.ticketUrl);

  @override
  List<Object> get props => [ticketUrl];
}
