import 'package:flutter/material.dart';

import '../models/plane_angle.dart';
import '../utils/utils.dart';
import '../widgets/field_list_tile.dart';
import '../widgets/keypad.dart';

class PlaneAngleConversionScreen extends StatefulWidget {
  const PlaneAngleConversionScreen({super.key});

  @override
  State<PlaneAngleConversionScreen> createState() =>
      _PlaneAngleConversionScreenState();
}

class _PlaneAngleConversionScreenState
    extends State<PlaneAngleConversionScreen> {
  final TextEditingController _firstFieldController =
      TextEditingController(text: "1");
  final TextEditingController _secondFieldController =
      TextEditingController(text: "0.0174533");

  bool _isFirstFieldSelected = true;
  bool _isFirstLabelSelected = true;

  int _firstFieldIndex = 0;
  int _secondFieldIndex = 1;

  void convert() {
    convertUnit(
      _firstFieldController,
      _secondFieldController,
      _firstFieldIndex,
      _secondFieldIndex,
      PlaneAngle.planeAngleList,
      _isFirstFieldSelected,
    );
  }

  void changeSelectedIndex(int index) {
    setState(() {
      if (_isFirstLabelSelected) {
        _firstFieldIndex = index;
      } else {
        _secondFieldIndex = index;
      }
    });

    convert();
  }

  @override
  void dispose() {
    _firstFieldController.dispose();
    _secondFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Plane Angle Conversion',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  FieldListTile(
                    list: PlaneAngle.planeAngleList,
                    controller: _firstFieldController,
                    isFieldSelected: _isFirstFieldSelected,
                    isLabelSelected: _isFirstLabelSelected,
                    fieldIndex: _firstFieldIndex,
                    onFieldSelect: () {
                      setState(() {
                        _isFirstFieldSelected = true;
                      });
                    },
                    onLabelSelect: () {
                      setState(() {
                        _isFirstLabelSelected = true;
                      });
                      convert();
                    },
                    changeSelectedIndex: changeSelectedIndex,
                  ),
                  const SizedBox(height: 16),
                  FieldListTile(
                    list: PlaneAngle.planeAngleList,
                    controller: _secondFieldController,
                    isFieldSelected: !_isFirstFieldSelected,
                    isLabelSelected: !_isFirstLabelSelected,
                    fieldIndex: _secondFieldIndex,
                    onFieldSelect: () {
                      setState(() {
                        _isFirstFieldSelected = false;
                      });
                    },
                    onLabelSelect: () {
                      setState(() {
                        _isFirstLabelSelected = false;
                      });
                      convert();
                    },
                    changeSelectedIndex: changeSelectedIndex,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Keypad(
              controller: _isFirstFieldSelected
                  ? _firstFieldController
                  : _secondFieldController,
              onChanged: convert,
            ),
          ),
        ],
      ),
    );
  }
}
