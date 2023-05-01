import 'package:flutter/material.dart';
import 'package:kmi_apps/StartingPage/slider.dart';
import 'package:kmi_apps/home_page.dart';

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
      title: "Selamat Datang Di KMI.",
      description: "Menciptakan Sebuah Kreativitas",
    ),
    SliderPage(
      image: "assets/images/starting_banner.png",
      title: "Selamat Datang Di KMI.",
      description: "Menciptakan Sebuah Kreativitas",
    ),
    SliderPage(
      image: "assets/images/starting_banner.png",
      title: "Selamat Datang Di KMI.",
      description: "Menciptakan Sebuah Kreativitas",
    ),
    SliderPage(
      image: "assets/images/starting_banner.png",
      title: "Selamat Datang Di KMI.",
      description: "Menciptakan Sebuah Kreativitas",
    ),
  ];

  _onChange(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: _controller,
            itemCount: _pages.length,
            onPageChanged: _onChange,
            itemBuilder: (context, int index) {
              return _pages[index];
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(_pages.length, (int index) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: 10,
                    width: (index == _currentPage) ? 20 : 10,
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 32),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: (index == _currentPage)
                            ? Color(0xFFFFCE00)
                            : Color(0xFFC4C4C4)),
                  );
                }),
              ),
              InkWell(
                onTap: (_currentPage == (_pages.length - 1)
                    ? () {
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
                child: Container(
                  height: 66,
                  width: 188,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color(0xFFFFCE00),
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "Mulai Jelajahi",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: 61,
              )
            ],
          )
        ],
      ),
    );
  }
}
