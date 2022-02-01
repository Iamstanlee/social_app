import 'package:colco_poc/config/theme.dart';
import 'package:colco_poc/core/utils/constants.dart';
import 'package:colco_poc/core/utils/extensions.dart';
import 'package:colco_poc/core/utils/input.dart';
import 'package:flutter/material.dart';

class CommentBox extends StatefulWidget {
  final ValueChanged<String> send;
  const CommentBox({required this.send, Key? key}) : super(key: key);

  @override
  State<CommentBox> createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final _text = _controller.text;
    return Container(
      height: 50,
      color: AppColors.kLightGrey.withOpacity(0.2),
      padding: const EdgeInsets.symmetric(horizontal: Insets.md),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: TextFormField(
              controller: _controller,
              maxLines: 10,
              minLines: 1,
              style: context.textTheme.bodyText1,
              decoration: const InputDecoration(
                hintText: 'Add your comment',
                border: InputBorder.none,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Insets.md),
            child: Text(
              'send',
              style: _text.isNotEmpty
                  ? context.textTheme.bodyText2
                  : context.textTheme.bodyText2!
                      .copyWith(color: AppColors.kGrey),
            ).onTap(
              () {
                if (_text.isNotEmpty) {
                  widget.send(_text);
                  _controller.clear();
                  InputUtils.hideKeyboard();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
