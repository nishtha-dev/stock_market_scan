enum RouteEnum { stockMarketScans, stockCriteriaPage, stockCriteriaDetailsPage }

extension RouteExt on RouteEnum {
  String get toName => name;

  String get toPath {
    switch (this) {
      case RouteEnum.stockCriteriaPage:
        return '/stockCriteriaPage';
      case RouteEnum.stockCriteriaDetailsPage:
        return '/stockCriteriaDetailsPage';
      case RouteEnum.stockMarketScans:
        return '/stockMarketScans';
    }
  }
}
