import 'package:flutter/material.dart';

void main (){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState> ();

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  primary: Colors.green,
  minimumSize: Size(100, 50),
  padding: EdgeInsets.symmetric(horizontal: 20),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  
  String _infoText= "Informe seus dados";

  void _reset(){
    setState(() {
    weightController.text = "";
    heightController.text = "";
    _infoText = "Informe seus dados";
    });
    
  }

  void _calcular(){
    setState(() {
      double weight = double.parse(weightController.text);
    double heigth = double.parse(heightController.text);
    double imc = weight / (heigth * heigth);
    if(imc < 18.6){
      _infoText = "Abaixo do peso (${imc.toStringAsPrecision(2)})";
    } else if( imc >= 18.6 && imc < 24.9){
      _infoText = 'Peso Ideal(${imc.toStringAsPrecision(2)})';
    }else if (imc >= 24.9 && imc < 29.9){
      _infoText = 'Levemente acima do peso(${imc.toStringAsPrecision(2)})';
    } else if (imc >= 29.9 && imc < 34.9){
      _infoText = 'Obesidade I(${imc.toStringAsPrecision(2)})';

    }else if (imc >= 34.9 && imc < 39.9){
      _infoText = 'Obesidade II (${imc.toStringAsPrecision(2)})';

    }else {
      _infoText = 'Obesidade III(${imc.toStringAsPrecision(2)})';
    }
    });
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(onPressed: _reset, icon: Icon(Icons.refresh,),)
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column( 
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Icons.person,
                   size: 120,
                    color: Colors.green,),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Pesso em kg",
                      labelStyle: TextStyle(
                      color: Colors.green, 
                      fontSize: 25,),
                    ),
                  controller: weightController,
                  validator: (value) {
                    if (value == null || value . isEmpty ){
                      return "Insira seu peso";
                    }
                  },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Altura em Metros",
                      labelStyle: TextStyle(
                        color: Colors.green, 
                        fontSize: 25,),
                    ),
                  controller: heightController,
                   validator: (value) {
                    if (value == null || value . isEmpty ){
                      return "Insira sua altura";
                    }
                  },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: ElevatedButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          _calcular();
                        }
                      }, 
                      child: Text('Calcular',
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 25),
                    ),
                     style: raisedButtonStyle,),
                  ),
                  Text(_infoText, 
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, 
                  fontSize: 25,),
        
              ),
              ],
              ),
            ],
          ),
        )

      
    ),
    );
  }
}