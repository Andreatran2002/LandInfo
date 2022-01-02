import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';

class RichEditor extends StatefulWidget {
  TextEditingController controller ;
  RichEditor({Key? key, required this.controller}) : super(key: key);
  @override
  _RichEditorState createState() => _RichEditorState();
}

class _RichEditorState extends State<RichEditor> {
  String _description = '';

  get description => _description;
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
    //  print(widget.controller.text);
    });
  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  MarkdownTextInput(
                        (String value) => setState(() => _description = value),
                    _description,
                    label: 'Description',
                    maxLines: 10,
                    actions: MarkdownType.values,
                    controller: widget.controller,
                  ),
                  TextButton(
                    onPressed: () {
                      widget.controller.clear();
                    },
                    child: const Text('Clear' , style: TextStyle(color : Colors.white),),
                    style :  ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),)
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: MarkdownBody(
                      data: _description,
                      shrinkWrap: true,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
