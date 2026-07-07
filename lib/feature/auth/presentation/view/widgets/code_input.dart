import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CodeInput extends StatefulWidget {
  const CodeInput({
    super.key,
    this.length = 6,
    this.errorText,
    this.autofocus = true,
    this.value,
    required this.onChanged,
    required this.onSubmitted,
  });

  final int length;
  final String? errorText;
  final bool autofocus;
  final String? value;
  final void Function(String otp)? onChanged;
  final void Function()? onSubmitted;

  @override
  State<CodeInput> createState() => _CodeInputState();
}

class _CodeInputState extends State<CodeInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  bool get _hasError => widget.errorText != null;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    if (widget.autofocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNode.requestFocus();
      });
    }
  }

  @override
  void didUpdateWidget(CodeInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value && widget.value != _controller.text) {
      _controller.text = widget.value ?? '';
      if (widget.value == null || widget.value!.isEmpty) {
        _controller.selection = TextSelection.fromPosition(
          const TextPosition(offset: 0),
        );
      }
    }
  }

  void _onTap() {
    _focusNode.requestFocus();
    if (_hasError) {
      _clearAll();
    }
  }

  void _clearAll() {
    _controller.clear();
    widget.onChanged?.call('');
    _focusNode.requestFocus();
  }

  void _onChanged(String value) {
    final cleanValue = value.replaceAll(RegExp(r'\D'), '');
    if (cleanValue.length > widget.length) {
      _controller.text = cleanValue.substring(0, widget.length);
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: widget.length),
      );
    }
    // _controller.text
    widget.onChanged?.call(cleanValue);
  }

  Color _borderColor(BuildContext context, int index) {
    if (_hasError) {
      return Theme.of(context).colorScheme.error;
    }

    final textLength = _controller.text.length;
    final isFilled = index < textLength;
    final isActive = _focusNode.hasFocus && index == textLength;

    if (isFilled || isActive) {
      return Theme.of(context).colorScheme.primary;
    }

    return Colors.grey.shade400;
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _onTap,
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(widget.length, (index) {
                  return AnimatedBuilder(
                    animation: _controller,
                    builder: (context, state) {
                      final text = _controller.text;
                      final digit = index < text.length ? text[index] : '';
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Container(
                            height: 56,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: _borderColor(context, index),
                                width: 1.4,
                              ),
                            ),
                            child: Text(
                              digit,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
              Positioned.fill(
                child: Opacity(
                  opacity: 0,
                  child: TextFormField(
                    controller: _controller,
                    focusNode: _focusNode,
                    autofocus: widget.autofocus,
                    onChanged: _onChanged,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: widget.length,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(widget.length),
                    ],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      counterText: '',
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (widget.errorText != null) ...[
          const SizedBox(height: 8),
          Text(
            widget.errorText!,
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }
}
