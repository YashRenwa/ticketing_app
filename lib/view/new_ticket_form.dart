import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticketing_app/bloc/ticket_bloc.dart';
import 'package:ticketing_app/constants.dart';
import 'package:ticketing_app/model/ticket_model.dart';
import 'package:ticketing_app/view/ticket_list_screen.dart';

class NewTicketForm extends StatefulWidget {
  const NewTicketForm({super.key, required this.bloc});
  final TicketBloc bloc;

  @override
  State<NewTicketForm> createState() => _NewTicketFormState();
}

class _NewTicketFormState extends State<NewTicketForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  File? attachmentFile;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => widget.bloc,
      child: BlocConsumer<TicketBloc, TicketState>(
        listener: (context, state) {
          if (state is AddTicketSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => TicketListScreen(),
              ),
              (Route<dynamic> route) => false,
            );
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text(
                  "NEW TICKET",
                  style: GoogleFonts.montserrat(
                    fontSize: 0.035.sw,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: SizedBox(
                height: 1.sh,
                width: 1.sw,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: 0.05.sw, right: 0.05.sw, top: 0.02.sh),
                        padding: EdgeInsets.only(left: 0.03.sw, right: 0.03.sw),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: inputBorderColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(0.02.sw),
                        ),
                        child: TextField(
                          controller: _titleController,
                          cursorColor: Color(0xff313131),
                          style: GoogleFonts.poppins(
                            color: Color(0xff313131),
                            fontSize: 0.035.sw,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Problem Title",
                            hintStyle: GoogleFonts.poppins(
                              color: Color(0xff919191),
                              fontSize: 0.035.sw,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 0.05.sw, right: 0.05.sw, top: 0.02.sh),
                        padding: EdgeInsets.only(left: 0.03.sw, right: 0.03.sw),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: inputBorderColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(0.02.sw),
                        ),
                        child: TextField(
                          controller: _descriptionController,
                          cursorColor: Color(0xff313131),
                          maxLines: 5,
                          style: GoogleFonts.poppins(
                            color: Color(0xff313131),
                            fontSize: 0.035.sw,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Problem Description",
                            hintStyle: GoogleFonts.poppins(
                              color: Color(0xff919191),
                              fontSize: 0.035.sw,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 0.05.sw, right: 0.05.sw, top: 0.02.sh),
                        padding: EdgeInsets.only(left: 0.03.sw, right: 0.03.sw),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: inputBorderColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(0.02.sw),
                        ),
                        child: TextField(
                          controller: _locationController,
                          cursorColor: Color(0xff313131),
                          style: GoogleFonts.poppins(
                            color: Color(0xff313131),
                            fontSize: 0.035.sw,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Location",
                            hintStyle: GoogleFonts.poppins(
                              color: Color(0xff919191),
                              fontSize: 0.035.sw,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 0.05.sw, right: 0.05.sw, top: 0.02.sh),
                        padding: EdgeInsets.only(left: 0.03.sw, right: 0.03.sw),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: inputBorderColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(0.02.sw),
                        ),
                        child: TextField(
                          controller: _dateController,
                          cursorColor: Color(0xff313131),
                          style: GoogleFonts.poppins(
                            color: Color(0xff313131),
                            fontSize: 0.035.sw,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              Icons.date_range_rounded,
                              size: 0.05.sw,
                            ),
                            hintText: "Date",
                            hintStyle: GoogleFonts.poppins(
                              color: Color(0xff919191),
                              fontSize: 0.035.sw,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 0.05.sw, top: 0.02.sh),
                        child: Text(
                          "Attach File",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 0.04.sw,
                            color: textColor,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 0.05.sw, top: 0.01.sh),
                        child: Text(
                          attachmentFile != null
                              ? attachmentFile!.path.split('/')[
                                  attachmentFile!.path.split('/').length - 1]
                              : "",
                          style: GoogleFonts.poppins(
                            color: textColor,
                            fontSize: 0.03.sw,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          FilePickerResult? result = await FilePicker.platform
                              .pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ['pdf']);
                          if (result != null) {
                            File file = File(result.files.single.path!);
                            setState(() {
                              attachmentFile = file;
                            });
                          }
                        },
                        child: Container(
                          width: 1.sw,
                          margin: EdgeInsets.symmetric(
                            horizontal: 0.05.sw,
                            vertical: 0.01.sh,
                          ),
                          padding: EdgeInsets.symmetric(vertical: 0.01.sh),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: inputBorderColor,
                            ),
                            borderRadius: BorderRadius.circular(0.02.sw),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.file_upload_outlined,
                                size: 0.05.sw,
                                color: textColor,
                              ),
                              SizedBox(
                                width: 0.01.sw,
                              ),
                              Text(
                                "Choose File",
                                style: GoogleFonts.poppins(
                                  fontSize: 0.035.sw,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_titleController.text.isNotEmpty ||
                              _descriptionController.text.isNotEmpty ||
                              _locationController.text.isNotEmpty ||
                              _dateController.text.isNotEmpty ||
                              attachmentFile != null) {
                            widget.bloc.add(
                              AddTicket(
                                TicketModel(
                                  problemTitle: _titleController.text,
                                  problemDescription:
                                      _descriptionController.text,
                                  location: _locationController.text,
                                  date: _dateController.text,
                                  attachmentUrl: '',
                                ),
                                attachmentFile!,
                              ),
                            );
                          } else {
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "All Fields are required",
                                ),
                              ),
                            );
                          }
                        },
                        child: Container(
                          width: 1.sw,
                          margin: EdgeInsets.symmetric(
                            horizontal: 0.05.sw,
                            vertical: 0.05.sh,
                          ),
                          padding: EdgeInsets.symmetric(vertical: 0.01.sh),
                          decoration: BoxDecoration(
                            color: appThemeColor,
                            borderRadius: BorderRadius.circular(0.02.sw),
                          ),
                          child: widget.bloc.state is AddTicketLoading
                              ? const Center(
                                  child: CircularProgressIndicator.adaptive(
                                    backgroundColor: Colors.white,
                                  ),
                                )
                              : Text(
                                  "SUBMIT",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 0.035.sw,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        width: 1.sw,
                        child: Text(
                          widget.bloc.state is AddTicketError ? "Error" : "",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 0.035.sw,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
