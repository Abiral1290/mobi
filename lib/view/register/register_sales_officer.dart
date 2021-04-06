import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterSOfficer extends StatefulWidget {
  @override
  _RegisterSOfficerState createState() => _RegisterSOfficerState();
}

class _RegisterSOfficerState extends State<RegisterSOfficer> {
  final TextEditingController _nameCntrl = new TextEditingController();
  final TextEditingController _postCntrl = new TextEditingController();
  final TextEditingController _phoneCntrl = new TextEditingController();
  String _type = 'Trading';

  bool validateInput() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Register Sales Officer'),
        ),
        body: Container(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  autofocus: false,
                  decoration: InputDecoration(
                      labelText: 'Name', prefixIcon: Icon(Icons.person)),
                  controller: _nameCntrl,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: InputDecoration(
                      labelText: 'Phone', prefixIcon: Icon(Icons.phone)),
                  controller: _phoneCntrl,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  autofocus: false,
                  decoration: InputDecoration(
                      labelText: 'Post', prefixIcon: Icon(Icons.work)),
                  controller: _postCntrl,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12.0),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Type',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Radio(
                        value: 'Trading',
                        groupValue: _type,
                        onChanged: (newValue) =>
                            setState(() => _type = newValue),
                        activeColor: Colors.red,
                      ),
                      Text("Trading"),
                      SizedBox(
                        width: 42,
                      ),
                      Radio(
                        value: 'Manufacturing',
                        groupValue: _type,
                        onChanged: (newValue) =>
                            setState(() => _type = newValue),
                        activeColor: Colors.red,
                      ),
                      Text("Manufacturing")
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 5),
                child: MaterialButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (validateInput()) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: Text('Please Wait'),
                              content: Column(
                                children: [
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                        Text('Registering new sales officer'),
                                  ),
                                  CupertinoActivityIndicator(
                                    radius: 17,
                                  )
                                ],
                              ),
                            );
                          });
                    }
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text('Submit'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
