import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ticketing_app/bloc/ticket_bloc.dart';

class ViewTicketPDF extends StatelessWidget {
  const ViewTicketPDF({super.key, required this.pdfUrl});

  final String pdfUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "VIEW TICKET FILE",
          style: GoogleFonts.montserrat(
            fontSize: 0.035.sw,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocProvider(
          create: (context) => TicketBloc()
            ..add(
              ViewTicketPDFEvent(
                pdfUrl,
              ),
            ),
          child: BlocBuilder<TicketBloc, TicketState>(
            builder: (context, state) {
              if (state is ViewTicketFileLoading) {
                return SizedBox(
                  height: 1.sh,
                  width: 1.sw,
                  child: const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                );
              }
              if (state is ViewTicketFileLoaded) {
                return Center(
                  child: PDFView(
                    filePath: state.pdfFile.path,
                  ),
                );
              }
              if (state is ViewTicketFileError) {
                return SizedBox(
                  height: 1.sh,
                  width: 1.sw,
                  child: const Center(
                    child: Text(
                      "An Error occurred",
                    ),
                  ),
                );
              }
              return SizedBox(
                height: 1.sh,
                width: 1.sw,
                child: const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            },
          )),
    );
  }
}
