import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'input.widget.dart';
import 'loading-button.widget.dart';

class SubmitForm extends StatefulWidget {
  var gasCtrl = new MoneyMaskedTextController(leftSymbol: 'R\$');
  var alcCtrl = new MoneyMaskedTextController(leftSymbol: 'R\$');
  var gasConsumeCtrl = new MoneyMaskedTextController(
    precision: 1,
    rightSymbol: 'KM/L',
    thousandSeparator: '',
    decimalSeparator: '.',
  );
  var alcConsumeCtrl = new MoneyMaskedTextController(
    precision: 1,
    rightSymbol: 'KM/L',
    thousandSeparator: '',
    decimalSeparator: '.',
  );
  var busy = false;
  Function submitFunc;

  SubmitForm({
    @required this.gasCtrl,
    @required this.alcCtrl,
    @required this.busy,
    @required this.submitFunc,
    @required this.gasConsumeCtrl,
    @required this.alcConsumeCtrl,
  });

  @override
  _SubmitFormState createState() => _SubmitFormState();
}

class _SubmitFormState extends State<SubmitForm> {
  var isExactValue = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            left: 30,
            right: 30,
          ),
          child: Input(
            label: "Gasolina",
            ctrl: widget.gasCtrl,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 30,
            right: 30,
          ),
          child: Input(
            label: "Álcool",
            ctrl: widget.alcCtrl,
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Padding(
          padding: EdgeInsets.only(
            right: 50,
          ),
          child: CheckboxListTile(
            title: Text(
              "Deseja fazer o cálculo exato?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontFamily: "Big Shoulders Display",
              ),
              textAlign: TextAlign.center,
            ),
            activeColor: Colors.green,
            value: isExactValue,
            onChanged: (value) {
              setState(() {
                isExactValue = value;
              });
            },
          ),
        ),
        if (isExactValue)
          Padding(
            padding: EdgeInsets.only(
              right: 90,
            ),
            child: Text(
              "Digite o consumo do seu carro.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontFamily: "Big Shoulders Display",
              ),
              textAlign: TextAlign.right,
            ),
          ),
        if (isExactValue)
          Padding(
            padding: EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            child: Input(
              label: "Gasolina",
              ctrlConsume: widget.gasConsumeCtrl,
            ),
          ),
        if (isExactValue)
          Padding(
            padding: EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            child: Input(
              label: "Álcool",
              ctrlConsume: widget.alcConsumeCtrl,
            ),
          ),
        SizedBox(
          height: 25,
        ),
        LoadingButton(
          busy: widget.busy,
          invert: false,
          func: widget.submitFunc,
          text: "CALCULAR",
        ),
      ],
    );
  }
}
