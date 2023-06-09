import 'package:chatgpt/providers/auth_provider.dart';
import 'package:chatgpt/screens/settingsScreen/advance_settings_screen.dart';
import 'package:chatgpt/util/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdvanceSettings extends StatefulWidget {
  const AdvanceSettings({super.key});
  // Bool _isExpanded = false;

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
          expansionCallback: (panelIndex, isExpanded){
            authProvider.changeIsExpanded(!isExpanded);
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
                              height: 30,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            Text(
                              "Advance Settings",
                              style: GoogleFonts.nunito(
                                  color:
                                      const Color.fromARGB(255, 212, 211, 211),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        // CustomBackButton(
                        //   onTap: () => {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) =>
                        //                 const AdvanceSettingsScreen()))
                        //   },
                        // ),
                      ],
                    ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Temperature',style: GoogleFonts.nunito(
                      color: Colors.white70,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    const Slider(value: 50,label:'5',max: 100, onChanged: null),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    Text('Temperature',style: GoogleFonts.nunito(
                      color: Colors.white70,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    const Slider(value: 50,label:'5',max: 100, onChanged: null),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    Text('Temperature',style: GoogleFonts.nunito(
                      color: Colors.white70,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    const Slider(value: 50,label:'5',max: 100, onChanged: null),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    Text('Temperature',style: GoogleFonts.nunito(
                      color: Colors.white70,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    const Slider(value: 50,label:'5',max: 100, onChanged: null),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    Text('Temperature',style: GoogleFonts.nunito(
                      color: Colors.white70,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    const Slider(value: 50,label:'5',max: 100, onChanged: null),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    Text('Temperature',style: GoogleFonts.nunito(
                      color: Colors.white70,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    const Slider(value: 50,label:'5',max: 100, onChanged: null),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
