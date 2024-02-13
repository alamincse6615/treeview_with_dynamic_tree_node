import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tree_demo/model.dart';
import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final globalKey = GlobalKey<ScaffoldState>();
  final AutoScrollController scrollController = AutoScrollController();
  TreeViewController? _controller;

  String data = "[{\"Code\":\"RG-01\",\"Name\":\"DhakaMetro\",\"ParentCode\":\"CL-01\",\"MHLevel\":4},{\"Code\":\"AA-05\",\"Name\":\"Savar\",\"ParentCode\":\"RG-01\",\"MHLevel\":5},{\"Code\":\"AA-03\",\"Name\":\"Mirpur\",\"ParentCode\":\"RG-01\",\"MHLevel\":5},{\"Code\":\"AA-06\",\"Name\":\"Mirpur-2\",\"ParentCode\":\"RG-01\",\"MHLevel\":5},{\"Code\":\"AA-04\",\"Name\":\"NewMarket\",\"ParentCode\":\"RG-01\",\"MHLevel\":5},{\"Code\":\"AA-02\",\"Name\":\"Manikgonj\",\"ParentCode\":\"RG-01\",\"MHLevel\":5},{\"Code\":\"AA-01\",\"Name\":\"Keranigonj\",\"ParentCode\":\"RG-01\",\"MHLevel\":5},{\"Code\":\"DA-002\",\"Name\":\"Kamrangirchar-2\",\"ParentCode\":\"AA-01\",\"MHLevel\":6},{\"Code\":\"DA-001\",\"Name\":\"Bongshal\",\"ParentCode\":\"AA-01\",\"MHLevel\":6},{\"Code\":\"DA-006\",\"Name\":\"Kamrangirchar-1\",\"ParentCode\":\"AA-01\",\"MHLevel\":6},{\"Code\":\"DA-004\",\"Name\":\"Keranigonj-2\",\"ParentCode\":\"AA-01\",\"MHLevel\":6},{\"Code\":\"DA-003\",\"Name\":\"Keranigonj\",\"ParentCode\":\"AA-01\",\"MHLevel\":6},{\"Code\":\"DA-005\",\"Name\":\"Lalbagh\",\"ParentCode\":\"AA-01\",\"MHLevel\":6},{\"Code\":\"TT-005\",\"Name\":\"Lalbagh-GT\",\"ParentCode\":\"DA-005\",\"MHLevel\":7},{\"Code\":\"TT-003\",\"Name\":\"Keranigonj-GT\",\"ParentCode\":\"DA-003\",\"MHLevel\":7},{\"Code\":\"TT-004\",\"Name\":\"Keranigonj-2-GT\",\"ParentCode\":\"DA-004\",\"MHLevel\":7},{\"Code\":\"TT-006\",\"Name\":\"Kamrangirchar-1-GT\",\"ParentCode\":\"DA-006\",\"MHLevel\":7},{\"Code\":\"TT-001\",\"Name\":\"Bongshal-GT\",\"ParentCode\":\"DA-001\",\"MHLevel\":7},{\"Code\":\"TT-002\",\"Name\":\"Kamrangirchar-2-GT\",\"ParentCode\":\"DA-002\",\"MHLevel\":7},{\"Code\":\"DA-007\",\"Name\":\"Dhamrai\",\"ParentCode\":\"AA-02\",\"MHLevel\":6},{\"Code\":\"DA-010\",\"Name\":\"Manikgonj\",\"ParentCode\":\"AA-02\",\"MHLevel\":6},{\"Code\":\"DA-009\",\"Name\":\"Harirampur\",\"ParentCode\":\"AA-02\",\"MHLevel\":6},{\"Code\":\"DA-008\",\"Name\":\"Geoure\",\"ParentCode\":\"AA-02\",\"MHLevel\":6},{\"Code\":\"DA-011\",\"Name\":\"Saturia\",\"ParentCode\":\"AA-02\",\"MHLevel\":6},{\"Code\":\"DA-012\",\"Name\":\"Shibaloy\",\"ParentCode\":\"AA-02\",\"MHLevel\":6},{\"Code\":\"DA-013\",\"Name\":\"Singair\",\"ParentCode\":\"AA-02\",\"MHLevel\":6},{\"Code\":\"TT-013\",\"Name\":\"Singair-GT\",\"ParentCode\":\"DA-013\",\"MHLevel\":7},{\"Code\":\"TT-012\",\"Name\":\"Shibaloy-GT\",\"ParentCode\":\"DA-012\",\"MHLevel\":7},{\"Code\":\"TT-011\",\"Name\":\"Saturia-GT\",\"ParentCode\":\"DA-011\",\"MHLevel\":7},{\"Code\":\"TT-008\",\"Name\":\"Geoure-GT\",\"ParentCode\":\"DA-008\",\"MHLevel\":7},{\"Code\":\"TT-009\",\"Name\":\"Harirampur-GT\",\"ParentCode\":\"DA-009\",\"MHLevel\":7},{\"Code\":\"TT-010\",\"Name\":\"Manikgonj-GT\",\"ParentCode\":\"DA-010\",\"MHLevel\":7},{\"Code\":\"TT-007\",\"Name\":\"Dhamrai-GT\",\"ParentCode\":\"DA-007\",\"MHLevel\":7},{\"Code\":\"DA-024\",\"Name\":\"Mohammadpur\",\"ParentCode\":\"AA-04\",\"MHLevel\":6},{\"Code\":\"DA-023\",\"Name\":\"Dhanmondi\",\"ParentCode\":\"AA-04\",\"MHLevel\":6},{\"Code\":\"DA-025\",\"Name\":\"NewMarket\",\"ParentCode\":\"AA-04\",\"MHLevel\":6},{\"Code\":\"DA-022\",\"Name\":\"Atibazaar\",\"ParentCode\":\"AA-04\",\"MHLevel\":6},{\"Code\":\"DA-021\",\"Name\":\"Adabar\",\"ParentCode\":\"AA-04\",\"MHLevel\":6},{\"Code\":\"TT-021\",\"Name\":\"Adabar-GT\",\"ParentCode\":\"DA-021\",\"MHLevel\":7},{\"Code\":\"TT-022\",\"Name\":\"Atibazaar-GT\",\"ParentCode\":\"DA-022\",\"MHLevel\":7},{\"Code\":\"TT-025\",\"Name\":\"NewMarket-GT\",\"ParentCode\":\"DA-025\",\"MHLevel\":7},{\"Code\":\"TT-023\",\"Name\":\"Dhanmondi-GT\",\"ParentCode\":\"DA-023\",\"MHLevel\":7},{\"Code\":\"TT-024\",\"Name\":\"Mohammadpur-GT\",\"ParentCode\":\"DA-024\",\"MHLevel\":7},{\"Code\":\"DA-036\",\"Name\":\"Savar\",\"ParentCode\":\"AA-06\",\"MHLevel\":6},{\"Code\":\"DA-034\",\"Name\":\"Hemayetpur\",\"ParentCode\":\"AA-06\",\"MHLevel\":6},{\"Code\":\"DA-032\",\"Name\":\"Bosila\",\"ParentCode\":\"AA-06\",\"MHLevel\":6},{\"Code\":\"DA-035\",\"Name\":\"Kallayanpur\",\"ParentCode\":\"AA-06\",\"MHLevel\":6},{\"Code\":\"DA-033\",\"Name\":\"Gabtoli\",\"ParentCode\":\"AA-06\",\"MHLevel\":6},{\"Code\":\"DA-026\",\"Name\":\"Ashulia\",\"ParentCode\":\"AA-06\",\"MHLevel\":6},{\"Code\":\"TT-026\",\"Name\":\"Ashulia-GT\",\"ParentCode\":\"DA-026\",\"MHLevel\":7},{\"Code\":\"TT-033\",\"Name\":\"Gabtoli-GT\",\"ParentCode\":\"DA-033\",\"MHLevel\":7},{\"Code\":\"TT-035\",\"Name\":\"Kallayanpur-GT\",\"ParentCode\":\"DA-035\",\"MHLevel\":7},{\"Code\":\"TT-032\",\"Name\":\"Bosila-GT\",\"ParentCode\":\"DA-032\",\"MHLevel\":7},{\"Code\":\"TT-034\",\"Name\":\"Hemayetpur-GT\",\"ParentCode\":\"DA-034\",\"MHLevel\":7},{\"Code\":\"TT-036\",\"Name\":\"Savar-GT\",\"ParentCode\":\"DA-036\",\"MHLevel\":7},{\"Code\":\"DA-018\",\"Name\":\"Monipur\",\"ParentCode\":\"AA-03\",\"MHLevel\":6},{\"Code\":\"DA-017\",\"Name\":\"Mirpur-13\",\"ParentCode\":\"AA-03\",\"MHLevel\":6},{\"Code\":\"DA-020\",\"Name\":\"Mirpur-12\",\"ParentCode\":\"AA-03\",\"MHLevel\":6},{\"Code\":\"DA-019\",\"Name\":\"Pollabi\",\"ParentCode\":\"AA-03\",\"MHLevel\":6},{\"Code\":\"DA-016\",\"Name\":\"Mirpur\",\"ParentCode\":\"AA-03\",\"MHLevel\":6},{\"Code\":\"DA-015\",\"Name\":\"Kafrul\",\"ParentCode\":\"AA-03\",\"MHLevel\":6},{\"Code\":\"DA-014\",\"Name\":\"Duaripara\",\"ParentCode\":\"AA-03\",\"MHLevel\":6},{\"Code\":\"TT-014\",\"Name\":\"Duaripara-GT\",\"ParentCode\":\"DA-014\",\"MHLevel\":7},{\"Code\":\"TT-015\",\"Name\":\"Kafrul-GT\",\"ParentCode\":\"DA-015\",\"MHLevel\":7},{\"Code\":\"TT-016\",\"Name\":\"Mirpur-GT\",\"ParentCode\":\"DA-016\",\"MHLevel\":7},{\"Code\":\"TT-019\",\"Name\":\"Pollabi-GT\",\"ParentCode\":\"DA-019\",\"MHLevel\":7},{\"Code\":\"TT-020\",\"Name\":\"Mirpur-12-GT\",\"ParentCode\":\"DA-020\",\"MHLevel\":7},{\"Code\":\"TT-017\",\"Name\":\"Mirpur-13-GT\",\"ParentCode\":\"DA-017\",\"MHLevel\":7},{\"Code\":\"TT-018\",\"Name\":\"Monipur-GT\",\"ParentCode\":\"DA-018\",\"MHLevel\":7},{\"Code\":\"DA-028\",\"Name\":\"Baipal\",\"ParentCode\":\"AA-05\",\"MHLevel\":6},{\"Code\":\"DA-029\",\"Name\":\"EPZ\",\"ParentCode\":\"AA-05\",\"MHLevel\":6},{\"Code\":\"DA-030\",\"Name\":\"Jirani-2\",\"ParentCode\":\"AA-05\",\"MHLevel\":6},{\"Code\":\"DA-027\",\"Name\":\"Ashulia-2\",\"ParentCode\":\"AA-05\",\"MHLevel\":6},{\"Code\":\"DA-031\",\"Name\":\"Jirani-1\",\"ParentCode\":\"AA-05\",\"MHLevel\":6},{\"Code\":\"TT-031\",\"Name\":\"Jirani-1-GT\",\"ParentCode\":\"DA-031\",\"MHLevel\":7},{\"Code\":\"TT-027\",\"Name\":\"Ashulia-2-GT\",\"ParentCode\":\"DA-027\",\"MHLevel\":7},{\"Code\":\"TT-030\",\"Name\":\"Jirani-2-GT\",\"ParentCode\":\"DA-030\",\"MHLevel\":7},{\"Code\":\"TT-029\",\"Name\":\"EPZ-GT\",\"ParentCode\":\"DA-029\",\"MHLevel\":7},{\"Code\":\"TT-028\",\"Name\":\"Baipal-GT\",\"ParentCode\":\"DA-028\",\"MHLevel\":7}]";
  List<Model> list = [];
  List<TreeNode> parentList = [];
  Model? relationalModel ;
  TreeNode<Model>? treeNodeModel ;
  IndexedTreeNode<Model>? node;
  IndexedTreeNode<Model>? selectedMHNode;
  SharedPreferences? prefs;
  String nodePath = "";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_)async{
      prefs = await SharedPreferences.getInstance();
      if(prefs!.containsKey('counter')){
        nodePath = prefs!.get('path').toString();
      }


      convertData();
    });


  }

  convertData(){
    try{

      var dataList = jsonDecode(data);
      list = [];
      for(var item in dataList){
        Model model = Model.fromJson(item);
        list.add(model);
      }
      Model rootParent = list.firstWhere((x)=>x.parentCode == null);
      IndexedTreeNode<Model> treeRootParent =IndexedTreeNode<Model>(key: rootParent.code, data: rootParent);
      node = getNodes(list,rootParent,treeRootParent);
      if (kDebugMode) {
        print(node);
      }

      relationalModel = getNode(list,rootParent);

      setState(() {

      });
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }

  IndexedTreeNode<Model> getNodes(List<Model> items,Model currMH, IndexedTreeNode<Model> currentNode) {
    var children=list.where((x)=>x.parentCode == currMH.code);

    IndexedTreeNode<Model> child;
    for(var childMH in children)
    {
      child=IndexedTreeNode(key:childMH.code,data: childMH);
      currentNode.add(getNodes(items,childMH,child));
    }

    return currentNode;
  }


  Model getNode(List<Model> items, Model currentNode) {
    var children=list.where((x)=>x.parentCode == currentNode.code);
    for(var node in children)
    {
      currentNode.children.add(getNode(items,node));
    }
    return currentNode;
  }








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: (){getCollapse();}, icon: Icon(Icons.sync))
        ],
      ),
      body:  node == null?const CircularProgressIndicator():SizedBox(
        child:TreeView.indexed<Model>(
            tree: node!,
            expansionBehavior: ExpansionBehavior.collapseOthersAndSnapToTop,
            shrinkWrap: false,
            showRootNode: false,
            indentation: Indentation(
              width: 20,
              offset: Offset.fromDirection(20),
              style: IndentStyle.roundJoint,
            ),
            expansionIndicatorBuilder: (context, node) => ChevronIndicator.upDown(
              tree: node,


            ),

            onItemTap: (item) {
              if (kDebugMode) print("Item tapped: ${item.data!.code}");

            },
            onTreeReady: (controller) async{
              _controller = controller;
              getCollapse();
            },

            builder: (context, _node) {
              bool isSelectedItem =   (selectedMHNode!=null&&selectedMHNode!.data!.code == _node.data!.code);
              return Card(
                color: isSelectedItem?Colors.green:colorMapper[_node.level.clamp(0, colorMapper.length - 1)]!,
                child: Row(
                  children: [
                    Expanded(flex:2,child:  ListTile(
                      title: Text(" ${_node.level}.${_node.data!.name}",),
                      subtitle: Text('${_node.data?.code} ',),
                    ),),
                    Expanded(flex:1,child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: OutlinedButton(

                          onPressed: ()async {
                            setState(() async{
                              await prefs!.setString('path',_node.path);
                              selectedMHNode = _node;
                              Restart.restartApp();

                            });
                          }, child: const Text("Show",)),
                    )),
                    const SizedBox(width: 10,),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }
  final Map<int, Color> colorMapper = {
    0: Colors.white,
    1: Colors.blueGrey[50]!,
    2: Colors.blueGrey[100]!,
    3: Colors.blueGrey[200]!,
    4: Colors.blueGrey[300]!,
    5: Colors.blueGrey[400]!,
    6: Colors.blueGrey[500]!,
    7: Colors.blueGrey[600]!,
    8: Colors.blueGrey[700]!,
    9: Colors.blueGrey[800]!,
    10: Colors.blueGrey[900]!,
  };

  getCollapse(){
    if(true){
      IndexedTreeNode<Model> tempNode = node!;
      List<String> pathList = nodePath.split(".");
      pathList.removeAt(0);
      if(pathList.isNotEmpty){
        for(String item in pathList){
          var tNode = tempNode.firstWhere((element) => element.key == item);
          tempNode= tNode as IndexedTreeNode<Model>;
          _controller!.expandNode(tempNode);
        }
      }
    }
  }



}
