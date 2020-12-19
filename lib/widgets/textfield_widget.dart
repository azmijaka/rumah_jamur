part of 'widgets.dart';

class TextFieldKu extends StatelessWidget {
  final TextEditingController controller;
  final String keterangan;
  final TextInputType inputType;
  final bool isPassword;
  TextFieldKu(
      {this.controller, this.keterangan, this.inputType, this.isPassword});

  @override
  Widget build(BuildContext context) {
    return VxBox(
            child: TextField(
      controller: controller,
      style: primaryText.copyWith(
        fontSize: 12,
      ),
      keyboardType: inputType ?? TextInputType.text,
      obscureText: isPassword ?? false,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: keterangan ?? "Keterangan",
          hintStyle: primaryText.copyWith(
            fontSize: 12,
            color: Warna.rosyBrown,
          )),
    ))
        .padding(EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 6,
        ))
        .width(context.screenWidth)
        .hexColor('#EFF0F6')
        .rounded
        .make();
  }
}