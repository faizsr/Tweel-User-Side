import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/core/utils/report_messages.dart';
import 'package:tweel_social_media/presentation/bloc/report/report_bloc.dart';
import 'package:tweel_social_media/presentation/cubit/report_radio/report_radio_cubit.dart';
import 'package:tweel_social_media/presentation/pages/report/widgets/report_submit_btn.dart';
import 'package:tweel_social_media/presentation/pages/report/widgets/report_type_listtile.dart';
import 'package:tweel_social_media/presentation/widgets/custom_appbar_2.dart';
import 'package:tweel_social_media/presentation/widgets/custom_textfield_2.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({
    super.key,
    this.postId = '',
    this.userId = '',
  });

  final String postId;
  final String userId;

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final issueController = TextEditingController();
  final scrollController = ScrollController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportRadioCubit, ReportTypeState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: CustomAppbar2(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              title: 'Report an issue',
              onPressed: () {
                Navigator.pop(context);
                context
                    .read<ReportRadioCubit>()
                    .selectType(ReportTypeState.none);
              },
            ),
          ),
          body: BlocListener<ReportBloc, ReportState>(
            listener: (context, state) {
              if (state is ReportUserSuccessState) {
                Navigator.pop(context);
                customSnackbar(context, 'User has been reported',
                    leading: Ktweel.tick_circle);
              }
              if (state is ReportUserErrorState) {
                customSnackbar(context, 'You have already reported this user',
                    leading: Ktweel.info_circle);
              }
              if (state is ReportPostSuccessState) {
                Navigator.pop(context);
                customSnackbar(context, 'Post has been reported',
                    leading: Ktweel.tick_circle);
              }
              if (state is ReportPostErrorState) {
                customSnackbar(context, 'You have already reported this post',
                    leading: Ktweel.info_circle);
              }
            },
            child: ListView(
              controller: scrollController,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              shrinkWrap: true,
              children: [
                const Text(
                  'What type of issue are you reporting?',
                  style: TextStyle(
                    fontSize: 25,
                    fontVariations: fontWeightW700,
                  ),
                ),
                kHeight(10),
                ReportTypeListTile(
                  reportState: ReportTypeState.hate,
                  title: 'Hate',
                  subTitle: ReportMessage.hate,
                ),
                ReportTypeListTile(
                  reportState: ReportTypeState.abuseHarrasment,
                  title: 'Abuse & Harassment',
                  subTitle: ReportMessage.abuseHarrasment,
                ),
                ReportTypeListTile(
                  reportState: ReportTypeState.childSafety,
                  title: 'Child Safety',
                  subTitle: ReportMessage.childSafety,
                ),
                ReportTypeListTile(
                  reportState: ReportTypeState.privacy,
                  title: 'Privacy',
                  subTitle: ReportMessage.privacy,
                ),
                ReportTypeListTile(
                  reportState: ReportTypeState.spam,
                  title: 'Spam',
                  subTitle: ReportMessage.spam,
                ),
                ReportTypeListTile(
                  reportState: ReportTypeState.disturbingMedia,
                  title: 'Sensitive or disturbing media',
                  subTitle: ReportMessage.disturbingMedia,
                ),
                ReportTypeListTile(
                  reportState: ReportTypeState.violent,
                  title: 'Violent',
                  subTitle: ReportMessage.violent,
                ),
                ReportTypeListTile(
                  reportState: ReportTypeState.other,
                  title: 'Other',
                  scrollController: scrollController,
                ),
                if (state == ReportTypeState.other)
                  Form(
                    key: formkey,
                    child: CustomTextField2(
                      controller: issueController,
                      hintText: 'Please describe your issue.....',
                      maxLines: 5,
                    ),
                  ),
                kHeight(100),
              ],
            ),
          ),
          floatingActionButton: ReportSubmitBtn(
            issueController: issueController,
            formKey: formkey,
            postId: widget.postId,
            userId: widget.userId,
          ),
        );
      },
    );
  }
}
