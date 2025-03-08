import 'package:flutter/material.dart';
import 'listarUsuarios.dart';
import 'editdata.dart';
import 'package:http/http.dart' as http;


class Detail extends StatefulWidget {
  final List list;
  final int index;
  Detail({required this.index, required this.list});
  @override
  _DetailState createState() => new _DetailState();
}

class _DetailState extends State<Detail> {

void deleteData(){
  var url = Uri.parse("http://10.0.2.2/tienda/deleteData.php");
  http.post(url, body: {
    'id': widget.list[widget.index]['id']
  });
}

void confirm (){
  AlertDialog alertDialog = new AlertDialog(
    content: new Text("Esta seguto de eliminar '${widget.list[widget.index]['username']}'"),
    actions: <Widget>[
      new ElevatedButton(
        child: new Text("OK Eliminado!",style: new TextStyle(color: Colors.black),),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        onPressed: (){
          deleteData();
          Navigator.of(context).push(
            new MaterialPageRoute(
              builder: (BuildContext context)=> new Home(),
            )
          );
        },
      ),
      new ElevatedButton(
        child: new Text("CANCELAR",style: new TextStyle(color: Colors.black)),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        onPressed: ()=> Navigator.pop(context),
      ),
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alertDialog;
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("${widget.list[widget.index]['username']}")),
      body: new Container(
        height: 270.0, 
        padding: const EdgeInsets.all(20.0),
        child: new Card(
          child: new Center(
            child: new Column(
              children: <Widget>[

                new Padding(padding: const EdgeInsets.only(top: 30.0),),
                new Text(widget.list[widget.index]['username'], style: new TextStyle(fontSize: 20.0),),
                Divider(),
                new Text("Nivel : ${widget.list[widget.index]['nivel']}", style: new TextStyle(fontSize: 18.0),),
                new Padding(padding: const EdgeInsets.only(top: 30.0),),

                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new ElevatedButton(
                    child: new Text("EDITAR"),                  
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: ()=>Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context)=>new EditData(list: widget.list, index: widget.index,),
                        )
                      ),                    
                  ),
                  VerticalDivider(),
                  new ElevatedButton(
                    child: new Text("ELIMINAR"),                  
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: ()=>confirm(),                
                  ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}