import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      title: 'Calculadora de IMC',
      home: Home(),
    )
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _infoText = 'Informe seus dados!';
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void resetField(){
    weightController.text = '';
    heightController.text = '';

    setState(() {
      _infoText = 'Informe seus dados!';
      _formKey.currentState.reset();
    });
  }

  void _calculateImc(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.6){
        _infoText = 'Abaixo do peso. IMC ${imc.toStringAsPrecision(4)}';
      }
      else if(imc < 24.9) {
        _infoText = 'Peso ideal. IMC ${imc.toStringAsPrecision(4)}';
      }
      else if(imc < 29.9) {
        _infoText = 'Levemente acima do peso. IMC ${imc.toStringAsPrecision(4)}';
      }
      else if(imc < 34.9) {
        _infoText = 'Obesidade grau 1. IMC ${imc.toStringAsPrecision(4)}';
      }
      else if(imc < 39.9) {
        _infoText = 'Obesidade grau 2. IMC ${imc.toStringAsPrecision(4)}';
      }
      else {
        _infoText = 'Obesidade grau 3. IMC ${imc.toStringAsPrecision(4)}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: resetField,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120, color: Colors.green,),
              TextFormField(
                validator: (value){
                  if(value.isEmpty){
                    return 'Informe seu peso';
                  }

                  return null;
                },
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
                decoration: InputDecoration(
                    labelText: 'Peso (kg)',
                    labelStyle: TextStyle(
                        color: Colors.green
                    )
                ),
                controller: weightController,
              ),
              TextFormField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                  decoration: InputDecoration(
                      labelText: 'Altura (cm)',
                      labelStyle: TextStyle(
                          color: Colors.green
                      ),
                      errorStyle: TextStyle(
                        color: Colors.blue
                      )
                  ),
                  controller: heightController,
                  validator: (value){
                    if(value.isEmpty){
                      return 'Informe sua altura';
                    }

                    return null;
                  },
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: 50,
                  child: RaisedButton(
                      onPressed: (){
                        if (_formKey.currentState.validate()){
                          _calculateImc();
                        }
                      },
                      child: Text('Calcular', style: TextStyle(color: Colors.white, fontSize: 25),),
                      color: Colors.green
                  )
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 25
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
