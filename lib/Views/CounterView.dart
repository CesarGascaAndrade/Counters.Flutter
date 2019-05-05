import 'package:counters/Models/Counter.dart';
import 'package:counters/ViewModels/CountersViewModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CounterView extends StatefulWidget {
  final Counter counter;

  CounterView(this.counter);

  @override
  State<StatefulWidget> createState() {
    return CounterViewState();
  }
}


class CounterViewState extends State<CounterView> {
  

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = new TextEditingController();
  TextEditingController countController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = widget.counter != null ? widget.counter.name : '';
    countController.text = widget.counter != null ? widget.counter.count.toString() : '';
    return Scaffold(
      appBar: AppBar(
        title: widget.counter == null ? Text("New counter") : Text("Edit Counter"),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Counter name'),
                controller: nameController,
                validator: (value) {
                  if (value.length == 0) {
                    return 'Name must not be empty';
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Counter value'),
                controller: countController,
                keyboardType: TextInputType.numberWithOptions(),
              ),
              ScopedModelDescendant(
                builder: (
                  BuildContext context,
                  Widget child,
                  CountersViewModel viewModel,
                ) {
                  return RaisedButton(
                    child: Text('Save'),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        widget.counter.name = nameController.text;
                        widget.counter.count = int.parse(countController.text);

                        await viewModel.saveCounter(widget.counter);
                        Navigator.pop(context);
                      }
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
