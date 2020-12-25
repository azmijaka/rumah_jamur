part of '../screens.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController nimController = TextEditingController();
  TextEditingController passController = TextEditingController();

  Widget _submitButton() {
    return MyButton(
        text: 'Daftar',
        color: Warna.primary,
        onPress: () async {
          String email = emailController.text;
          String password = passController.text;
          String nim = nimController.text;
          String nama = nameController.text;
          if (email.isEmpty ||
              password.isEmpty ||
              nama.isEmpty ||
              nim.isEmpty) {
            Get.snackbar('Error', "Silahkan isi data kamu",
                backgroundColor: Warna.red, colorText: Warna.white);
          } else {
            Get.dialog(
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 18, sigmaX: 18),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Warna.primary),
                  ).centered(),
                ),
                barrierColor: Warna.white.withOpacity(.2),
                barrierDismissible: false,
                transitionCurve: Curves.easeOutQuint);
            Result result = await AuthServices.createUserWithEmailAndPassword(
                email,
                password,
                UserModel(
                    nama: nama,
                    nim: nim.toUpperCase(),
                    role: '',
                    email: '',
                    noTelephone: '',
                    uid: '',
                    photoUrl:
                        "https://sia.unram.ac.id/index.php/foto/mahasiswa/" +
                            nim.toUpperCase() +
                            "/300/300"));
            if (result.userModel != null) {
              Get.offAllNamed('/home');
            } else {
              Get.back();
              Get.snackbar('Error', result.message,
                  backgroundColor: Warna.red, colorText: Warna.white);
            }
          }
        });
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Get.offAndToNamed('/login');
      },
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          padding: EdgeInsets.all(15),
          alignment: Alignment.bottomCenter,
          child: HStack(
            [
              'Sudah punya akun?'
                  .text
                  .textStyle(primaryText.copyWith(fontSize: 14))
                  .make(),
              6.widthBox,
              'Masuk disini'
                  .text
                  .textStyle(
                      boldText.copyWith(fontSize: 14, color: Warna.accent))
                  .make()
            ],
            alignment: MainAxisAlignment.center,
          )),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Rumah',
          style: boldText.copyWith(fontSize: 28, color: Warna.darkBrown),
          children: [
            TextSpan(
                text: 'Jamur',
                style:
                    lightText.copyWith(fontSize: 28, color: Warna.darkBrown)),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return VStack([
      TextFieldKu(
        controller: nameController,
        keterangan: 'masukkan nama kamu',
        inputType: TextInputType.name,
      ),
      10.heightBox,
      TextFieldKu(
        controller: nimController,
        keterangan: 'masukkan nim kamu',
        inputType: TextInputType.text,
      ),
      10.heightBox,
      TextFieldKu(
        controller: emailController,
        keterangan: 'masukkan email kamu',
        inputType: TextInputType.emailAddress,
      ),
      10.heightBox,
      TextFieldKu(
        controller: passController,
        keterangan: 'masukkan password kamu',
        inputType: TextInputType.visiblePassword,
        isPassword: true,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VxBox(
        child: ZStack(
          [
            Positioned(
                top: -context.screenHeight * .24,
                right: -context.screenWidth * .4,
                child: MyContainer()),
            VxBox(
              child: VStack(
                [
                  (context.screenHeight * .16).heightBox,
                  _title(),
                  46.heightBox,
                  _emailPasswordWidget(),
                  24.heightBox,
                  _submitButton(),
                  _loginAccountLabel().objectBottomCenter(),
                ],
                alignment: MainAxisAlignment.center,
                crossAlignment: CrossAxisAlignment.center,
                axisSize: MainAxisSize.max,
              ).scrollVertical(),
            ).make().p12(),
            BackButtonWidget(
              title: 'Back',
              iconData: Icons.arrow_back_ios_outlined,
              onPressed: () => Get.back(),
            ),
          ],
        ),
      ).make(),
    );
  }
}
