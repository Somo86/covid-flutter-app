import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class TypeField extends StatelessWidget {
  final Function getSuggested;
  final Function onSuggestionSelected;

  TypeField({@required this.getSuggested, @required this.onSuggestionSelected});

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
          autofocus: false,
          style: DefaultTextStyle.of(context)
              .style
              .copyWith(fontSize: 14),
          decoration: InputDecoration(border: OutlineInputBorder())),
      suggestionsCallback: (pattern) {
        return Future(() => getSuggested(pattern));
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          leading: Icon(Icons.location_on),
          title: Text(suggestion['name']),
        );
      },
      onSuggestionSelected: (suggestion) {
        onSuggestionSelected(suggestion);
      },
    );
  }
}
