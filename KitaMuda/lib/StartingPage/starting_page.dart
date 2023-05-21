import 'package:flutter/material.dart';
import 'package:kitamuda/StartingPage/slider.dart';
import 'package:kitamuda/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartingPage extends StatefulWidget {
  @override
  State<StartingPage> createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {
  int _currentPage = 0;
  PageController _controller = PageController();

  List<Widget> _pages = [
    SliderPage(
      image: "assets/images/starting_banner.png",
      title: "Selamat Datang Di Kita Muda Indonesia.",
      description: "Ciptakan Kreatifitas dalam satu genggaman",
    ),
    SliderPage(
      image: "assets/images/starting_banner.png",
      title: "Selamat Datang Di Kita Muda Indonesia",
      description: "Menciptakan Sebuah Kreativitas",
    ),
    SliderPage(
      image: "assets/images/starting_banner.png",
      title: "Selamat Datang Di Kita Muda Indonesia",
      description: "Menciptakan Sebuah Kreativitas",
    ),
    SliderPage(
      image: "assets/images/starting_banner.png",
      title: "Selamat Datang Di Kita Muda Indonesia",
      description: "Menciptakan Sebuah Kreativitas",
    ),
  ];

  _onChange(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  addSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('status', 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 1,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _controller,
                      itemCount: _pages.length,
                      onPageChanged: _onChange,
                      itemBuilder: (context, int index) {
                        return _pages[index];
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(_pages.length, (int index) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: 10,
                      width: (index == _currentPage) ? 20 : 10,
                      margin: EdgeInsets.symmetric(vertical: 32, horizontal: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: (index == _currentPage)
                              ? Color(0xFFFFCE00)
                              : Color(0xFFC4C4C4)),
                    );
                  }),
                ),
                ElevatedButton(
                  onPressed: (_currentPage == (_pages.length - 1)
                      ? () {
                          addSP();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        }
                      : () {
                          _controller.nextPage(
                              duration: Duration(milliseconds: 800),
                              curve: Curves.easeInOut);
                        }),
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFFFFCE00),
                      minimumSize: Size(188, 66),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Text(
                    "Mulai Jelajahi",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 61,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
