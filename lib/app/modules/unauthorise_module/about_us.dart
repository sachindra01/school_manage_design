import 'package:flutter/material.dart';
import 'package:school_management_app/app/common/custom_appbar.dart';
import 'package:school_management_app/app/common/style.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

appBar: defaultAppbar(context,title: const Text('abouts us')),
      body: SingleChildScrollView(
      child:  Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Stack(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 50, left: 20, right: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        15.0,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          padding: const EdgeInsets.all(5.0),
                          decoration: const BoxDecoration(
                         gradient: LinearGradient(
            // colors: [Colors.deepPurple, Colors.purple],
            // begin: Alignment.topCenter,
            // end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(220, 46, 36, 72),
            // Color.fromARGB(255, 230, 149, 45),
            Color.fromARGB(255, 223, 104, 144),
              ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                          ),
                          child: Row(
                            children: const [
                              Expanded(
                                  child: Text(
                                '',
                                style: TextStyle(color: white),
                              )),
                              Text(
                                '',
                                style: TextStyle(
                                    color: white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Wrap(
                            children: List.generate(5, (index) => 
                            expandablePanel(
                              'About us',
                              // faqs[index]['question'], 
                            'Nice place to hangout', 
                              index
                            ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 20, top: 20),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child:  CircleAvatar(
                              radius: 50,
                              backgroundColor: Color(0xff95AFE5),
                              child: Padding(
                                padding: EdgeInsets.all(8), // Border radius
                                child: CircleAvatar(
                                  radius: 45,
                                  backgroundImage:
                                      AssetImage('assets/img/logo.png'),
                                ),
                              ),
                            )
                        ,)
                ),
              ],
            ),
           
          ],
        ),
      ),
    );
  }
  expandablePanel(title,answer, index){
    return Column(
      children: [
        Theme(  
          data: Theme.of(context)
          .copyWith(dividerColor: Colors.transparent,
                    highlightColor: Colors.transparent, 
                    splashColor: Colors.transparent),
          child: ExpansionTile(
            onExpansionChanged: (bool val) {
              // setState(() {
              //   _supportController.isExpanded![index] = val;
              // });
            },
            title: Text(
              title,
         
            ),
            tilePadding : const EdgeInsets.all(0),
            children: const [
              Text('something showilajkjkkf jf jnjnknrjkjehnfjfb  fkjfjierhnfnasskfjksnkjsh')
            ]
          ),
        ),
        const Divider(
          thickness: 1.2,
          color: ltextFieldBorderCol
        ),
      ],
    );
  }

}