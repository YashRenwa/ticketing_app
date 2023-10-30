import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:ticketing_app/constants.dart';
import 'package:ticketing_app/model/ticket_model.dart';
import 'package:ticketing_app/view/view_pdf.dart';

class TicketCard extends StatefulWidget {
  const TicketCard({super.key, required this.ticket});
  final TicketModel ticket;
  @override
  State<TicketCard> createState() => _TicketCardState();
}

class _TicketCardState extends State<TicketCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      margin: EdgeInsets.only(left: 0.05.sw, right: 0.05.sw, top: 0.02.sh),
      padding: EdgeInsets.symmetric(
        horizontal: 0.035.sw,
        vertical: 0.015.sh,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: cardBorderColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(0.03.sw),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_pin,
                    size: 0.04.sw,
                    color: textColor,
                  ),
                  SizedBox(
                    width: 0.01.sw,
                  ),
                  Text(
                    widget.ticket.location,
                    style: GoogleFonts.poppins(
                      fontSize: 0.03.sw,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.date_range_rounded,
                    size: 0.04.sw,
                    color: textColor,
                  ),
                  SizedBox(
                    width: 0.01.sw,
                  ),
                  Text(
                    widget.ticket.date,
                    style: GoogleFonts.poppins(
                      fontSize: 0.03.sw,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 0.015.sh,
          ),
          Text(
            widget.ticket.problemTitle,
            style: GoogleFonts.montserrat(
              fontSize: 0.04.sw,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 0.01.sh,
          ),
          ReadMoreText(
            widget.ticket.problemDescription,
            trimLines: 3,
            colorClickableText: Colors.pink,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Show more',
            trimExpandedText: ' Show less',
            style: GoogleFonts.poppins(
              fontSize: 0.03.sw,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewTicketPDF(
                    pdfUrl: widget.ticket.attachmentUrl,
                  ),
                ),
              );
            },
            child: Container(
              width: 1.sw,
              margin: EdgeInsets.only(
                top: 0.02.sh,
              ),
              padding: EdgeInsets.symmetric(vertical: 0.01.sh),
              decoration: BoxDecoration(
                color: appThemeColor,
                borderRadius: BorderRadius.circular(0.02.sw),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.open_in_new,
                    size: 0.045.sw,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 0.01.sw,
                  ),
                  Text(
                    "View File",
                    style: GoogleFonts.poppins(
                      fontSize: 0.035.sw,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
