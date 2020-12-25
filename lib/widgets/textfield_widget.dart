part of 'widgets.dart';

class TextFieldKu extends StatefulWidget {
  TextFieldKu(
      {this.controller,
      this.keterangan = "Keterangan",
      this.inputType,
      this.multiLine = false,
      this.isPassword = false});

  final TextEditingController controller;
  final TextInputType inputType;
  final bool isPassword;
  final String keterangan;
  final bool multiLine;

  @override
  _TextFieldKuState createState() => _TextFieldKuState();
}

class _TextFieldKuState extends State<TextFieldKu> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return VxBox(
            child: TextField(
      controller: widget.controller,
      style: primaryText.copyWith(),
      maxLines: (widget.multiLine) ? null : 1,
      keyboardType: widget.inputType ?? TextInputType.text,
      obscureText: widget.isPassword ? !showPassword : false,
      textInputAction:
          (widget.multiLine) ? TextInputAction.newline : TextInputAction.next,
      decoration: InputDecoration(
          suffixIcon: (widget.isPassword)
              ? IconButton(
                  icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off),
                  iconSize: 16,
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                      print(showPassword);
                    });
                  },
                  color: Warna.darkBrown,
                )
              : null,
          border: InputBorder.none,
          hintText: widget.keterangan,
          hintStyle: primaryText.copyWith(
            color: Warna.rosyBrown,
          )),
    ))
        .padding(EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 4,
        ))
        .width(context.screenWidth)
        .hexColor('#EFF0F6')
        .roundedSM
        .make();
  }
}
