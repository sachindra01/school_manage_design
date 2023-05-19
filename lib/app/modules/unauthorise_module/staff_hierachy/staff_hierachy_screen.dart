import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_management_app/app/common/custom_appbar.dart';
import 'package:school_management_app/app/common/style.dart';
import 'package:school_management_app/app/modules/unauthorise_module/staff_hierachy/widget/staff_category.dart';


class StaffDetail extends StatefulWidget {
  const StaffDetail({super.key});

  @override
  State<StaffDetail> createState() => _StaffDetailState();
}

class _StaffDetailState extends State<StaffDetail> {

  List<bool>? isChecked; 
 dynamic  items;
  @override
  void initState() {
    super.initState();
    items = List<String>.generate(5, (i) => "Item $i");
    isChecked= List<bool>.filled(items.length, false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar(
        context,
        title: const Text(
          'Staff Hierachy',
          style: TextStyle(
            color:  lWhite, 
            fontSize: 22.0, 
            fontWeight: FontWeight.w700
          ),
        ),
     ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Card(
           elevation: 2.0,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: primaryColor.withOpacity(0.2), width: 1),
                borderRadius: BorderRadius.circular(20.0),
              ),
          child: Container(
               decoration: const BoxDecoration(
              borderRadius:  BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight:  Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
          
            ),
            color: lWhite),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    children: [
                        Container(
                          width:  60,
                          height: 60,
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.r),
                              child: Image.asset(
                                'assets/img/person1.png',
                                height: 40.h,
                                width: 40.w,
                              )
                            ),
                          ),
                        ),
                        Column(
                          children: const [
                            Text(
                              'Managing Director',
                              style: TextStyle(
                                color:  primaryColor, 
                                fontSize: 18.0, 
                                fontWeight: FontWeight.w700
                              ),
                            ),
                             Text(
                              'Message From Director',
                              style: TextStyle(
                                color:  lGrey2, 
                                fontSize: 12.0, 
                                fontWeight: FontWeight.w500
                              ),
                            ),
                    
                    
                          ],
                        )
                    ],
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Theme(
                          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          trailing: const SizedBox(),
                            backgroundColor: lWhite,
                            collapsedBackgroundColor: lWhite,
                            collapsedIconColor: primaryColor,
                            onExpansionChanged: (bool expanded){
                              setState(() {
                               isChecked![index] = expanded;
                              });
                            },
                            tilePadding: const EdgeInsets.only(right: 6.0, left: 5.0,top: 0.0),
                            title: Container(
                              height: 40,
                               decoration: BoxDecoration(
                                color: lGreyish,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: lGrey),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'ACADEMIC',
                                      style: TextStyle(
                                        color:  primaryColor, 
                                        fontSize: 18.0, 
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                   isChecked![index]==true
                                   ?const Icon(Icons.arrow_drop_up)
                                   :const Icon(Icons.arrow_drop_down)
                                  ],
                                ),
                              ),
                            ),
                            leading: SizedBox(
                              width: 50.0,
                              child: Stack(
                                children: const [
                                  Center(
                                    child: DottedLine(
                                      direction: Axis.vertical,
                                      lineLength: double.infinity,
                                      lineThickness: 2.0,
                                      dashRadius: 100.0,
                                      dashColor: Colors.green,
                                      dashGapLength: 1.0,
                                      dashGapColor: Colors.transparent,
                                      dashGapRadius: 0.0,
                                    ),
                                  ),
                                   Padding(
                                     padding: EdgeInsets.only(left: 35.0),
                                     child: Center(
                                      child: DottedLine(
                                        direction: Axis.horizontal,
                                        lineLength: double.infinity,
                                        lineThickness: 2.0,
                                        dashRadius: 100.0,
                                        dashColor: Colors.green,
                                        dashGapLength: 1.0,
                                        dashGapColor: Colors.transparent,
                                        dashGapRadius: 0.0,
                                      ),
                                                           ),
                                   ),
                                  Center(
                                    child: Icon(Icons.radio_button_checked,color:Colors.green ,)
                                  )
                                ],
                              ),
                            ),
                            children: List.generate(
                              5,
                              ((idx){
                                

                                return SizedBox(
                                height: 50,
                                child: StaffCategoryTile(
                                  image: 'data:image/jpeg;base64,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',
                                  categoryName: 'Codent',
                                  onTap: () {
                                    
                                  },
                                  checkBoxColor:Colors.green,
                                  textColor:primaryColor,
                                  checkBoxBorderCol:Colors.green,     
                                ),
                             );})
                            ),
                            
                          )
                        );
                    },
                     ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


