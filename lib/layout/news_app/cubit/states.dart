abstract class NewsStates{}

class NewsInitialState extends NewsStates{}

class NewsBottomNavState extends NewsStates{}

class NewsLoadingGetBusinessState extends NewsStates{}

class NewsGetBusinessSuccessState extends NewsStates{}

class NewsGetBusinessErorrState extends NewsStates{
  final String erorr;


  NewsGetBusinessErorrState(this.erorr);
}

class NewsLoadingGetSpotsState extends NewsStates{}

class NewsGetSportsSuccessState extends NewsStates{}

class NewsGetSportsErorrState extends NewsStates{
  final String erorr;


  NewsGetSportsErorrState(this.erorr);
}

class NewsLoadingGetScienceState extends NewsStates{}

class NewsGetScienceSuccessState extends NewsStates{}

class NewsGetScienceErorrState extends NewsStates{
  final String erorr;


  NewsGetScienceErorrState(this.erorr);
}


class NewsLoadingGetSearchState extends NewsStates{}

class NewsGetSearchSuccessState extends NewsStates{}

class NewsGetSearchErorrState extends NewsStates{
  final String erorr;


  NewsGetSearchErorrState(this.erorr);
}

class AppChangeModeState extends NewsStates{}
