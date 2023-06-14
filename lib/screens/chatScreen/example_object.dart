import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/text_copletion_provider.dart';
import '../../util/constants/constants.dart';
import 'example_text_outer_box.dart';

class ExampleObject extends StatelessWidget {
  const ExampleObject({super.key});
  @override
  Widget build(BuildContext context) {
    final textCompletionProvider =
        Provider.of<TextCompletProvider>(context, listen: false);
    return Consumer<TextCompletProvider>(
      builder: (context, value, child) => Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Center(
              child: Text(
              "AI BUDDY",
              style: GoogleFonts.righteous(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.light_mode_outlined,
                color: cgSecondary,
              ),
              const SizedBox(width: 10),
              Text("Examples",
                  style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: cgSecondary))
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Center(
              child: InkWell(
                  onTap: () => {
                        textCompletionProvider.onExampleTextPressed(
                            "Explain quantum computing in simple terms")
                      },
                  child: const ExampleTextOuterBox(
                      text:
                          '"Explain quantum computing in simple terms -->"'))),
          const SizedBox(
            height: 15,
          ),
          Center(
              child: InkWell(
                  onTap: () => {
                        textCompletionProvider.onExampleTextPressed(
                            "Got any creative ideas for a 10 year old’s birthday?")
                      },
                  child: const ExampleTextOuterBox(
                      text:
                          '"Got any creative ideas for a 10 year old’s \nbirthday? -->"'))),
          const SizedBox(
            height: 15,
          ),
          Center(
              child: InkWell(
                  onTap: () => {
                        textCompletionProvider.onExampleTextPressed(
                            "How do I make an HTTP request in Javascript?")
                      },
                  child: const ExampleTextOuterBox(
                      text:
                          '"How do I make an HTTP request in \nJavascript? -->"'))),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.insights_outlined,
                color: cgSecondary,
              ),
              const SizedBox(width: 10),
              Text("Capabilities",
                  style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: cgSecondary))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
              child: ExampleTextOuterBox(
                  text:
                      'Remembers what user said earlier in the conversation')),
          const SizedBox(
            height: 15,
          ),
          const Center(
              child: ExampleTextOuterBox(
                  text: 'Allows user to provide follow-up corrections')),
          const SizedBox(
            height: 15,
          ),
          const Center(
              child: ExampleTextOuterBox(
                  text: 'Trained to decline inappropriate requests')),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.warning_amber,
                color: cgSecondary,
              ),
              const SizedBox(width: 10),
              Text("Limitations",
                  style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: cgSecondary))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
              child: ExampleTextOuterBox(
                  text: 'May occasionally generate incorrect information')),
          const SizedBox(
            height: 15,
          ),
          const Center(
              child: ExampleTextOuterBox(
                  text:
                      'May occasionally produce harmful instructions or biased content')),
          const SizedBox(
            height: 15,
          ),
          const Center(
              child: ExampleTextOuterBox(
                  text: 'Limited knowledge of world and events \nafter 2021')),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
