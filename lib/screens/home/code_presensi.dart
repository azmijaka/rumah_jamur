part of '../screens.dart';

class CodePresensi extends StatefulWidget {
  @override
  _CodePresensiState createState() => _CodePresensiState();
}

class _CodePresensiState extends State<CodePresensi> {
  TextEditingController kodeController = TextEditingController();
  UserModel userModel = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: VxBox(
            child: ZStack([
          Positioned(
            top: -MediaQuery.of(context).size.height * .32,
            right: -MediaQuery.of(context).size.width * .4,
            child: MyContainer(),
          ),
          BackButtonWidget(
            iconData: Icons.arrow_back_ios_outlined,
            onPressed: () {
              Get.back();
            },
            title: 'Back',
          ),
          VStack(
            [
              'Presensi Dengan Kode'.text.xl4.makeCentered(),
              16.heightBox,
              TextFieldKu(
                controller: kodeController,
                inputType: TextInputType.text,
                keterangan: 'Masukkan kode presensi',
              ),
              20.heightBox,
              MyButton(
                text: 'Presensi Sekarang',
                color: Warna.primary,
                onPress: () async {
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
                  String kode = kodeController.text.trim();
                  bool presensi = await PresensiService.checkPresensi(kode);

                  if (!presensi) {
                    Get.back();
                    Get.snackbar(
                        'Gagal Presensi', 'Kode yang anda masukkan salah');
                  } else {
                    await PresensiService.userPresensi(kode, userModel);
                    Get.offAllNamed('/success',
                        arguments: ['', userModel, kode]);
                  }
                },
              )
            ],
            alignment: MainAxisAlignment.center,
          ).objectCenter()
        ])).p16.makeCentered(),
      ),
    );
  }
}
