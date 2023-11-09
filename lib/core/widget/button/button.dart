import 'package:authentication_app/core/data/model/button_status.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class RaisedRectButton extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final String? text;
  final String? svgIcon;
  final Icon? icon;
  final double width;
  final double height;
  final double radius;
  final double textTBPadding;
  final double elevation;
  final VoidCallback? onPressed;
  final double? fontSize;
  BehaviorSubject<ButtonStatus>? buttonStatus;

  RaisedRectButton({
    this.backgroundColor = Colors.black,
    this.textColor = Colors.white,
    this.borderColor = Colors.transparent,
    this.text,
    this.svgIcon,
    this.icon,
    this.width = double.infinity,
    this.height = 48,
    this.radius = 8,
    this.textTBPadding = 8,
    this.elevation = 0,
    this.onPressed,
    this.buttonStatus,
    this.fontSize,
  }) {
    buttonStatus ??
        BehaviorSubject<ButtonStatus>.seeded(ButtonStatus(isEnable: true));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ButtonStatus>(
        stream: buttonStatus?.stream,
        builder: (context, snapshot) {
          String buttonText = text ?? '';
          if ((snapshot.data?.isLoading ?? false) &&
              snapshot.data?.message != null) {
            buttonText = snapshot.data!.message!;
          } else if ((snapshot.data?.isSuccess ?? false) &&
              snapshot.data?.message != null) {
            buttonText = snapshot.data!.message!;
          }
          return SizedBox(
            width: width,
            height: height,
            child: MaterialButton(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: borderColor),
                  borderRadius: BorderRadius.circular(radius),
                ),
                elevation: elevation,
                splashColor: (snapshot.data?.isEnable) == false
                    ? backgroundColor
                    : Colors.grey,
                color: backgroundColor,
                onPressed: onPressed,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: textTBPadding,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildIcon(),
                          buildLoadingWidget(snapshot.data),
                          buildSuccessWidget(snapshot.data),
                          Text(
                            buttonText,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: textColor, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          );
        });
  }

  Widget buildIcon() {
    if (icon != null) {
      return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: icon,
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildLoadingWidget(ButtonStatus? buttonStatus) {
    if (buttonStatus?.isLoading ?? false) {
      return const Padding(
        padding: EdgeInsets.only(right: 16),
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            backgroundColor: Colors.grey,
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildSuccessWidget(ButtonStatus? buttonStatus) {
    if (buttonStatus?.isSuccess ?? false) {
      return const Padding(
        padding: EdgeInsets.only(right: 16),
        child: Icon(Icons.done, color: Colors.white),
      );
    } else {
      return const SizedBox();
    }
  }
}
