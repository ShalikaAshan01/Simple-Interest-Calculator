import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Calculator",
    home: SIForm(),
    theme: ThemeData(
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
        brightness: Brightness.dark),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var currencies = ["Rupees", "Dolars", "Pounds"];
  final minimumPadding = 5.0;
  var selectedCurrency;

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();
  var displayResult = '';
  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    selectedCurrency = currencies[0];
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Interest Calculator"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(minimumPadding * 2),
          child: ListView(
            children: <Widget>[
              getImageAsset(),
              Padding(
                padding: EdgeInsets.only(
                    top: minimumPadding, bottom: minimumPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: principalController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter principal amount';
                    }
                    if(!isNumeric(value)){
                      return 'Please enter numberic value';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Principal',
                      hintText: 'Enter Principal eg:2000',
                      labelStyle: textStyle,
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 15.0
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: minimumPadding, bottom: minimumPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: roiController,
                  validator: (String value){
                    if(value.isEmpty){
                      return 'Please enter rate of interest';
                    }

                    if(!isNumeric(value)){
                      return 'Please enter numberic value';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Rate of Interest',
                      hintText: 'In percent',
                      labelStyle: textStyle,
                      errorStyle: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 15.0
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: termController,
                      validator: (String value){
                        if(value.isEmpty){
                          return 'Please enter Term';
                        }
                        if(!isNumeric(value)){
                          return 'Please enter numberic value';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Term',
                          hintText: 'Years',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 15.0
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                  Container(
                    width: minimumPadding * 5,
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                      items: currencies.map((String values) {
                        return DropdownMenuItem<String>(
                          value: values,
                          child: Text(values),
                        );
                      }).toList(),
                      value: selectedCurrency,
                      onChanged: (String value) {
                        setState(() {
                          selectedCurrency = value;
                        });
                      },
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: minimumPadding, bottom: minimumPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        child: Text(
                          "Calculate",
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState.validate()) {
                              this.displayResult = calculate();
                            }
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          "Reset",
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            reset();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(minimumPadding * 2),
                child: Text(
                  "$displayResult",
                  style: textStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(
      image: assetImage,
      width: 120.0,
      height: 120.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(minimumPadding * 10),
    );
  }

  String calculate() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);
    double result = principal + (principal * roi * term) / 100.0;
    return 'After $term years, your investments will be worth $result $selectedCurrency';
  }

  void reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    selectedCurrency = currencies[0];
  }
  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }
}
