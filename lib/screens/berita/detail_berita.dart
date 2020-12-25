part of '../screens.dart';

class DetailBerita extends StatefulWidget {
  @override
  _DetailBeritaState createState() => _DetailBeritaState();
}

class _DetailBeritaState extends State<DetailBerita> {
  int date = Get.arguments[1];
  String judul = Get.arguments[2];
  String content = Get.arguments[3];
  String nama = Get.arguments[4];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VStack([
        BackButtonWidget(
          iconData: Icons.arrow_back_ios_outlined,
          title: 'Detail Berita',
          onPressed: () {
            Get.back();
          },
        ),
        VxBox(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: CachedNetworkImage(
                      imageUrl: Get.arguments[0],
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          new CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Warna.primary))
                              .p12(),
                      errorWidget: (context, url, error) => new Icon(
                        Icons.error_outlined,
                        color: Warna.white,
                      ),
                    )))
            .size(context.screenWidth, context.percentWidth * 50)
            .color(Warna.rosyBrown.withOpacity(.5))
            .rounded
            .withShadow([
              BoxShadow(
                  blurRadius: 22,
                  color: Warna.lynxWhite,
                  offset: Offset(10, 10),
                  spreadRadius: 4)
            ])
            .make()
            .p12(),
        Text(
                DateFormat.yMMMMd()
                    .format(DateTime.fromMicrosecondsSinceEpoch(date * 1000)),
                style: primaryText.copyWith(
                    fontSize: 12, color: Warna.darkBrown.withOpacity(.7)))
            .objectCenterRight()
            .px16(),
        Text('Ditulis oleh : ' + nama,
                style: boldText.copyWith(fontSize: 10, color: Warna.blue))
            .objectCenterRight()
            .px16(),
        12.heightBox,
        judul.text
            .textStyle(boldText.copyWith(fontSize: 20, color: Warna.darkBrown))
            .make()
            .px16(),
        12.heightBox,
        content.text.justify
            .textStyle(
                primaryText.copyWith(fontSize: 14, color: Warna.darkBrown))
            .make()
            .px20(),
        12.heightBox
      ]).scrollVertical(),
    );
  }
}
