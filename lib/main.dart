import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Calender'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final now = DateTime.now();

  Widget dateItem({String weekDay = '', String normalDay = ''}) {
    return Container(
      height: 80,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.green.shade200,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.grey.shade400,
          width: 1,
        ),
        boxShadow: [BoxShadow(color: Colors.grey.shade400,blurRadius: 5,offset: Offset(2,5),spreadRadius: 2,)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            weekDay,
            style: TextStyle(
              color: Colors.red.shade600,
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            normalDay,
            style: TextStyle(
              color: Colors.brown.shade600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  getDate({
    int index = 0,
    bool isWeekDay = false,
  }) {
    String weekDays = DateFormat('EEEE')
        .format(DateTime(now.year, now.month, now.day + index));
    String nrmlDays =
        DateFormat('d').format(DateTime(now.year, now.month, now.day + index));
    if (isWeekDay)
      return weekDays;
    else
      return nrmlDays;
  }

  String month = '';
  String year = '';
  // final ScrollController _controller = ScrollController();
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  @override
  void initState() {
    month = DateFormat('MMMM').format(DateTime.now());
    year = DateFormat('y').format(DateTime.now());
    itemPositionsListener.itemPositions.addListener((){

    });
    // _controller.addListener(() {
    //   print(_controller.offset);
    // });
    super.initState();
  }


  int yearCounter = 0;

  yearIncr() {
    yearCounter++;
    print('yr_Counter:$yearCounter');
    setState(() {
      year = DateFormat('y').format(
        DateTime.now().add(
          Duration(
            days: 365 * yearCounter,
          ),
        ),
      );
    });
  }

  yearDecr() {
    yearCounter--;
    print('Yr_Counter:$yearCounter');
    setState(() {
      year = DateFormat('y').format(
        DateTime.now().add(
          Duration(
            days: 365 * yearCounter,
          ),
        ),
      );
    });
  }

  int monthCounter = 0;
  int scrollToPos=0;


  monthIncr() {
    monthCounter++;
    print('Counter:$monthCounter');
    int lastday = DateTime(now.year, now.month + monthCounter, 0).day;
    int presentDay = now.day;
    print('1stDay:$presentDay');
    print('LastDay:$lastday');
    scrollToPos=/*scrollToPos+*//*(lastday-presentDay)+*/(monthCounter*30);
    print('scrollToPos:$scrollToPos');
    itemScrollController.scrollTo(
        index:scrollToPos ,
        duration: Duration(seconds: 2),
        curve: Curves.easeInOutCubic,
    );
    setState(() {
      month = DateFormat('MMMM').format(
        DateTime.now().add(
          Duration(
            days: 30 * monthCounter,
          ),
        ),
      );
    });
  }

  monthDecr() {
    monthCounter--;
    print('Counter:$monthCounter');
    int lastday = DateTime(now.year, now.month + monthCounter, 0).day;
    int presentDay = now.day;
    print('1stDay:$presentDay');
    print('LastDay:$lastday');
    scrollToPos=/*scrollToPos+*//*(lastday-presentDay)+*/(monthCounter*30);
    print('scrollToPos:$scrollToPos');
    itemScrollController.scrollTo(
      index:scrollToPos ,
      duration: Duration(seconds: 2),
      curve: Curves.easeInOutCubic,
    );
    setState(() {
      month = DateFormat('MMMM').format(
        DateTime.now().add(
          Duration(
            days: 30 * monthCounter,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade200,
        elevation: 0,
        title: Text(widget.title,style: TextStyle(color: Colors.black87,fontSize: 20,),),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            GestureDetector(onTap: (){
              yearIncr();
            },child: Icon(Icons.upload_outlined,color: Colors.purpleAccent,size: 25,)),
            SizedBox(
              height: 10,
            ),
            Text(year,style: TextStyle(color: Colors.teal,fontSize: 20,shadows: [Shadow(color: Colors.green.shade300,offset: Offset(0,3),blurRadius: 20,)]),),
            SizedBox(
              height: 10,
            ),
            GestureDetector(onTap: (){
              yearDecr();
            },child: Icon(Icons.download_outlined,color: Colors.purpleAccent,size: 25,)),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.blueAccent,
                      size: 25,
                    ),
                    onTap: () {
                      monthDecr();
                    }),
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade800,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Colors.grey.shade400,
                      width: 1.2,
                    ),
                    boxShadow: [BoxShadow(color: Colors.grey.shade400,blurRadius: 5,offset: Offset(2,5),spreadRadius: 2,)],
                  ),
                  child: Center(
                    child: Text(
                      month,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                    onTap: () {
                      monthIncr();
                    },
                    child: Icon(
                      Icons.chevron_right,
                      color: Colors.blueAccent,
                      size: 35,
                    )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 110,
              child: /*ListView.builder(
                controller: _controller,
                itemBuilder: (context, index) =>
                    Padding(
                  padding: EdgeInsets.only(right: 20,top: 7,bottom: 7,),
                  child: dateItem(
                    normalDay: getDate(
                      index: index,
                      isWeekDay: false,
                    ),
                    weekDay: getDate(
                      index: index,
                      isWeekDay: true,
                    ),
                  ),
                ),
                itemCount: 30,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
              )*/ScrollablePositionedList.builder(
                itemCount: 365,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(right: 20,top: 2,bottom: 14,),
                  child: dateItem(
                    normalDay: getDate(
                      index: index,
                      isWeekDay: false,
                    ),
                    weekDay: getDate(
                      index: index,
                      isWeekDay: true,
                    ),
                  ),
                ),
                itemScrollController: itemScrollController,
                itemPositionsListener: itemPositionsListener,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
