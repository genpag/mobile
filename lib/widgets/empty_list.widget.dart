import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  final String title;
  final String subTitle;
  final String imagePath;
  final bool canCreate;
  final String addButtonTitle;
  final void Function() onTap;

  EmptyList({
    @required this.title,
    @required this.subTitle,
    @required this.imagePath,
    this.canCreate = false,
    this.addButtonTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imagePath,
              height: 90,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              subTitle,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            if (canCreate)
              RaisedButton(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                color: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    addButtonTitle,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: onTap,
              ),
          ],
        ),
      ),
    );
  }
}
