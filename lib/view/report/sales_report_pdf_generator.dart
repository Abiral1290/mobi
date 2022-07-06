import 'dart:io';

import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/auth_controller.dart';
import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
import 'package:mobitrack_dv_flutter/controller/productbrand_controller.dart';
import 'package:mobitrack_dv_flutter/controller/products_controller.dart';
import 'package:mobitrack_dv_flutter/model/distributor.dart';
import 'package:mobitrack_dv_flutter/model/routes.dart';
import 'package:mobitrack_dv_flutter/model/sales_report.dart';
import 'package:mobitrack_dv_flutter/utils/pdf_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfParagraphApi {
  var outlets = Get.lazyPut(() => OutletsController());
  static Future<File> generate(List<SalesReport> salesList,
      {Routes? distributor}) async {
    final pdf = Document();
    final soldDate = DateTime.parse(salesList.first.soldAt!);
    pdf.addPage(
      MultiPage(
        build: (context) => <Widget>[
          buildHeader(soldDate),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          buildSalesOfficerInfo(),
          distributor != null ? buildDistributorInfo(distributor) : SizedBox(),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          buildContent(salesList),
        ],
        footer: (context) {
          final text = 'Page ${context.pageNumber} of ${context.pagesCount}';

          return Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(top: 1 * PdfPageFormat.cm),
            child: Text(
              text,
              style: TextStyle(color: PdfColors.black),
            ),
          );
        },
      ),
    );
    return PdfApi.saveDocument(
        name:
        'sales_report_${soldDate.year}-${soldDate.month}-${soldDate.day}.pdf',
        pdf: pdf);
  }

  static Widget buildHeader(DateTime date) {
    return Container(
      padding: EdgeInsets.only(bottom: 3 * PdfPageFormat.mm),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 2, color: PdfColors.blue)),
      ),
      child: Row(
        children: [
          PdfLogo(),
          SizedBox(width: 0.5 * PdfPageFormat.cm),
          Text(
            'Sales Report of ${date.year}/${date.month}/${date.day}',
            style: TextStyle(fontSize: 20, color: PdfColors.blue),
          ),
        ],
      ),
    );
  }

  static Widget buildSalesOfficerInfo() => Header(
    child: Text(
      "${Get.find<AuthController>().user.name} (Sales Officer)",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: PdfColors.white,
      ),
    ),
    padding: EdgeInsets.all(4),
    decoration: BoxDecoration(color: PdfColors.red),
  );

  static Widget buildDistributorInfo(Routes distributor) => Header(
    child: Text(
      "${distributor.routename} (Distributor)",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: PdfColors.white,
      ),
    ),
    padding: EdgeInsets.all(4),
    decoration: BoxDecoration(color: PdfColors.red),
  );

  static Widget buildContent(List<SalesReport> salesList) {
    return Table.fromTextArray(
      headers: ['SN.', 'Product', 'Outlet', 'Quantity', 'Discount %',"Remark"],
      data: List<List<dynamic>>.generate(
        salesList.length,
            (index) => <dynamic>[
          index + 1,
             salesList[index].productId == 0 ?
              // newlist
              //       .isEmpty ?
             "-"
                  :
          Get.find<ProductBrandController>()
              .productList
              .where((element) => element.id == salesList[index].productId || salesList[index].productId == 0 )
              .toList()
              .first
              .name,
              // .isNotEmpty
              // ? "Shop": Get.find<ProductBrandController>()
              // .productList
              // .where((element) => element.id == salesList[index].productId)
              // .toList()
              // .first
              // .name,
          Get.find<OutletsController>()
              .outletList!
              .where((element) => element.id == salesList[index].outletId)
              .toList()
              .isNotEmpty
              ? Get.find<OutletsController>()
              .outletList!
              .where((element) => element.id == salesList[index].outletId)
              .toList()
              .first
              .name
              : "N/A",
          salesList[index].quantity,
          salesList[index].discount,
              salesList[index].remarks ==null ? "-" : salesList[index].remarks,
        ],
      ),
      headerStyle: TextStyle(
        color: PdfColors.white,
        fontWeight: FontWeight.bold,
      ),
      headerDecoration: BoxDecoration(
        color: PdfColors.cyan,
      ),
      rowDecoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: PdfColors.cyan,
            width: .5,
          ),
        ),
      ),
      cellAlignment: Alignment.centerRight,
      cellAlignments: {0: Alignment.centerLeft},
    );
  }
}
