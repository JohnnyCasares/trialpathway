import 'package:flutter/material.dart';
import 'package:hti_trialpathway/widgets/custom_textformfield.dart';

class MultipleSelectionDialog extends StatefulWidget {
  const MultipleSelectionDialog(
      {super.key,
      required this.title,
      required this.elements,
      this.isMultipleSelection = true,
      this.initialSelection});

  final String title;
  final List<String> elements;
  final bool isMultipleSelection;

  final List<String>? initialSelection;

  @override
  State<MultipleSelectionDialog> createState() =>
      _MultipleSelectionDialogState();
}

class _MultipleSelectionDialogState extends State<MultipleSelectionDialog> {
  late List<String> selected = [];
  late List<String> allElements;
  late List<String> foundElements;

  void filterSearch(String keyWord) {
    List<String> results;
    if (keyWord.isEmpty) {
      results = allElements;
    } else {
      results = allElements
          .where((element) =>
              element.toLowerCase().contains(keyWord.toLowerCase()))
          .toList();
    }
    setState(() {
      foundElements = results;
    });
  }

  @override
  void initState() {
    if(widget.initialSelection!=null){
      selected.addAll(widget.initialSelection!.map((e) => e.trim()).toList()) ;
    }
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
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              ),
            ),
          ),
          Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          CustomTextFormField(
            onChanged: (value) => filterSearch(value),
          ),
          Wrap(
            children: selected
                .map((e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        child: Text(e),
                        onPressed: () {
                          setState(() {
                            selected.remove(e);
                            foundElements.add(e);
                            foundElements.sort();
                          });
                        },
                      ),
                    ))
                .toList(),
          ),
          Expanded(
              child: GridView.builder(
                  itemCount: foundElements.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: width > 700 ? 5 : 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1),
                  itemBuilder: (context, index) => ElevatedButton(
                      onPressed: () {
                        //populate selected if multiple selection is enabled
                        if (widget.isMultipleSelection) {
                          setState(() {
                            selected.add(foundElements[index].trim());
                            selected.sort();
                            foundElements.remove(foundElements[index]);
                          });
                        } else {
                          Navigator.pop<String>(context, foundElements[index]);
                        }
                      },
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ))),
                      child: Center(child: Text(foundElements[index]))))),
          if (widget.isMultipleSelection)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                  onPressed: () {
                    String tmp = selected.toString().substring(1,selected.toString().length-1);
                    Navigator.pop<String>(context, tmp);
                  },
                  child: const Text('Save')),
            )
        ],
      ),
    );
  }
}
