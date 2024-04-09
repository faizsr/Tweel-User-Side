import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/presentation/cubit/drop_down/drop_down_cubit.dart';

class AccountTypeDropDown extends StatelessWidget {
  const AccountTypeDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<DropdownCubit, DropdownState>(
      builder: (context, state) {
        return DropdownButtonFormField2<DropdownState>(
          isExpanded: true,
          decoration: InputDecoration(
            errorMaxLines: 2,
            errorStyle: const TextStyle(),
            prefixIconConstraints:
                const BoxConstraints(minWidth: 0, minHeight: 0),
            prefixIcon: const SizedBox(width: 0),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 16,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(
                color: theme.colorScheme.outline,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 1.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1.0,
              ),
            ),
          ),
          hint: Text(
            'Account Type',
            style: TextStyle(
              fontSize: 14,
              color: theme.colorScheme.secondary,
            ),
          ),
          items: const [
            DropdownMenuItem(
              value: DropdownState.public,
              child: Text(
                'Public',
                style: TextStyle(fontSize: 14),
              ),
            ),
            DropdownMenuItem(
              value: DropdownState.private,
              child: Text(
                'Private',
                style: TextStyle(fontSize: 14),
              ),
            ),
            DropdownMenuItem(
              value: DropdownState.business,
              child: Text(
                'Business',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
          validator: (value) {
            if (value == null) {
              return 'Choose an account type';
            }
            return null;
          },
          onChanged: (value) {
            BlocProvider.of<DropdownCubit>(context).selectOption(value!);
            debugPrint(value.name);
          },
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.only(right: 8),
          ),
          iconStyleData: IconStyleData(
            icon: Icon(
              Ktweel.arrow_bottom_outlined,
              color: theme.colorScheme.secondary,
            ),
            iconSize: 24,
          ),
          dropdownStyleData: DropdownStyleData(
            elevation: 0,
            decoration: BoxDecoration(
              border: Border.all(width: 0.5),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
        );
      },
    );
  }
}
