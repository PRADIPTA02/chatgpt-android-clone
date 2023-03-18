import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../providers/text_copletion_provider.dart';
import 'example_text_outer_box.dart';

class ExampleObject extends StatelessWidget {
  const ExampleObject({super.key});
  @override
  Widget build(BuildContext context) {
    final _textCompletionProvider =
        Provider.of<TextCompletProvider>(context, listen: false);
    return Consumer<TextCompletProvider>(
      builder: (context, value, child) => Column(
        // controller: _textCompletionProvider.exampleObjectScrollControler,
        // physics: BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
        children: [
          SizedBox(
            height: 30,
          ),
          Center(
              child: Text("ChatGPT",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.light_mode_outlined,
                color: cgSecondary,
              ),
              SizedBox(width: 10),
              Text("Examples",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: cgSecondary))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Center(
              child: InkWell(
                  onTap: () => {
                        _textCompletionProvider.onExampleTextPressed(
                            "Explain quantum computing in simple terms")
                      },
                  child: ExampleTextOuterBox(
                      text:
                          '"Explain quantum computing in simple terms -->"'))),
          SizedBox(
            height: 15,
          ),
          Center(
              child: InkWell(
                  onTap: () => {
                        _textCompletionProvider.onExampleTextPressed(
                            "Got any creative ideas for a 10 year old’s birthday?")
                      },
                  child: ExampleTextOuterBox(
                      text:
                          '"Got any creative ideas for a 10 year old’s \nbirthday? -->"'))),
          SizedBox(
            height: 15,
          ),
          Center(
              child: InkWell(
                  onTap: () => {
                        _textCompletionProvider.onExampleTextPressed(
                            "How do I make an HTTP request in Javascript?")
                      },
                  child: ExampleTextOuterBox(
                      text:
                          '"How do I make an HTTP request in \nJavascript? -->"'))),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.insights_outlined,
                color: cgSecondary,
              ),
              SizedBox(width: 10),
              Text("Capabilities",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: cgSecondary))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Center(
              child: ExampleTextOuterBox(
                  text:
                      'Remembers what user said earlier in the conversation')),
          SizedBox(
            height: 15,
          ),
          Center(
              child: ExampleTextOuterBox(
                  text: 'Allows user to provide follow-up corrections')),
          SizedBox(
            height: 15,
          ),
          Center(
              child: ExampleTextOuterBox(
                  text: 'Trained to decline inappropriate requests')),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.warning_amber,
                color: cgSecondary,
              ),
              SizedBox(width: 10),
              Text("Limitations",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: cgSecondary))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Center(
              child: ExampleTextOuterBox(
                  text: 'May occasionally generate incorrect information')),
          SizedBox(
            height: 15,
          ),
          Center(
              child: ExampleTextOuterBox(
                  text:
                      'May occasionally produce harmful instructions or biased content')),
          SizedBox(
            height: 15,
          ),
          Center(
              child: ExampleTextOuterBox(
                  text: 'Limited knowledge of world and events \nafter 2021')),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
