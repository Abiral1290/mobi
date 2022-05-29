// ListView.builder(
// shrinkWrap: true,
// itemCount: Get.find<ProductBrandController>().brandList.length,
// itemBuilder: (context,index){
// my_product =  Get.find<ProductBrandController>().brandList[index];
// var item = Get.find<ProductBrandController>().brandList[index];
// //     Get.find<ProductBrandController>().brandList[index] =Get.find<ProductBrandController>().selectedName;
// return    Card(
// color: item != null ? Colors.white : Colors.white54,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(12.0),
// ),
// //   shape: BeveledRectangleBorder(
// //   borderRadius: BorderRadius.circular(5.0),
// // ),
// // shape: StadiumBorder(
// //     side: BorderSide(
// //       color: Colors.black,
// //       width: 1.5,
// //       borderRadius: BorderRadius.circular(10.0),
// //     ),),
// // outlet[index].selected ? Colors.grey
// elevation: 7.0,
// child:
//
// ExpansionTile(
//
// //  initiallyExpanded: index == _selected,
// onExpansionChanged: (text){setState(() {
// Get.find<ProductBrandController>().getNameList(item);
// _selected = index;
//
// });
// },
// title: Text(item),
// children: [
//
// InkWell(
// onTap: (){
// // OutletInfoPages(
// //   outlet : Get
// //         .find<OutletsController>()
// //         .outletList[index],
// // ));
// //  Get.to(SellProductPage(outlet:outlet  ));
// Get.to(DetailsProduct(
// outlet: widget.outlet,product: Get.find<ProductBrandController>().getNameList(item)
// ));
// // print(outlet.name);
// },
// child:
// ListView.builder(
// physics: const NeverScrollableScrollPhysics(),
// shrinkWrap: true,
// itemCount: Get.find<ProductBrandController>().name.length  ,
// itemBuilder: (context,index){
// my_product =  Get.find<ProductBrandController>().name[index];
// var item = Get.find<ProductBrandController>().name[index];
// return InkWell(
// onTap: (){
// //   showAlertDialog();
// Widget cancelButton = TextButton(
// child: Text("Cancel"),
// onPressed:  () {
// Get.back();
// },
// );
// Widget continueButton = TextButton(
// child: Text("Continue"),
// onPressed:  () async {
//
//
// Get.find<ProductBrandController>().getparsename(item);
// Get.find<ProductBrandController>().quantity.add(_textEditingController.text);
// print(Get.find<ProductBrandController>().punched_product.length);
// int total = int.parse(_textEditingController.text) * int.parse(Get.find<ProductBrandController>().selectedUnit);
// print( Get.find<ProductBrandController>().selectedUnit);
// Get.find<ProductBrandController>().punched_product.add(Punched(Name: item,
// quantity: int.parse(_textEditingController.text),Cost: total));
//
// _textEditingController.clear();
// //  _textEditingController.clear();
// Get.back();
//
// }
// );
// // set up the AlertDialog
// AlertDialog alert = AlertDialog(
// title: Text(my_product),
// content: Row(
// children: [
// // TextField(
// //
// // ),
// Expanded(
// child: TextFormField(
// controller: _textEditingController,
// keyboardType: TextInputType.number,
// //    controller: userInput,
// style: TextStyle(
// fontSize: 24,
// color: Colors.blue,
// fontWeight: FontWeight.w600,
// ),
// onChanged: (value) {
// setState(() {
// value = _textEditingController?.text;
// // _textEditingController.clear();
// //      userInput.text = value.toString();
// });
// },
//
// ),
// ),
// Text(" Cost :${Get.find<ProductBrandController>().selectedValue.toString()}"
//
// ),
//
// ],
// ),
// actions: [
// cancelButton,
// continueButton,
// ],
// );
// // show the dialog
// showDialog(
// context: context,
// builder: (BuildContext context) {
// return alert;
// },
// );
// Get.find<ProductBrandController>().unit.add(item);
// print( Get.find<ProductBrandController>().unit.first);
//
// },
//
// child: Card(
// //   color: produce.selected ? Colors.grey : Colors.white,
// elevation: 7.0,
// child: Padding(
// padding: const EdgeInsets.all(10.0),
// child: Column(
// children: [
// Row(
// children: [
// //     Text(
// //       "Name:",
// // //      style: titleStyle,
// //     ),
// Spacer(),
// Expanded(
// child: Text(
// item,
// overflow: TextOverflow.visible,
// maxLines: null,
// //     style: contentStyle,
// ),
// ),
// ],
// ),
//
// ],
// ),
// ),
// ),
// );
//
// }),
//
// ),
//
// ],
// )
//
// );
//
// });