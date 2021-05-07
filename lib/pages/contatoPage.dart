import 'dart:io';
import 'package:daniela/models/contato.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:daniela/contato.dart' as d2;
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'biblioteca.dart' as VarEstrangeira;


class ContatoPages extends StatefulWidget {

  final Contato contato;
  var teste = 'teste';
  String nomeTeste = '';
  bool t = true;

  ContatoPages({this.contato});

  @override
  _ContatoPageState createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPages> {
  //var controller = new MoneyMaskedTextController();
  final _nomeController = TextEditingController();
  final _HTController = TextEditingController();
  final _LEController = TextEditingController();
  final _VLController = TextEditingController();
  final _ESController = TextEditingController();
  final _TECQTDController = TextEditingController();
  final _TECCUSController = TextEditingController();
  final _ELAQTDController = TextEditingController();
  final _ELACUSController = TextEditingController();
  final _DTController = TextEditingController();
  final _nomeFocus = FocusNode();

  bool editable = true;
  bool editado = false;
  Contato _editaContato;
  d2.Contato _editaContato2;
  String testeInput;

  var DTLocal = VarEstrangeira.dataLibrary;
  var ELACUSLocal = VarEstrangeira.elastCustLibrary;
  var ELAQTDLocal = VarEstrangeira.elastQTDLibrary;
  var ESLocal = VarEstrangeira.estLibrary;
  var HTLocal = VarEstrangeira.horaTrabLibrary;
  var LELocal = VarEstrangeira.lucroEstLibrary;
  var TECCUSLocal = VarEstrangeira.tecCustLibrary;
  var TECQTDLocal = VarEstrangeira.tecQTDLibrary;
  var VLLocal = VarEstrangeira.valorLiqLibrary;
  var nomeLocal = VarEstrangeira.nomeLibrary;

  @override
  void initState(){
    super.initState();
    _testRead();

    if(widget.contato == null){
      _editaContato = Contato(VarEstrangeira.idRandom(),'','',0,0,0,0,0,0,0, VarEstrangeira.dataFormat());
    }else{
      _editaContato = Contato.fromMap(widget.contato.toMap());
      _editaContato2 = d2.Contato.fromMap(widget.contato.toMap());
      _nomeController.text = _editaContato.nome;
      _VLController.text = _editaContato.VL.toString();
      _LEController.text = _editaContato.LE.toString();
      _HTController.text = _editaContato.HT;
      _ESController.text = _editaContato.ES.toString();
      _TECQTDController.text = _editaContato.TECQTD.toString();
      _TECCUSController.text = _editaContato.TECCUS.toString();
      _ELAQTDController.text = _editaContato.ELAQTD.toString();
      _ELACUSController.text = _editaContato.ELACUS.toString();
      _DTController.text = _editaContato.DT.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,

      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('pedido').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          return Stack(
              overflow: Overflow.visible,
              children: <Widget>[

                Expanded(
                  child: Container( //BACKGROUND
                    decoration: BoxDecoration(
                      //color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage("Image/tela2.png"),
                        //alignment: Alignment.center,
                        fit: BoxFit.fill,
                        //colorFilter: new ColorFilter.mode(
                        //    Colors.green.withOpacity(1.0), BlendMode.dstATop)
                      ),
                    ),
                  ),
                ),
                Padding( //BOTÃO DE RETORNO - SETA
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Positioned(
                    left: 5,
                    top: 5,
                    child: FloatingActionButton(
                      elevation: 0.0,
                      onPressed: () { Navigator.pop(context);
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        child:
                        Image(
                          image: AssetImage('Image/Left_Arrow.png',),
                          width: 50,
                          fit: BoxFit.scaleDown,
                          color: Colors.brown,
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, // circular shape
                            color: Color.fromARGB(255,255,246,161),
                            // image: DecorationImage(
                            //     image: AssetImage("Image/Left_Arrow.png"),
                            //     scale: 1.9
                            // ),
                            boxShadow: [
                              BoxShadow(
                                //color: Colors.yellow[16774817].withOpacity(0.0),
                                color: Color.fromARGB(255,255,246,161).withOpacity(1.0),
                                spreadRadius: 10.0,
                                blurRadius: 0,
                                offset: Offset(0,0),
                              )
                            ]
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 80, 10, 0),
                  child: Card( //CARD COM INPUTS
                    elevation: 3.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder( //AJUSTA O ARREDONDAMENTO DO CARD
                      //borderRadius: BorderRadius.circular(20.0),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )
                    ),
                      child: Container(
                        width: 750.0,
                        height: 750.0,
                        child: Column(
                          children: <Widget>[
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                  Image(
                                    image: AssetImage('Image/Produto.png',),
                                    width: 45,
                                    fit: BoxFit.cover,
                                    color: Colors.brown,
                                  ),
                                  //Icon(Icons.point_of_sale_sharp, size: 37.0, color: Colors.brown),
                                  Padding(padding:  EdgeInsets.fromLTRB(0, 40, 7, 20)), //AJUSTA O ESPAÇAMENTO ENTRE A IMAGEM E O TEXTO
                                  Text(VarEstrangeira.conditionalName(VarEstrangeira.varLibrary),
                                      //textAlign: TextAlign.end,
                                      style: new TextStyle(
                                        fontSize: 30.0,
                                        color: Colors.brown,
                                      )
                                  ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 10, bottom: 10.0, left: 10.0, right: 10.0),
                            ),
                            Column(
                              children: [
                                Container(
                                  //CONTAINER - INPUT DATA
                                  width: 330,
                                  height: 50,
                                  child: StreamBuilder(
                                      stream: FirebaseFirestore.instance.collection('pedido').snapshots(), // INSTANCIA A COLEÇÃO 'PEDIDO'
                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      return TextFormField(
                                        //initialValue: VarEstrangeira.nomeLibrary.toString(),
                                        initialValue: nomeLocal,
                                        autofocus: true,
                                        cursorColor: Colors.brown,
                                        style: TextStyle(fontSize: 16.0, height: 1.5, color: Colors.brown),
                                        textAlign: TextAlign.left,
                                        //controller: _nomeController,
                                        //focusNode: _nomeFocus,
                                        decoration: InputDecoration(
                                          labelText: 'Nome',
                                          labelStyle: TextStyle(color: Colors.brown, fontSize: 16.0),
                                          isDense: true,
                                          contentPadding: EdgeInsets.all(2.0),
                                        ),
                                        onChanged: (text){
                                          editado = true;
                                          setState(() {
                                            _editaContato.nome = text;
                                            _editaContato2.nome = text;
                                          });
                                        },
                                      );
                                    }
                                  ),
                                ),
                                Container( //CONTAINER HORA TRABALHADA
                                  width: 330,
                                  height: 50,
                                  child: TextFormField(
                                    //initialValue: VarEstrangeira.horaTrabLibrary.toString(),
                                    initialValue: HTLocal,
                                    autofocus: true,
                                    cursorColor: Colors.brown,
                                    style: TextStyle(fontSize: 16.0, height: 1.5, color: Colors.brown),
                                    textAlign: TextAlign.left,
                                    //controller: _HTController,
                                    decoration: InputDecoration(
                                      //prefix: Text('R\$ '),
                                      labelText: "Hora Trabalhada EX: 30.5",
                                      labelStyle: TextStyle(color: Colors.brown, fontSize: 16.0),
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(2.0),
                                      //alignLabelWithHint: true,
                                    ),
                                    onChanged: (text){
                                      editado = true;
                                      setState(() {
                                        //final rendaMensalController = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',', leftSymbol: 'R\$');
                                        _editaContato.HT = text;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Container( //CONTAINER INPUT LUCRO
                              width: 330,
                              height: 50,
                              child: TextFormField(
                                //initialValue: VarEstrangeira.lucroEstLibrary.toString(),
                                initialValue: LELocal.toString(),
                                autofocus: true,
                                cursorColor: Colors.brown,
                                style: TextStyle(fontSize: 16.0, height: 1.5, color: Colors.brown),
                                textAlign: TextAlign.left,
                                //controller: _LEController,
                                decoration: InputDecoration(
                                  prefix: Text('R\$ '), //PREFIXO PARA DIGITAÇÃO
                                  labelText: "Lucro Esperado",
                                  labelStyle: TextStyle(color: Colors.brown, fontSize: 16.0),
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(2.0),
                                  //contentPadding: EdgeInsets.only(left: 0, bottom: 15, top: 2.0), alignLabelWithHint: true,
                                ),
                                onChanged: (text){
                                  editado = true;
                                  setState(() {
                                    _editaContato.LE = double.parse(text);
                                  });
                                },
                              ),
                            ),
                            Container( //CONTAINER PARA VALOR LÍQUIDO
                              width: 330,
                              height: 50,
                              child: TextFormField(
                                //initialValue: VarEstrangeira.valorLiqLibrary.toString(),
                                initialValue: VLLocal.toString(),
                                autofocus: true,
                                cursorColor: Colors.brown,
                                style: TextStyle(fontSize: 16.0, height: 1.5, color: Colors.brown,),
                                textAlign: TextAlign.left,
                                //controller: _VLController,
                                decoration: InputDecoration(
                                  prefix: Text('R\$ '),
                                  labelText: "Valor Líquido",
                                  labelStyle: TextStyle(color: Colors.brown, fontSize: 16.0),
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(2.0),
                                  //alignLabelWithHint: true,
                                ),
                                onChanged: (text){
                                  editado = true;
                                  setState(() {
                                    //icone: Icons.monetization_on;
                                    _editaContato.VL = double.parse(text);
                                  });
                                },
                              ),
                            ),
                            Container( //CONTAINER ESTOQUE
                              width: 330,
                              height: 50,
                              child: TextFormField(
                                //initialValue: VarEstrangeira.estLibrary.toString(),
                                initialValue: ESLocal.toString(),
                                autofocus: true,
                                cursorColor: Colors.brown,
                                style: TextStyle(fontSize: 16.0, height: 1.5, color: Colors.brown),
                                textAlign: TextAlign.left,
                                //controller: _ESController,
                                decoration: InputDecoration(
                                  labelText: "Estoque",
                                  labelStyle: TextStyle(color: Colors.brown, fontSize: 16.0),
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(2.0),
                                  //alignLabelWithHint: true,
                                ),
                                onChanged: (text){
                                  editado = true;
                                  setState(() {
                                    //icone: Icons.monetization_on;
                                    _editaContato.ES = int.parse(text);
                                    _editaContato2.ES = int.parse(text);
                                  });
                                },
                              ),
                            ),
                            Container( // TECIDO/QUANT CUSTO
                              width: 330,
                              height: 50,
                              child: TextFormField(
                                //initialValue: VarEstrangeira.tecCustLibrary.toString(),
                                initialValue: TECCUSLocal.toString(),
                                autofocus: true,
                                cursorColor: Colors.brown,
                                style: TextStyle(fontSize: 16.0, height: 1.5, color: Colors.brown),
                                textAlign: TextAlign.left,
                                //controller: _TECCUSController,
                                decoration: InputDecoration(
                                  prefix: Text('R\$ '),
                                  labelText: "Tecido custo",
                                  labelStyle: TextStyle(color: Colors.brown, fontSize: 16.0),
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(2.0),
                                  //alignLabelWithHint: true,
                                ),
                                onChanged: (text){
                                  editado = true;
                                  setState(() {
                                    //final rendaMensalController = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',', leftSymbol: 'R\$');
                                    _editaContato.TECCUS = int.parse(text) as double;
                                  });
                                },
                              ),
                            ),
                            Container( // TECIDO/QUANT CUSTO
                              width: 330,
                              height: 50,
                              child: TextFormField(
                                //initialValue: VarEstrangeira.tecQTDLibrary.toString(),
                                initialValue: TECQTDLocal.toString(),
                                autofocus: true,
                                cursorColor: Colors.brown,
                                style: TextStyle(fontSize: 16.0, height: 1.5, color: Colors.brown),
                                textAlign: TextAlign.left,
                                //controller: _TECQTDController,
                                decoration: InputDecoration(
                                  labelText: "Tecido comprimento",
                                  labelStyle: TextStyle(color: Colors.brown, fontSize: 16.0),
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(2.0),
                                  //alignLabelWithHint: true,
                                ),
                                onChanged: (text){
                                  editado = true;
                                  setState(() {
                                    //final rendaMensalController = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',', leftSymbol: 'R\$');
                                    _editaContato.TECQTD = int.parse(text);
                                  });
                                },
                              ),
                            ),
                            Container( // ELÁSTICO/QUANT CUSTO
                              width: 330,
                              height: 50,
                              child: TextFormField(
                                //initialValue: VarEstrangeira.elastCustLibrary.toString(),
                                initialValue: ELACUSLocal.toString(),
                                autofocus: true,
                                cursorColor: Colors.brown,
                                style: TextStyle(fontSize: 16.0, height: 1.5, color: Colors.brown),
                                textAlign: TextAlign.left,
                                //controller: _ELACUSController,
                                decoration: InputDecoration(
                                  prefix: Text('R\$ '),
                                  labelText: "Elástico custo",
                                  labelStyle: TextStyle(color: Colors.brown, fontSize: 16.0),
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(2.0),
                                  //alignLabelWithHint: true,
                                ),
                                onChanged: (text){
                                  editado = true;
                                  setState(() {
                                    //final rendaMensalController = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',', leftSymbol: 'R\$');
                                    _editaContato.ELACUS = int.parse(text) as double;
                                  });
                                },
                              ),
                            ),
                            Container( // ELÁSTICO/QUANT CUSTO
                              width: 330,
                              height: 50,
                              child: TextFormField(
                                //initialValue: VarEstrangeira.elastQTDLibrary.toString(),
                                initialValue: ELAQTDLocal.toString(),
                                autofocus: true,
                                cursorColor: Colors.brown,
                                style: TextStyle(fontSize: 16.0, height: 1.5, color: Colors.brown),
                                textAlign: TextAlign.left,
                                //controller: _ELAQTDController,
                                decoration: InputDecoration(
                                  labelText: "Elástico comprimento",
                                  labelStyle: TextStyle(color: Colors.brown, fontSize: 16.0),
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(2.0),
                                  //alignLabelWithHint: true,
                                ),
                                onChanged: (text){
                                  editado = true;
                                  setState(() {
                                    //final rendaMensalController = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',', leftSymbol: 'R\$');
                                    _editaContato.ELAQTD = int.parse(text);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ]
          );
        }
      ),
      floatingActionButton: //BOTÃO SALVAR
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding( //AJUSTA O POSICIONAMENTO DO BOTÃO
            padding: const EdgeInsets.only(left: 325.0),
            child: FloatingActionButton(
              //heroTag: null,
              heroTag: 'unq2',
              onPressed: () {
                if(_editaContato.nome != null && _editaContato.nome.isNotEmpty)
                {
                  Navigator.pop(context, _editaContato);
                  Navigator.pop(context, _editaContato2);
                }
                else{
                  _exibeAviso();
                  FocusScope.of(context).requestFocus(_nomeFocus);
                }
              },
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // circular shape
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.centerLeft,
                    stops: [0.3, 1.0],
                    colors: [
                      Color.fromARGB(255,230,119,53), Color.fromARGB(255,161,88,52)
                    ],
                  ),
                ),
                child: Icon(Icons.save, size: 40.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> _testRead() async{// TESTE DE LEITURA DE DADO
    await
    FirebaseFirestore.instance
        .collection('pedido')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((collection) {
        var teste = collection['HT'];
        //return teste;
        setState(() {
          testeInput = teste;
        });
      });
    });
  }

  Future<String> _variaveisInput(indice) async{// TESTE DE LEITURA DE DADO
    await
    FirebaseFirestore.instance
        .collection('pedido')
        .where("id", isEqualTo : indice)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((collection) {
        var teste = collection['HT'];
        setState(() {
          testeInput = teste;
          //VarEstrangeira.horaTrabLibrary = teste;
        });
      });
    });
  }

  void _atualizar(indice){

    FirebaseFirestore.instance
        .collection('pedido')
        .where("id", isEqualTo : indice)
        .get().then((value){
      value.docs.forEach((element){
        FirebaseFirestore.instance.collection("pedido").doc(indice).update({
          'ELACUS': 5,
          'ELAQTD': 100,
          'ES': 3,
          'HT': '10',
          'LE': 670,
          'TECCUS': 10,
          'TECQTD': 5,
          'VL': 100,
          'id': '001',
          'nome': 'vaso grande'
        });
      });
    });
    //return _exibeContatoPage();
  }

  void _exibeAviso() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Nome"),
          content: new Text("Informe o nome do contato"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
