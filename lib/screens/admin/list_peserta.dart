part of '../screens.dart';

class ListPeserta extends StatefulWidget {
  @override
  _ListPesertaState createState() => _ListPesertaState();
}

class _ListPesertaState extends State<ListPeserta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.white,
      body: VStack([
        BackButtonWidget(
          iconData: Icons.arrow_back_ios_outlined,
          onPressed: () {
            Get.back();
          },
          title: 'List Peserta',
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: PresensiService.presensiCollection
                .doc(Get.arguments)
                .collection('hadir')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return VxBox(
                          child: VStack([
                    Text(
                      document.data()['nama'],
                      style: boldText.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    4.heightBox,
                    Text(document.data()['nim'],
                        style: primaryText.copyWith(
                            fontSize: 14,
                            color: Warna.darkBrown.withOpacity(.7))),
                    10.heightBox,
                    Text(
                      document.data()['izin'] ? "Izin" : "Hadir",
                      style: primaryText.copyWith(
                          fontSize: 12,
                          color: document.data()['izin']
                              ? Warna.green
                              : Warna.blue),
                    ),
                    Text(
                        DateFormat.yMMMMd().add_jm().format(
                            DateTime.fromMicrosecondsSinceEpoch(
                                document.data()['date'] * 1000)),
                        style: primaryText.copyWith(
                            fontSize: 12,
                            color: Warna.darkBrown.withOpacity(.7))),
                  ]))
                      .roundedSM
                      .color(Warna.lynxWhite)
                      .p16
                      .make()
                      .wFull(context)
                      .pSymmetric(v: 8, h: 16)
                      .onTap(() async {
                    Get.toNamed('/detail', arguments: [
                      document.data()['nama'],
                      document.data()['nim'],
                      document.data()['uid']
                    ]);
                  });
                }).toList(),
              );
            },
          ),
        ),
      ]),
    );
  }
}
