import 'dart:io';

import 'package:get/get.dart';
import 'package:mobitrack_dv_flutter/controller/outlets_controller.dart';
import 'package:mobitrack_dv_flutter/controller/products_controller.dart';
import 'package:mobitrack_dv_flutter/model/sales_report.dart';
import 'package:mobitrack_dv_flutter/utils/pdf_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfParagraphApi {
  static Future<File> generate(List<SalesReport> salesList) async {
    final pdf = Document();
    final soldDate = DateTime.parse(salesList.first.soldAt);
    pdf.addPage(
      MultiPage(
        build: (context) => <Widget>[
          buildHeader(soldDate),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          // buildContent(salesList),

          // Table(
          //   border: TableBorder.all(),
          //   children: salesList
          //       .map((e) => TableRow(children: [
          //             Text(
          //               Get.find<ProductsController>()
          //                   .productList
          //                   .where((element) => element.id == e.productId)
          //                   .toList()
          //                   .first
          //                   .name,
          //             ),
          //             Text(Get.find<OutletsController>()
          //                 .outletList
          //                 .where((element) => element.id == e.outletId)
          //                 .toList()
          //                 .first
          //                 .name),
          //             Text(e.quantity.toString()),
          //             Text("${e.discount}%"),
          //           ]))
          //       .toList(),
          // ),

          Table.fromTextArray(
            headers: ['SN.', 'Product', 'Outlet', 'Quantity', 'Discount %'],
            data: List<List<dynamic>>.generate(
              salesList.length,
              (index) => <dynamic>[
                index + 1,
                Get.find<ProductsController>()
                    .productList
                    .where(
                        (element) => element.id == salesList[index].productId)
                    .toList()
                    .first
                    .name,
                Get.find<OutletsController>()
                    .outletList
                    .where((element) => element.id == salesList[index].outletId)
                    .toList()
                    .first
                    .name,
                salesList[index].quantity,
                salesList[index].discount,
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
          ),
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

  // static Widget buildContent(List<SalesReport> salesList) {
  //   return ListView.builder(
  //     itemBuilder: (context, index) {
  //       return Padding(
  //         padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
  //         child: Container(
  //           child: Row(children: <Widget>[
  //             Text(
  //               "${index + 1}. ",
  //               style: TextStyle(
  //                   // fontWeight: FontWeight.bold,
  //                   // fontSize: 16.0,
  //                   ),
  //             ),
  //             SizedBox(width: 0.5 * PdfPageFormat.cm),
  //             Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   Row(children: <Widget>[
  //                     Text(
  //                       Get.find<ProductsController>()
  //                           .productList
  //                           .where((element) =>
  //                               element.id == salesList[index].productId)
  //                           .toList()
  //                           .first
  //                           .name,
  //                       style: TextStyle(
  //                         color: PdfColors.green900,
  //                         // fontWeight: FontWeight.bold,
  //                         // fontSize: 18.0,
  //                       ),
  //                     ),
  //                     SizedBox(width: 0.5 * PdfPageFormat.cm),
  //                     Text(
  //                       "Outlet: ${Get.find<OutletsController>().outletList.where((element) => element.id == salesList[index].outletId).toList().first.name}",
  //                       style: TextStyle(
  //                           // fontWeight: FontWeight.bold,
  //                           // fontSize: 17.0,
  //                           ),
  //                     ),
  //                   ]),
  //                   Row(children: <Widget>[
  //                     Text(
  //                       "Quantity: ${salesList[index].quantity}",
  //                       style: TextStyle(
  //                           // fontWeight: FontWeight.bold,
  //                           // fontSize: 16.0,
  //                           ),
  //                     ),
  //                     SizedBox(width: 0.5 * PdfPageFormat.cm),
  //                     Text(
  //                       "Discount: ${salesList[index].discount}%",
  //                       style: TextStyle(
  //                           // fontWeight: FontWeight.bold,
  //                           // fontSize: 16.0,
  //                           ),
  //                     ),
  //                   ]),
  //                 ]),
  //           ]),
  //         ),
  //       );
  //     },
  //     itemCount: salesList.length,
  //   );
  // }
}
