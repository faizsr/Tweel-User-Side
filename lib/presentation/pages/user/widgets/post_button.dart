import 'package:flutter/material.dart';

class PostButton extends StatelessWidget {
  const PostButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 100,
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            color: Theme.of(context).colorScheme.primary,
            onPressed: () {},
            child: const Text('POSTS'),
          ),
        ),
      ],
    );
  }
}
