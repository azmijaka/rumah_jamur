part of '../screens.dart';

class ErrorScreen extends StatefulWidget {
  @override
  _ErrorScreenState createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed('/home');
        return false;
      },
      child: Scaffold(
        backgroundColor: Warna.red.withOpacity(.8),
        body: VStack([
          Lottie.asset('assets/animations/oops.json').wh48(context).centered(),
          10.heightBox,
          'Something went wrong'
              .text
              .textStyle(boldText.copyWith(
                fontSize: 20,
              ))
              .makeCentered(),
          6.heightBox,
          'Periksa kembali koneksi anda'
              .text
              .textStyle(primaryText.copyWith(
                fontSize: 16,
              ))
              .makeCentered(),
          40.heightBox,
          IconButton(
            color: Warna.darkBrown,
            iconSize: 42,
            icon: Icon(Icons.refresh_outlined),
            onPressed: () {
              Get.offAllNamed('welcome');
            },
          ).objectCenter()
        ], alignment: MainAxisAlignment.center)
            .hFull(context),
      ),
    );
  }
}
