// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:chatgpt/providers/auth_provider.dart';
import 'package:chatgpt/util/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdvanceSettings extends StatefulWidget {
  const AdvanceSettings({super.key});

  @override
  State<AdvanceSettings> createState() => _AdvanceSettingsState();
}

class _AdvanceSettingsState extends State<AdvanceSettings> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) => Theme(
        data: Theme.of(context).copyWith(brightness: Brightness.dark),
        child: ExpansionPanelList(
          expansionCallback: (panelIndex, isExpanded) {
            authProvider.changeIsExpanded(!isExpanded);
            authProvider.changeIsAdvanceModeONOF(false);
          },
          elevation: 0,
          children: [
            ExpansionPanel(
                backgroundColor: bgColor,
                isExpanded: authProvider.IsExpanded,
                headerBuilder: (context, isExpanded) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/advanceSettingsIcon.png',
                              height: 25,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            Text(
                              "Advance Settings",
                              style: GoogleFonts.nunito(
                                  color:
                                      const Color.fromARGB(255, 212, 211, 211),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ],
                    ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Advance Mode',
                          style: GoogleFonts.nunito(
                              color: Colors.white70,
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        ),
                        Switch(
                            activeColor: cgSecondary,
                            value: authProvider.IsAdvanceModeOn,
                            onChanged: (bool value) {
                              authProvider.changeIsAdvanceModeONOF(value);
                            })
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Temperature',
                          style: GoogleFonts.nunito(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        ValueBox(
                          value: authProvider.Temperature,
                        )
                      ],
                    ),
                    Slider(
                      value: authProvider.Temperature,
                      activeColor: authProvider.IsAdvanceModeOn
                          ? cgSecondary
                          : const Color.fromARGB(255, 99, 95, 95),
                      thumbColor: Colors.white70,
                      inactiveColor: authProvider.IsAdvanceModeOn
                          ? cgSecondary.withOpacity(0.2)
                          : const Color.fromARGB(255, 99, 95, 95),
                      max: 1,
                      divisions: 100,
                      onChanged: (value) {
                        authProvider.changeTemperature(value);
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Maximum length',
                          style: GoogleFonts.nunito(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        ValueBox(
                          value: authProvider.Maximum_length,
                        )
                      ],
                    ),
                    Slider(
                      value: authProvider.Maximum_length.toDouble(),
                      activeColor: authProvider.IsAdvanceModeOn
                          ? cgSecondary
                          : const Color.fromARGB(255, 99, 95, 95),
                      thumbColor: Colors.white70,
                      inactiveColor: authProvider.IsAdvanceModeOn
                          ? cgSecondary.withOpacity(0.2)
                          : const Color.fromARGB(255, 99, 95, 95),
                      max: 4000,
                      divisions: 1000,
                      onChanged: (value) {
                        authProvider.change_maximum_length(value);
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Top P',
                          style: GoogleFonts.nunito(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        ValueBox(
                          value: authProvider.Top_P,
                        )
                      ],
                    ),
                    Slider(
                      value: authProvider.Top_P,
                      activeColor: authProvider.IsAdvanceModeOn
                          ? cgSecondary
                          : const Color.fromARGB(255, 99, 95, 95),
                      thumbColor: Colors.white70,
                      inactiveColor: authProvider.IsAdvanceModeOn
                          ? cgSecondary.withOpacity(0.2)
                          : const Color.fromARGB(255, 99, 95, 95),
                      max: 1,
                      divisions: 100,
                      onChanged: (value) {
                        authProvider.changeTop_P(value);
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Frequency Penalty',
                          style: GoogleFonts.nunito(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        ValueBox(
                          value: authProvider.Frequency_penalty,
                        )
                      ],
                    ),
                    Slider(
                      value: authProvider.Frequency_penalty,
                      activeColor: authProvider.IsAdvanceModeOn
                          ? cgSecondary
                          : const Color.fromARGB(255, 99, 95, 95),
                      thumbColor: Colors.white70,
                      inactiveColor: authProvider.IsAdvanceModeOn
                          ? cgSecondary.withOpacity(0.2)
                          : const Color.fromARGB(255, 99, 95, 95),
                      max: 2,
                      divisions: 200,
                      onChanged: (value) {
                        authProvider.changeFrequency_penalty(value);
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Presence penalty',
                          style: GoogleFonts.nunito(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        ValueBox(
                          value: authProvider.Presence_penalty,
                        )
                      ],
                    ),
                    Slider(
                      value: authProvider.Presence_penalty,
                      activeColor: authProvider.IsAdvanceModeOn
                          ? cgSecondary
                          : const Color.fromARGB(255, 99, 95, 95),
                      thumbColor: Colors.white70,
                      inactiveColor: authProvider.IsAdvanceModeOn
                          ? cgSecondary.withOpacity(0.2)
                          : const Color.fromARGB(255, 99, 95, 95),
                      max: 2,
                      divisions: 200,
                      onChanged: (value) {
                        authProvider.changePresence_penalty(value);
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Best of',
                          style: GoogleFonts.nunito(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        ValueBox(
                          value: authProvider.Best_of,
                        )
                      ],
                    ),
                    Slider(
                      value: authProvider.Best_of.toDouble(),
                      activeColor: authProvider.IsAdvanceModeOn
                          ? cgSecondary
                          : const Color.fromARGB(255, 99, 95, 95),
                      thumbColor: Colors.white70,
                      inactiveColor: authProvider.IsAdvanceModeOn
                          ? cgSecondary.withOpacity(0.2)
                          : const Color.fromARGB(255, 99, 95, 95),
                      max: 20,
                      divisions: 20,
                      onChanged: (value) {
                        authProvider.changeBest_of(value);
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (states) => authProvider.IsAdvanceModeOn
                                          ? cgSecondary
                                          : cgSecondary.withOpacity(0.2))),
                          onPressed: () async {
                            await authProvider.advanceSettingsValus();
                            if (!mounted) return;
                          },
                          child: authProvider.isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  'Save',
                                  style: GoogleFonts.nunito(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class ValueBox extends StatelessWidget {
  const ValueBox({super.key, required this.value});
  final value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 7),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: cglasscolor, width: 1)),
      child: Text(
        value.toString(),
        style: GoogleFonts.nunito(
            color: Colors.white30, fontWeight: FontWeight.w500),
      ),
    );
  }
}
