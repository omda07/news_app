import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/news_app/cubit/states.dart';
import 'package:news/modules/business/business_screen.dart';
import 'package:news/modules/science/science_screen.dart';
import 'package:news/modules/sports/sports_screen.dart';
import 'package:news/network/local/cache_helper.dart';
import 'package:news/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: 'Business'),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),

  ];

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 0) {
      getBusiness();
    }
    if (index == 1) {
      getSports();
    }
    if (index == 2) {
      getScience();
    }
    emit(NewsBottomNavState());
  }

  bool isDark = false;

  void changeAppMode({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
      //print('isDark    $isDark');
    } else {
      isDark = !isDark;
      // print('isDark  $isDark');
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }

    // print(isDark);
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsLoadingGetBusinessState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '21ec5da562414c9e9fb0525d87dbb2e6',
      },
    ).then((value) {
      // print(value.data['articles'][0]['title']);

      business = value.data['articles'];
      //print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((onErorr) {
      // print(onErorr.toString());
      emit(NewsGetBusinessErorrState(onErorr.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsLoadingGetSpotsState());

    if (sports.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '21ec5da562414c9e9fb0525d87dbb2e6',
        },
      ).then((value) {
        // print(value.data['articles'][0]['title']);

        sports = value.data['articles'];
        //print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((onErorr) {
        //print(onErorr.toString());
        emit(NewsGetSportsErorrState(onErorr.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsLoadingGetScienceState());
    if (science.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '21ec5da562414c9e9fb0525d87dbb2e6',
        },
      ).then((value) {
        // print(value.data['articles'][0]['title']);

        science = value.data['articles'];
        //print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((onErorr) {
        // print(onErorr.toString());
        emit(NewsGetScienceErorrState(onErorr.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsLoadingGetSearchState());
    search = [];

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': '21ec5da562414c9e9fb0525d87dbb2e6',
      },
    ).then((value) {
      // print(value.data['articles'][0]['title']);

      search = value.data['articles'];
      //print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((onErorr) {
      // print(onErorr.toString());
      emit(NewsGetSearchErorrState(onErorr.toString()));
    });
  }
}
