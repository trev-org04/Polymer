import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_polymer/models/data.dart';
import 'package:project_polymer/screens/home/data_tile.dart';

class DataList extends StatefulWidget {
  @override
  _DataListState createState() => _DataListState();
}

class _DataListState extends State<DataList> {

  @override
  Widget build(BuildContext context) {

    final data = Provider.of<List<Data>>(context) ?? [];
      
    return Expanded(
      child: ListView.builder(
        itemCount: data.length, 
        itemBuilder: (context, index) {
          return DataTile(data: data[index]);
        },
      ),
    );
  }
}