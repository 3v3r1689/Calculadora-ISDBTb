
import 'package:flutter/material.dart';
import 'package:isdbtb_calculator/isdbt_channels.dart';

class isdbtGeneral extends StatefulWidget {

  final void Function(String) onItervalChanged;
  final void Function(String) onModeChanged;
  final void Function(String) onPartialChanged;
  isdbtGeneral({super.key, 
  required this.onItervalChanged, 
  required this.onModeChanged,
  required this.onPartialChanged});

  @override
  State<isdbtGeneral> createState() => _isdbtGeneralState();
}

class _isdbtGeneralState extends State<isdbtGeneral> {

  String _selectedChannel = "14" ;

  List<String> modos =["1(2k)","2(4k)","3(8k)"];
  //String _modeOperation = "1(2k)";
  late String _modeOperation;

  List<String> intervalos = ["1/4","1/8","1/16","1/32"];
  late String _intervaloDeGuarda;
  //String intervaloDeGuarda = "1/4";
  @override
  void initState(){
    super.initState();
    _intervaloDeGuarda = "1/4";
    _modeOperation = "3(8k)";
  }

  List<String> oneSeg = ["Si","No"];
  String recepcionParcial = "No";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.black12.withOpacity(0.1)
      ),
     
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Canal: ", style: TextStyle(fontSize: 20.0),),
              //Text("37", style: TextStyle(fontSize: 20.0),),  
              DropdownButton(
                
                value: _selectedChannel,
                items:  uhfItems = UhfChannels.map((String channel) {
                    return DropdownMenuItem<String>(
                      value: channel,
                      child: Text(channel),
                    );
                  }).toList(),
                  
                onChanged:(String? newValue){
                  setState(() {
                    _selectedChannel = newValue?? "14";
                    if(_selectedChannel == "37"){
                      const snackBar = SnackBar(
                      content: Center(child: Text('El canal 37 esta destinado para radioastronomia segun la UIT')),
                      duration: Duration(seconds: 3), // Duración del mensaje
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    }  
                
                  });
                },

                )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            const Text("Frecuencia: " , style: TextStyle(fontSize: 20.0),),
              // ignore: prefer_const_constructors
              Text("${(int.parse(_selectedChannel)-14)*6+473.142857}" , style: TextStyle(fontSize: 20.0),),
              Container(),
              const Text(" MHz" , style: TextStyle(fontSize: 20.0),)
          ],),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Modo de operacion: ", style: TextStyle(fontSize: 20.0),),
              //Text("3(8k)", style: TextStyle(fontSize: 20.0),)
              DropdownButton(
                value: _modeOperation,
                items: modos.map((String mode){
                  return DropdownMenuItem(
                    value: mode,
                    child: Text(mode));
                }).toList(), 
                onChanged: (String? newValue){
                  setState(() {
                    _modeOperation = newValue?? "3(8k)";
                  });
                  widget.onModeChanged(newValue!);
                })
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Intervalo de Guarda: ", style: TextStyle(fontSize: 20.0),),
              //Text("1/8", style: TextStyle(fontSize: 20.0),)
              DropdownButton(
                value: _intervaloDeGuarda,
                items: intervalos.map((String inter){
                  return DropdownMenuItem(
                    value: inter,
                    child: Text(inter));
                }).toList(), 
                onChanged: (String? newValue){
                  setState(() {
                    _intervaloDeGuarda = newValue?? "1/4";
                  });
                  widget.onItervalChanged(newValue!);
                
                })
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Recepcion parcial: ", style: TextStyle(fontSize: 20.0),),
              //Text("Si", style: TextStyle(fontSize: 20.0),)
              DropdownButton(
                value: recepcionParcial,
                items: oneSeg.map((String answer){
                  return DropdownMenuItem(
                    value: answer,
                    child: Text(answer));
                }).toList(), 
                onChanged: (String? newValue){
                  setState(() {
                    recepcionParcial = newValue?? "No";
                    widget.onPartialChanged(newValue!);
                  });
                })
             ],
          )
      
        ],
      ),
    );
  }
}