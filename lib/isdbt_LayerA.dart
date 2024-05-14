import 'package:flutter/material.dart';
import 'package:isdbtb_calculator/isdbt_FEC.dart';
import 'package:isdbtb_calculator/isdbt_modulation.dart';

// ignore: must_be_immutable
class isdbtLayerA extends StatefulWidget {
  final void Function(String) onSegmentChanged;
  String intervaloDeGuarda;
  String modoDeOperacion;
  String isPartialReception;
  isdbtLayerA({super.key,  
    required this.intervaloDeGuarda, 
    required this.modoDeOperacion, 
    required this.onSegmentChanged,
    required this.isPartialReception
    });
  
  

  @override
  State<isdbtLayerA> createState() => _isdbtLayerAState();
}

class _isdbtLayerAState extends State<isdbtLayerA> {

  
  String numberOfSegments = "13";
  String selectedFEC = "1/2";
  String modulation = "QPSK";


  String calcularTasaDeTransmision(String segmentos, String fec, String modulacion, String intervalo, String modo){
    int k = 0;
    double f = 0;
    double t = 0;
    double d = 0;

    switch(modulacion){
      case "QPSK":
      k = 2;
      case "16QAM":
      k = 4;
      case "64QAM":
      k = 6;
    }

    switch(fec){
      case "1/2":
      f = 1/2;
      case "2/3":
      f = 2/3;
      case "3/4":
      f = 3/4;
      case "5/6":
      f = 5/6;
      case "7/8":
      f = 7/8;
    }

    switch(intervalo){
      case "1/4":
      t = 4/5;
      case "1/8":
      t = 8/9;
      case "1/16":
      t = 16/17;
      case "1/32":
      t = 32/33;
    }

    switch(modo){
      case "1(2k)":
      d = 96*3.968;
      case "2(4k)":
      d = 192*1.9841;
      case "3(8k)":
      d = 384*0.992;
    }
    double R = int.parse(segmentos)*k*f*d*t*(188/204)/1000;
    return R.toStringAsFixed(3);
  }

  List<DropdownMenuItem<String>> menuModulation(String isPartial) {
    switch (isPartial){
      case "No":
      
        var menu = modulationList.map((String modu){
                  return DropdownMenuItem(
                    value: modu ,
                    child: Text(modu ));
                }).toList();
        return menu;

      case "Si":
        
        var menu =["QPSK"].map((String modu ){
                  return DropdownMenuItem(
                    value: modu ,
                    child: Text(modu));
                }).toList();
        return menu;

      default :
        
        var menu =["QPSK"].map((String modu ){
                  return DropdownMenuItem(
                    value: modu ,
                    child: Text(modu));
                }).toList();
        return menu;     
    }
  }   

  List<DropdownMenuItem<String>> menuSegments(String isPartial){
    switch(isPartial){
      case "No":
      var menu = List.generate(13, (index) => (index+1).toString()).map((String seg){    
                  return DropdownMenuItem(
                    value: seg,
                    child: Text(seg));
                }).toList();
      return menu;

      case "Si":
      var menu = ["1"].map((String seg){    
                  return DropdownMenuItem(
                    value: seg,
                    child: Text(seg));
                }).toList();
      return menu;

      default :
        var menu = List.generate(14, (index) => (index).toString()).map((String seg){    
                  return DropdownMenuItem(
                    value: seg,
                    child: Text(seg));
                }).toList();
      return menu;         
    }
  }

  String kindOfModulation (String isPartial){
    if(isPartial == "No"){
      return modulation;
    }else{
      return modulation = "QPSK";
    }
  }

  String kindOfSegment (String isPartial){
    if(isPartial == "No"){
      return numberOfSegments;
    }else{
      return numberOfSegments = "1";
    }
  }

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
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Capa A" , style:  TextStyle(fontSize: 20.0),)
            ],
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,children: [
          const Text("Segmentos: " , style: TextStyle(fontSize: 20.0),),
          //Text("7" , style: TextStyle(fontSize: 20.0),)
          DropdownButton(
                value: kindOfSegment(widget.isPartialReception),
                //items: segmentsList.map((String seg){
                /*
                items: List.generate(14, (index) => (index).toString()).map((String seg){    
                  return DropdownMenuItem(
                    value: seg,
                    child: Text(seg));
                }).toList(), 
                */
                items: menuSegments(widget.isPartialReception),
                onChanged: (String? newValue){
                  setState(() {
                    numberOfSegments = newValue?? "0";
                    widget.onSegmentChanged(newValue!);
                  });
                })
        ],),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Modulacion: ", style: TextStyle(fontSize: 20.0),),
            //Text("QPSK", style: TextStyle(fontSize: 20.0),)
            DropdownButton(
                value: kindOfModulation(widget.isPartialReception),
                /*
                items: modulationList.map((String modu ){
                  return DropdownMenuItem(
                    value: modu,
                    child: Text(modu));
                }).toList(), 

                */

                items: menuModulation(widget.isPartialReception),
                onChanged: (String? newValue){
                  setState(() {
                    modulation = newValue?? "QPSK";
                  });
                  
            
                })
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            const Text("FEC: ", style: TextStyle(fontSize: 20.0),),
            //Text("3/4", style: TextStyle(fontSize: 20.0),)
            DropdownButton(
                value: selectedFEC,
                items: fecList.map((String f){
                  return DropdownMenuItem(
                    value: f,
                    child: Text(f));
                }).toList(), 
                onChanged: (String? newValue){
                  setState(() {
                    selectedFEC = newValue?? "1/2";
                  });
                })
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            const Text("BitRate: ", style: TextStyle(fontSize: 20.0),),
            Text("${calcularTasaDeTransmision(numberOfSegments, selectedFEC, modulation, widget.intervaloDeGuarda, widget.modoDeOperacion)} Mbps", style: const TextStyle(fontSize: 20.0),)
          
          ],
        )]
        
      ),
    );
  }
}