import 'package:flutter/widgets.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 4,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(211, 211, 211, 0.5),
            borderRadius: BorderRadius.circular(16)),
        width: MediaQuery.sizeOf(context).width * 1 / 3,
      ),
    );
  }
}
