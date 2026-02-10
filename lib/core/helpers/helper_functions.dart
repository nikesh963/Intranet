import 'package:get/get.dart';

import '../routes/app_pages.dart';
import '../routes/arg_routes.dart';
import '../utils/enum/enums.dart';

void checkRedirection({required String type, required String handle}) {
  if (type == HandleType.Product.value) {
    Get.toNamed(AppRoutes.productDetails, arguments: [
      {ArgRoutes.ARG_PRODUCT_ID: handle}
    ]);
  } else if (type == HandleType.Collection.value) {
    Get.toNamed(AppRoutes.collection, arguments: [
      {ArgRoutes.ARG_COLLECTIONID: handle}
    ]);
  }
}
