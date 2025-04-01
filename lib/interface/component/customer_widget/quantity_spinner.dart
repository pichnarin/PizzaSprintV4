import 'package:flutter/material.dart';

class QuantitySpinner extends StatefulWidget {
  final int initialQuantity;
  final int minQuantity;
  final int maxQuantity;
  final ValueChanged<int> onChanged;

  const QuantitySpinner({
    Key? key,
    this.initialQuantity = 1,
    this.minQuantity = 1,
    this.maxQuantity = 10,
    required this.onChanged,
  }) : super(key: key);

  @override
  _QuantitySpinnerState createState() => _QuantitySpinnerState();
}

class _QuantitySpinnerState extends State<QuantitySpinner> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialQuantity;
  }

  void _incrementQuantity() {
    if (_quantity < widget.maxQuantity) {
      setState(() {
        _quantity++;
        widget.onChanged(_quantity);
      });
    }
  }

  void _decrementQuantity() {
    if (_quantity > widget.minQuantity) {
      setState(() {
        _quantity--;
        widget.onChanged(_quantity);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: _decrementQuantity,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        SizedBox(
          width: 40,
          child: Center(
            child: Text(
              _quantity.toString(),
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: _incrementQuantity,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }
}

