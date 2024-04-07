import 'package:flutter/material.dart';
import 'package:hti_trialpathway/widgets/custom_textformfield.dart';

class MultipleSelectionDialog extends StatefulWidget {
  const MultipleSelectionDialog({super.key, required this.title, required this.elements});

  final String title;
  final List<String> elements;

  @override
  State<MultipleSelectionDialog> createState() => _MultipleSelectionDialogState();
}

class _MultipleSelectionDialogState extends State<MultipleSelectionDialog> {
  // List<String> selected = [];
  late List<String> allElements;
  late List<String> foundElements;

  void filterSearch(String keyWord){
    List<String> results = [];
    if(keyWord.isEmpty){
      results = allElements;
    }
    else{
      results = allElements.where((element) => element.toLowerCase().contains(keyWord.toLowerCase())).toList();
    }
    setState(() {
      foundElements = results;
    });
  }
@override
  void initState() {
  allElements = widget.elements;
  foundElements = allElements;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Dialog(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(alignment: Alignment.topRight, child: IconButton(onPressed: () { Navigator.pop(context); }, icon: Icon(Icons.close),),),
          ),
          Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
          CustomTextFormField(
            onChanged: (value)=>filterSearch(value),
          ),
          Expanded(
              child:

                      GridView.builder(
                          itemCount: foundElements.length,
                          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: width>700?5:2,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 1,
                              childAspectRatio: 1
                          ),
                          itemBuilder: (context, index)=>Card(child: Center(child: Text(foundElements[index])))


              ))
        ],
      ),
    );
  }
}
