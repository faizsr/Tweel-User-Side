import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/cubit/report_radio/report_radio_cubit.dart';

class ReportTypeListTile extends StatelessWidget {
  const ReportTypeListTile({
    super.key,
    required this.reportState,
    required this.title,
    this.subTitle,
    this.scrollController,
  });

  final ReportTypeState reportState;
  final String title;
  final String? subTitle;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportRadioCubit, ReportTypeState>(
      builder: (context, state) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            title,
            style: const TextStyle(fontVariations: fontWeightW700),
          ),
          
          subtitle: subTitle != null
              ? Text(
                  subTitle!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 14,
                  ),
                )
              : null,
          trailing: Radio(
            fillColor: MaterialStatePropertyAll(
                Theme.of(context).colorScheme.onSecondary),
            activeColor: Theme.of(context).colorScheme.onPrimary,
            value: reportState,
            groupValue: state,
            onChanged: (value) {
              if (scrollController != null) {
                scrollController!.animateTo(
                  scrollController!.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.bounceIn,
                );
              }
              context.read<ReportRadioCubit>().selectType(value!);
            },
          ),
        );
      },
    );
  }
}
