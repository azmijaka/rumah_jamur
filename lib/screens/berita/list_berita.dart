part of '../screens.dart';

class ListBerita extends StatefulWidget {
  @override
  _ListBeritaState createState() => _ListBeritaState();
}

class _ListBeritaState extends State<ListBerita> {
  UserModel user = Get.arguments;

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
                title: 'Berita',
                onPressed: () {
                  Get.back();
                },
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: BeritaService.beritaCollection
                      .where('uid', isEqualTo: user.uid)
                      .snapshots(),
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
                        return Dismissible(
                          onDismissed: (direction) {
                            setState(() {
                              SomeDialog(
                                  appName: "RumahJamur",
                                  context: context,
                                  path: 'assets/animations/sad.json',
                                  title: 'Hapus Berita',
                                  content:
                                      "Hapus berita ${document.data()['judul']}?",
                                  submit: () async {
                                    await BeritaService.deleteBerita(
                                        document.data()['code']);
                                    Get.back();
                                  },
                                  mode: SomeMode.Lottie);
                            });
                          },
                          key: GlobalKey(),
                          child: VxBox(
                                  child: HStack([
                            VxBox(
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(14),
                                        child: CachedNetworkImage(
                                          imageUrl: document.data()['imageUrl'],
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              new CircularProgressIndicator(
                                                      valueColor:
                                                          AlwaysStoppedAnimation(
                                                              Warna.primary))
                                                  .p12(),
                                          errorWidget: (context, url, error) =>
                                              new Icon(
                                            Icons.error_outlined,
                                            color: Warna.white,
                                          ),
                                        )))
                                .rounded
                                .size(context.percentWidth * 22,
                                    context.percentWidth * 22)
                                .color(Warna.white)
                                .make()
                                .onTap(() async {}),
                            16.widthBox,
                            VStack([
                              Text(
                                      DateFormat.yMMMMd().format(
                                          DateTime.fromMicrosecondsSinceEpoch(
                                              document.data()['date'] * 1000)),
                                      style: primaryText.copyWith(
                                          fontSize: 10,
                                          color:
                                              Warna.darkBrown.withOpacity(.7)))
                                  .objectCenterRight(),
                              10.heightBox,
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: VStack([
                                    Text(
                                      document.data()['judul'],
                                      maxLines: 3,
                                      overflow: TextOverflow.clip,
                                      style: boldText.copyWith(
                                        fontSize: 14,
                                      ),
                                    ),
                                    12.heightBox,
                                    Text(document.data()['content'],
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: primaryText.copyWith(
                                            fontSize: 10,
                                            color: Warna.darkBrown
                                                .withOpacity(.7))),
                                  ])),
                              4.heightBox,
                            ], axisSize: MainAxisSize.max),
                            10.heightBox,
                          ]))
                              .roundedSM
                              .color(Warna.lynxWhite)
                              .p16
                              .make()
                              .wFull(context)
                              .pSymmetric(v: 8, h: 16)
                              .onTap(() async {
                            Get.toNamed('/detailberita', arguments: [
                              document.data()['imageUrl'],
                              document.data()['date'],
                              document.data()['judul'],
                              document.data()['content'],
                              document.data()['nama'],
                              document.data()['uid'],
                            ]);
                          }),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ]),
            VxBox(
                    child: 'Tambah Berita'
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
                  Get.toNamed('/addberita', arguments: user);
                })
                .objectBottomCenter()
                .marginOnly(bottom: 40)
          ])),
    );
  }
}
