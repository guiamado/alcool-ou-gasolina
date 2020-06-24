import 'package:aog/widgets/logo.widget.dart';
import 'package:aog/widgets/submit-form.dart';
import 'package:aog/widgets/success.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _color = Colors.deepPurple;
  var _gasCtrl = new MoneyMaskedTextController(leftSymbol: 'R\$');
  var _alcCtrl = new MoneyMaskedTextController(leftSymbol: 'R\$');
  var _gasConsumeCtrl = new MoneyMaskedTextController(
    precision: 1,
    rightSymbol: 'KM/L',
    thousandSeparator: '',
    decimalSeparator: '.',
  );
  var _alcConsumeCtrl = new MoneyMaskedTextController(
    precision: 1,
    rightSymbol: 'KM/L',
    thousandSeparator: '',
    decimalSeparator: '.',
  );
  var _busy = false;
  var _completed = false;
  var _resultText = "Compensa utilizar álcool";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AnimatedContainer(
          duration: Duration(
            milliseconds: 1200,
          ),
          color: _color,
          child: ListView(
            children: <Widget>[
              Logo(),
              _completed
                  ? Success(
                      result: _resultText,
                      reset: reset,
                    )
                  : SubmitForm(
                      gasCtrl: _gasCtrl,
                      alcCtrl: _alcCtrl,
                      busy: _busy,
                      submitFunc: calculate,
                      gasConsumeCtrl: _gasConsumeCtrl,
                      alcConsumeCtrl: _alcConsumeCtrl,
                    ),
            ],
          ),
        ));
  }

  Future calculate() {
    double alc =
        double.parse(_alcCtrl.text.replaceAll(new RegExp(r'[,.A-Z\$\/]'), '')) /
            100;

    double gas =
        double.parse(_gasCtrl.text.replaceAll(new RegExp(r'[,.A-Z\$\/]'), '')) /
            100;
    double res = alc / gas;

    double alcConsumo = double.parse(
            _alcConsumeCtrl.text.replaceAll(new RegExp(r'[,.A-Z\$\/]'), '')) /
        100;

    double gasConsumo = double.parse(
            _gasConsumeCtrl.text.replaceAll(new RegExp(r'[,.A-Z\$\/]'), '')) /
        100;

    setState(() {
      _color = Colors.deepPurpleAccent;
      _completed = false;
      _busy = true;
    });

    return new Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        if (alcConsumo > 0 && gasConsumo > 0) {
          double resConsumo = alcConsumo / gasConsumo;
          if (resConsumo > res) {
            _resultText = 'Compensa utilizar Álcool!';
          } else if (resConsumo == res) {
            _resultText =
                'Custo benefício igual para ambos, fica à sua escolha.';
          } else {
            _resultText = 'Compensa utilizar Gasolina!';
          }
        } else {
          if (res >= 0.7) {
            _resultText = 'Compensa utilizar Gasolina!';
          } else {
            _resultText = 'Compensa utilizar Álcool!';
          }
        }

        _completed = true;
        _busy = false;
      });
    });
  }

  reset() {
    setState(() {
      _alcCtrl = new MoneyMaskedTextController(leftSymbol: 'R\$');
      _gasCtrl = new MoneyMaskedTextController(leftSymbol: 'R\$');
      _gasConsumeCtrl = new MoneyMaskedTextController(
        precision: 1,
        rightSymbol: 'KM/L',
        thousandSeparator: '',
        decimalSeparator: '.',
      );
      _alcConsumeCtrl = new MoneyMaskedTextController(
        precision: 1,
        rightSymbol: 'KM/L',
        thousandSeparator: '',
        decimalSeparator: '.',
      );
      _completed = false;
      _busy = false;
      _color = Colors.deepPurple;
    });
  }
}
