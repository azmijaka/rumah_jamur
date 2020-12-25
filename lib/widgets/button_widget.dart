part of 'widgets.dart';

class MyButton extends StatelessWidget {
  MyButton(
      {this.text, this.onPress, this.color, this.textColor = Colors.white});

  final Color color;
  final Function onPress;
  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return VxBox(
            child: text.text
                .color(textColor)
                .textStyle(primaryText)
                .xl
                .makeCentered())
        .width(context.screenWidth)
        .p16
        .linearGradient([
          color.withOpacity(.9) ?? Warna.primary,
          color?.withOpacity(.7) ?? Warna.primary.withOpacity(.7),
        ])
        .roundedLg
        .border(width: 1, color: color)
        .make()
        .onTap(onPress ?? () {});
  }
}
