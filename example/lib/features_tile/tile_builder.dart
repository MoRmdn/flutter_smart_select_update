import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import '../options.dart' as options;

class FeaturesTileBuilder extends StatefulWidget {
  @override
  _FeaturesTileBuilderState createState() => _FeaturesTileBuilderState();
}

class _FeaturesTileBuilderState extends State<FeaturesTileBuilder> {

  List<String> _cars = ['bmw-x2', 'bmw-x1', 'honda-hrv', 'honda-jazz', 'hyundai-i10', 'bmw-sgt'];
  List<String> _categories = [];
  String _sort = 'popular';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 7),
          Card(
            elevation: 3,
            margin: const EdgeInsets.all(5),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: SmartSelect<String>.multiple(
                    title: 'Categories',
                    value: _categories,
                    options: options.categories,
                    onChange: (state) => setState(() => _categories = state.value),
                    modalType: S2ModalType.bottomSheet,
                    modalHeader: false,
                    tileBuilder: (context, state) {
                      return S2Tile.fromState(
                        state,
                        trailing: const Icon(Icons.arrow_drop_down),
                        isTwoLine: true,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 40,
                  child: VerticalDivider(),
                ),
                Expanded(
                  child: SmartSelect<String>.single(
                    title: 'Sort By',
                    value: _sort,
                    options: options.sorts,
                    onChange: (state) => setState(() => _sort = state.value),
                    modalType: S2ModalType.popupDialog,
                    modalHeader: false,
                    tileBuilder: (context, state) {
                      return S2Tile.fromState(
                        state,
                        trailing: const Icon(Icons.arrow_drop_down),
                        isTwoLine: true,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SmartSelect<String>.multiple(
            title: 'Cars',
            value: _cars,
            options: S2Option.listFrom<String, Map>(
              source: options.cars,
              value: (index, item) => item['value'],
              title: (index, item) => item['title'],
              group: (index, item) => item['body'],
            ),
            onChange: (state) => setState(() => _cars = state.value),
            modalType: S2ModalType.bottomSheet,
            modalConfirmation: true,
            modalFilter: true,
            choiceGrouped: true,
            tileBuilder: (context, state) {
              return Card(
                elevation: 3,
                margin: const EdgeInsets.all(5),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: S2ChipsTile<String>(
                  state: state,
                  title: const Text('Cars'),
                  // subtitle: Text('lorem impsum'),
                  // leading: CircleAvatar(
                  //   backgroundImage: NetworkImage('https://source.unsplash.com/8I-ht65iRww/100x100'),
                  // ),
                  trailing: const Icon(Icons.add_circle_outline),
                  // scrollable: true,
                  // divider: Divider(height: 1),
                  chipColor: Colors.red,
                  chipBrightness: Brightness.dark,
                  onDeleted: (value) {
                    setState(() => _cars.remove(value));
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 7),
        ],
      ),
    );
  }
}