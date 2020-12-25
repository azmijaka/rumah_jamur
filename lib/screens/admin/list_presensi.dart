part of '../screens.dart';

class ListPresensi extends StatefulWidget {
  @override
  _ListPresensiState createState() => _ListPresensiState();
}

class _ListPresensiState extends State<ListPresensi> {
  Uint8List bytes = Uint8List(0);

  String uid = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
          backgroundColor: Warna.white,
          body: ZStack([
            VStack([
              BackButtonWidget(
                iconData: Icons.arrow_back_ios_outlined,
                title: 'Jadwal',
                onPressed: () {
                  Get.back();
                },
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: PresensiService.presensiCollection.snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return ErrorScreen();
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Warna.primary),
                      ).centered();
                    }

                    return ListView(
                      scrollDirection: Axis.vertical,
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        return VxBox(
                                child: VStack([
                          Text(
                            document.data()['code'],
                            style: boldText.copyWith(
                              fontSize: 18,
                            ),
                          ),
                          16.heightBox,
                          HStack(
                            [
                              Text(
                                  DateFormat.yMMMd()
                                      .add_jm()
                                      .format(DateTime.parse(document
                                          .data()['start']
                                          .toDate()
                                          .toString()))
                                      .toString(),
                                  style: primaryText.copyWith(
                                      fontSize: 12,
                                      color: Warna.darkBrown.withOpacity(.7))),
                              Icon(
                                Icons.delete_outline_rounded,
                                color: Warna.red,
                              ).objectBottomRight().onTap(() async {
                                Get.dialog(
                                    BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaY: 18, sigmaX: 18),
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(
                                            Warna.primary),
                                      ).centered(),
                                    ),
                                    barrierColor: Warna.white.withOpacity(.2),
                                    barrierDismissible: false,
                                    transitionCurve: Curves.easeOutQuint);
                                if (document.data()['uid'] != uid) {
                                  Get.back();
                                  Get.snackbar('Error',
                                      "Gagal menghapus karena ini dibuat oleh panitia lain");
                                } else {
                                  await PresensiService.deletePresensi(
                                          document.data()['code'])
                                      .then((value) => Get.back());
                                  deleteQR(document.data()['code'], uid);
                                  Get.snackbar(
                                      'Error',
                                      "Berhasil menghapus " +
                                          document.data()['code']);
                                }
                              }),
                            ],
                            alignment: MainAxisAlignment.spaceBetween,
                            axisSize: MainAxisSize.max,
                          )
                        ]))
                            .roundedSM
                            .color(Warna.lynxWhite)
                            .p16
                            .make()
                            .wFull(context)
                            .pSymmetric(v: 8, h: 16)
                            .onTap(() {
                          Get.toNamed('/peserta',
                              arguments: document.data()['code']);
                          // Get.toNamed('/qrview', arguments: [
                          //   Uint8List(0),
                          //   document.data()['code'],
                          //   document.data()['qrUrl']
                          // ]);
                        });
                      }).toList(),
                    );
                  },
                ),
              ),
            ]),
            VxBox(
                    child: 'Tambah Jadwal '
                        .text
                        .textStyle(
                            boldText.copyWith(color: Warna.white, fontSize: 12))
                        .makeCentered())
                .color(Warna.blue)
                .roundedLg
                .withShadow([
                  BoxShadow(
                      color: Warna.blue.withOpacity(.3),
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: Offset(12, 12))
                ])
                .size(context.percentWidth * 46, context.percentHeight * 8)
                .make()
                .onTap(() async {
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
                  String randomCode = randomAlpha(6);
                  Uint8List result = await scanner.generateBarCode(randomCode);
                  String url = await uploadQR(randomCode, uid, result);
                  if (!url.isEmptyOrNull) {
                    await PresensiService.setPresensi(PresensiModel(
                            code: randomCode,
                            start: DateTime.now(),
                            end: DateTime.now().add(Duration(hours: 2)),
                            uid: uid,
                            qrUrl: url))
                        .then((value) {
                      Get.back();
                      Get.toNamed('/qrview',
                          arguments: [result, randomCode, url]);
                    });
                  }
                })
                .objectBottomCenter()
                .marginOnly(bottom: 40)
          ])),
    );
  }
}
