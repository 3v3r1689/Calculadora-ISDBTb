import 'package:flutter/material.dart';
import 'package:isdbtb_calculator/isdbt_LayerA.dart';
import 'package:isdbtb_calculator/isdbt_LayerB.dart';
import 'package:isdbtb_calculator/isdbt_LayerC.dart';
import 'package:isdbtb_calculator/isdbt_general.dart';

class isdbtScreen extends StatefulWidget {
  isdbtScreen({super.key});

  @override
  State<isdbtScreen> createState() => _isdbtScreenState();
}

class _isdbtScreenState extends State<isdbtScreen> {
  late String _intervaloDeGuardaValor;
  late String _modoDeOperacion;
  late String _segmentA;
  late String _segmentB;
  late String _oneSeg;


  @override
  void initState(){
    super.initState();
    _intervaloDeGuardaValor = "1/4";
    _modoDeOperacion = "3(8k)";
    _segmentA = "13";
    _segmentB = "0";
    _oneSeg = "No";

  }

  void _updateOneSeg(String newValue){
    setState(() {
      _oneSeg = newValue;
      if(newValue == "Si"){
        _segmentA = "1";
      }
    });
  }
  
  void _updateIntervaloDeGuarda(String newValue){
    setState(() {
      _intervaloDeGuardaValor = newValue;
    });
  }

  void _updateModoDeOperacion(String newValue){
    setState(() {
      _modoDeOperacion = newValue;
    });
  }

  void _updateSegmentFromA(String newValue){
    setState(() {      
      _segmentA = newValue;
      _segmentB = (13-int.parse(_segmentA)).toString() ;  
     
  });
  }

  void _updateSegmentFromB(String newValue){
    setState(() {
      _segmentB =newValue;
    });
  }



  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        isdbtGeneral(
          onItervalChanged: _updateIntervaloDeGuarda, 
          onModeChanged: _updateModoDeOperacion,
          onPartialChanged: _updateOneSeg,),
        isdbtLayerA(
          intervaloDeGuarda: _intervaloDeGuardaValor, 
          modoDeOperacion: _modoDeOperacion,
          onSegmentChanged: _updateSegmentFromA,
          isPartialReception: _oneSeg,),
        isdbtLayerB(
          intervaloDeGuarda: _intervaloDeGuardaValor, 
          modoDeOperacion: _modoDeOperacion,
          availableSegments: (13-int.parse(_segmentA)).toString(), 
          onSegmentChanged: _updateSegmentFromB,
          defaultSegments: _segmentB,),
        isdbtLayerC(
          intervaloDeGuarda: _intervaloDeGuardaValor, 
          modoDeOperacion: _modoDeOperacion,
          availableSegments: (13-int.parse(_segmentA)-int.parse(_segmentB)).toString(),
    )]);
  }
}