import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/report_messages.dart';
import 'package:tweel_social_media/presentation/bloc/report/report_bloc.dart';
import 'package:tweel_social_media/presentation/cubit/report_radio/report_radio_cubit.dart';
import 'package:tweel_social_media/presentation/widgets/custom_btn.dart';

class ReportSubmitBtn extends StatelessWidget {
  const ReportSubmitBtn({
    super.key,
    required this.issueController,
    required this.formKey,
    required this.postId,
    required this.userId,
  });

  final TextEditingController issueController;
  final GlobalKey<FormState> formKey;
  final String postId;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportRadioCubit, ReportTypeState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: CustomButton(
            buttonText: 'Submit',
            onPressed: state != ReportTypeState.none
                ? () {
                    String description = '';
                    if (state == ReportTypeState.other) {
                      if (formKey.currentState!.validate()) {
                        description = issueController.text;
                      }
                    } else if (state == ReportTypeState.hate) {
                      description = ReportMessage.hate;
                      log(ReportMessage.hate);
                    } else if (state == ReportTypeState.abuseHarrasment) {
                      description = ReportMessage.abuseHarrasment;
                      log(ReportMessage.abuseHarrasment);
                    } else if (state == ReportTypeState.childSafety) {
                      description = ReportMessage.childSafety;
                      log(ReportMessage.childSafety);
                    } else if (state == ReportTypeState.privacy) {
                      description = ReportMessage.privacy;
                      log(ReportMessage.privacy);
                    } else if (state == ReportTypeState.spam) {
                      description = ReportMessage.spam;
                      log(ReportMessage.spam);
                    } else if (state == ReportTypeState.disturbingMedia) {
                      description = ReportMessage.disturbingMedia;
                      log(ReportMessage.disturbingMedia);
                    } else if (state == ReportTypeState.violent) {
                      description = ReportMessage.violent;
                      log(ReportMessage.violent);
                    }
                    if (postId != '') {
                      context.read<ReportBloc>().add(ReportPostEvent(
                            postId: postId,
                            description: description,
                          ));
                    } else if (userId != '') {
                      context.read<ReportBloc>().add(ReportUserEvent(
                            userId: userId,
                            description: description,
                          ));
                    }
                  }
                : null,
          ),
        );
      },
    );
  }
}
