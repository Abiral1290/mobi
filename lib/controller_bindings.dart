import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/address_controller.dart';
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/controller/bank_controller.dart';
import 'package:mobitrack_dv_flutter/controller/collections_controller.dart';
import 'package:mobitrack_dv_flutter/controller/distributor_controller.dart';
import 'package:mobitrack_dv_flutter/controller/location_controller.dart';
import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
import 'package:mobitrack_dv_flutter/controller/preference_controller.dart';
import 'package:mobitrack_dv_flutter/controller/products_controller.dart';
import 'package:mobitrack_dv_flutter/controller/sales_report_controller.dart';

class ControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<PreferenceController>(PreferenceController(), permanent: true);
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<LocationController>(LocationController());
    Get.lazyPut<ProductsController>(() => ProductsController());
    Get.lazyPut<AddressController>(() => AddressController());
    Get.lazyPut<SalesReportController>(() => SalesReportController());
    Get.lazyPut<BankController>(() => BankController());
    Get.lazyPut<OutletsController>(() => OutletsController());
    Get.lazyPut<DistributorController>(() => DistributorController());
    Get.lazyPut<CollectionController>(() => CollectionController());
  }
}
