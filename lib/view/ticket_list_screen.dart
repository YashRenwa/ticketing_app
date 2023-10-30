import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticketing_app/bloc/ticket_bloc.dart';
import 'package:ticketing_app/constants.dart';
import 'package:ticketing_app/view/new_ticket_form.dart';
import 'package:ticketing_app/view/widgets/ticket_card.dart';

class TicketListScreen extends StatelessWidget {
  TicketListScreen({super.key});

  final TicketBloc bloc = TicketBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc..add(InitTicket()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "TICKET LIST 🎟️",
            style: GoogleFonts.montserrat(
              fontSize: 0.035.sw,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewTicketForm(
                  bloc: bloc,
                ),
              ),
            ).then((value) {
              bloc..add(InitTicket());
            });
          },
          backgroundColor: appThemeColor,
          icon: Icon(
            Icons.add,
            size: 0.05.sw,
          ),
          label: Text(
            "New Ticket",
            style: GoogleFonts.poppins(
              fontSize: 0.03.sw,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: BlocBuilder<TicketBloc, TicketState>(
          builder: (context, state) {
            if (state is TicketInitial) {
              return SizedBox(
                height: 1.sh,
                width: 1.sw,
                child: const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            }
            if (state is TicketLoaded) {
              return SizedBox(
                height: 1.sh,
                width: 1.sw,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.tickets.length,
                        itemBuilder: (context, index) {
                          return TicketCard(
                            ticket: state.tickets[index],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
            return SizedBox(
              height: 1.sh,
              width: 1.sw,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
