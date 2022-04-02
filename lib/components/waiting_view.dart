import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import 'package:lottie/lottie.dart';
import 'package:my_app/assets.dart';

class WaitingView extends StatelessWidget {
  const WaitingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 20.allP,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Lottie.asset(Assets.lottie.waitingJSON),
            Text(
              "Henüz aktif değil, lütfen beklemede kalın..",
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.black54,
                  ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}