import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ticketing_app/model/ticket_model.dart';
import 'package:ticketing_app/respositories/ticket_repository.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketBloc() : super(TicketInitial()) {
    TicketRepository ticketRepo = TicketRepository();
    on<InitTicket>((event, emit) async {
      await ticketRepo.setPermissions();
      await ticketRepo.setTokens();
      List<TicketModel> tickets = await ticketRepo.getTickets();
      emit(TicketLoaded(tickets: tickets));
    });

    on<AddTicket>((event, emit) async {
      emit(AddTicketLoading());

      final response =
          await ticketRepo.addTicket(event.ticket, event.attachmentPath);
      if (response == "success") {
        emit(AddTicketSuccess());
      } else {
        emit(AddTicketError());
      }
    });

    on<ViewTicketPDFEvent>((event, emit) async {
      emit(ViewTicketFileLoading());
      File ticketFile = await ticketRepo.getTicketFile(event.ticketUrl);
      emit(ViewTicketFileLoaded(pdfFile: ticketFile));
    });
  }
}
