import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/TownController.dart';
import 'package:mobitrack_dv_flutter/controller/address_controller.dart';
import 'package:mobitrack_dv_flutter/controller/alloutletcontroller.dart';
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/controller/bank_controller.dart';
import 'package:mobitrack_dv_flutter/controller/categories_controller.dart';
import 'package:mobitrack_dv_flutter/controller/channelController.dart';
import 'package:mobitrack_dv_flutter/controller/collections_controller.dart';
import 'package:mobitrack_dv_flutter/controller/distributor_controller.dart';
import 'package:mobitrack_dv_flutter/controller/location_controller.dart';
import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
import 'package:mobitrack_dv_flutter/controller/preference_controller.dart';
import 'package:mobitrack_dv_flutter/controller/productbrand_controller.dart';
import 'package:mobitrack_dv_flutter/controller/products_controller.dart';
import 'package:mobitrack_dv_flutter/controller/sales_report_controller.dart';

import 'controller/routes_controller.dart';

class ControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<PreferenceController>(PreferenceController(), permanent: true);
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<LocationController>(LocationController());
    Get.lazyPut<AllOutletController>(() => AllOutletController());
    Get.lazyPut<TownController>(() => TownController());
    Get.lazyPut<ChannelController>(() => ChannelController());
    Get.lazyPut<CategoriesController>(() => CategoriesController());
    Get.lazyPut<Routecontroller>(() => Routecontroller());
    // var categorycontroller = Get.lazyPut(()=>CategoriesController());
    // var channelcontroller = Get.lazyPut(()=>ChannelController());
    // var towncontroller = Get.lazyPut(()=>TownController());
   // Get.put<AllOutletController>(AllOutletController(), permanent: true);

    //Get.lazyPut<AddressController>(() => AddressController());
    Get.lazyPut<SalesReportController>(() => SalesReportController());
    Get.lazyPut<ProductsController>(() => ProductsController());
    Get.lazyPut<BankController>(() => BankController());
    Get.lazyPut<DistributorController>(() => DistributorController());
    Get.lazyPut<CollectionController>(() => CollectionController());
    Get.lazyPut<OutletsController>(() => OutletsController());
    Get.lazyPut<TownController>(() => TownController());
    Get.lazyPut<ProductBrandController>(() => ProductBrandController());



  }
}
