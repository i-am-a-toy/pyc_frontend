import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/components/label/default_rounded_label.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultValue),
      child: Column(
        children: [
          // 유저 프로필
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  DefaultRoundedLabel(label: '셀리더'),
                  kHalfHeightSizeBox,
                  Text(
                    '안녕하세요!',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 30.0,
                    ),
                  ),
                  Text(
                    '이우길님',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                ],
              ),
              const CircleAvatar(
                backgroundColor: kSecondaryColor,
                backgroundImage: AssetImage('assets/images/test_user.png'),
                maxRadius: 50,
              ),
            ],
          ),
          kHeightSizeBox,
          //검색
          Container(
            width: double.infinity,
            height: 55.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(500),
              color: const Color(0xffF8F8F8),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultValue,
                ),
                child: TextFormField(
                  cursorColor: kPrimaryColor,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.search_outlined,
                      color: kPrimaryColor,
                      size: 30.0,
                    ),
                    hintText: '셀원을 검색해보세요',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    counterText: '',
                    hintStyle: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          kHeightSizeBox,
          //출석
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 130.0,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultValue / 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kHeightSizeBox,
                          const Text(
                            '2022년 12월 25일',
                            style: TextStyle(
                              color: kTextWhiteColor,
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            '예배 참석 인원',
                            style: TextStyle(
                              color: kTextWhiteColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          kHeightSizeBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text(
                                '100',
                                style: TextStyle(
                                  color: kPointColor,
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.end,
                              ),
                              Text(
                                '/100',
                                style: TextStyle(
                                  color: kTextWhiteColor,
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.end,
                              ),
                              Text(
                                '명',
                                style: TextStyle(
                                  color: kTextWhiteColor,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.end,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                kWidthSizeBox,
                Expanded(
                  child: Container(
                    height: 130.0,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultValue / 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kHeightSizeBox,
                          const Text(
                            '2022년 12월 25일',
                            style: TextStyle(
                              color: kTextWhiteColor,
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            '셀모임 참석 인원',
                            style: TextStyle(
                              color: kTextWhiteColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          kHeightSizeBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text(
                                '5',
                                style: TextStyle(
                                  color: kPointColor,
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.end,
                              ),
                              Text(
                                '/100',
                                style: TextStyle(
                                  color: kTextWhiteColor,
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.end,
                              ),
                              Text(
                                '명',
                                style: TextStyle(
                                  color: kTextWhiteColor,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.end,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          kHeightSizeBox,
          //공자시항
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '공지사항',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                kHalfHeightSizeBox,
                Container(
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.circular(kDefaultValue / 2),
                  ),
                  padding: const EdgeInsets.only(left: kDefaultValue),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: kPrimaryColor,
                            backgroundImage: AssetImage(
                              'assets/images/test_user.png',
                            ),
                            maxRadius: 24.0,
                          ),
                          kWidthSizeBox,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '12월 리더모임 일정안내',
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              kQuarterHeightSizedBox,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    '작성인 | 김은률',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                  kQuarterWidthSizedBox,
                                  Text(
                                    '2일전',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          print('공지사항 디테일로 이동');
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_right_outlined,
                          size: 32.0,
                          color: kPrimaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          kHeightSizeBox,
          //일정안내
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '일정 안내',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                kHalfHeightSizeBox,
                Container(
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.circular(kDefaultValue / 2),
                  ),
                  padding: const EdgeInsets.only(left: kDefaultValue),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: kPrimaryColor,
                            maxRadius: 25.0,
                            child: Icon(Icons.edit_calendar_outlined),
                          ),
                          kWidthSizeBox,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '2022년 12월 연말 전도축제',
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              kQuarterHeightSizedBox,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    '시작일 | 22.12.25',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          print('해당 켈린더로 이동');
                        },
                        icon: const Icon(
                          Icons.keyboard_arrow_right_outlined,
                          size: 32.0,
                          color: kPrimaryColor,
                        ),
                      )
                    ],
                  ),
                ),
                kHalfHeightSizeBox,
                Container(
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.circular(kDefaultValue / 2),
                  ),
                  padding: const EdgeInsets.only(left: kDefaultValue),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: kPrimaryColor,
                            maxRadius: 25.0,
                            child: Icon(Icons.edit_calendar_outlined),
                          ),
                          kWidthSizeBox,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '2022년 12월 연말 전도축제',
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              kQuarterHeightSizedBox,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    '시작일 | 22.12.25',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          print('해당 켈린더로 이동');
                        },
                        icon: const Icon(
                          Icons.keyboard_arrow_right_outlined,
                          size: 32.0,
                          color: kPrimaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          kHeightSizeBox,
          //새친구 소개
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '열방 New Face',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                kHalfHeightSizeBox,
                // CarouselSlider.builder(
                //   itemCount: container.length,
                //   itemBuilder: (context, index, realIndex) {
                //     return container[index];
                //   },
                //   options: CarouselOptions(
                //     height: 180,
                //     scrollDirection: Axis.horizontal,
                //     initialPage: 0,
                //     enlargeCenterPage: false,
                //     padEnds: false,
                //     // enableInfiniteScroll: false,
                //     // enableInfiniteScroll: false,
                //   ),
                // ),
                CarouselSlider(
                  items: [
                    Container(
                      color: Colors.white,
                      child: Container(
                          margin: const EdgeInsets.only(
                            right: kDefaultValue,
                          ),
                          padding: const EdgeInsets.all(kDefaultValue),
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(
                              kDefaultValue / 2,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 70.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor: kSecondaryColor,
                                      backgroundImage: AssetImage(
                                        'assets/images/test_user.png',
                                      ),
                                      maxRadius: 35.0,
                                    ),
                                    kHalfWidthSizedBox,
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '이재경',
                                          style: TextStyle(
                                            color: kTextWhiteColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        Text(
                                          '2022-12-25 첫방문',
                                          style: TextStyle(
                                            color: kTextWhiteColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 60.0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: kDefaultValue,
                                  ),
                                  decoration: BoxDecoration(
                                    color: kSecondaryColor,
                                    borderRadius: BorderRadius.circular(
                                      kDefaultValue / 2,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Text(
                                        '새친구팀 만남',
                                        style: TextStyle(
                                          color: kPrimaryColor,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        '2주차',
                                        style: TextStyle(
                                          color: kPrimaryColor,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                  options: CarouselOptions(
                    height: 190.0,
                    padEnds: false,
                  ),
                ),
                kHeightSizeBox,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
