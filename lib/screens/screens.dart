import 'dart:typed_data';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:random_string/random_string.dart';
import 'package:rumah_jamur/models/models.dart';
import 'package:rumah_jamur/services/services.dart';
import 'package:rumah_jamur/utils/utils.dart';
import 'package:rumah_jamur/widgets/widgets.dart';
import 'package:somedialog/somedialog.dart';
import 'package:spincircle_bottom_bar/modals.dart';
import 'package:spincircle_bottom_bar/spincircle_bottom_bar.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';
import 'dart:ui' as ui;

part 'firstrun/register_screen.dart';
part 'firstrun/welcome_screen.dart';
part 'firstrun/login_screen.dart';

part 'home/home_screen.dart';
part 'home/profile_screen.dart';
part 'home/code_presensi.dart';
part 'home/dashboard_screen.dart';

part 'berita/detail_berita.dart';
part 'berita/list_berita.dart';

part 'information/success_screen.dart';
part 'information/izin_screen.dart';
part 'information/error_screen.dart';
part 'information/qr_view.dart';

part 'admin/list_presensi.dart';
part 'admin/list_peserta.dart';
part 'admin/detail_peserta.dart';
part 'admin/add_berita.dart';
