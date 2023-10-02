class CalendarPredict {
  StatusUser statusUser;
  Top top;
  Bottom bottom;

  CalendarPredict({
    required this.statusUser,
    required this.top,
    required this.bottom,
  });

  CalendarPredict copyWith({
    StatusUser? statusUser,
    Top? top,
    Bottom? bottom,
  }) =>
      CalendarPredict(
        statusUser: statusUser ?? this.statusUser,
        top: top ?? this.top,
        bottom: bottom ?? this.bottom,
      );
}

class StatusUser {
  String status;
  String title;

  StatusUser({
    required this.status,
    required this.title,
  });

  StatusUser copyWith({
    String? status,
    String? title,
  }) =>
      StatusUser(
        status: status ?? this.status,
        title: title ?? this.title,
      );
}

class Bottom {
  ZodiacBottom zodiac;
  InterpretBottom interpret;

  Bottom({
    required this.zodiac,
    required this.interpret,
  });

  Bottom copyWith({
    ZodiacBottom? zodiac,
    InterpretBottom? interpret,
  }) =>
      Bottom(
        zodiac: zodiac ?? this.zodiac,
        interpret: interpret ?? this.interpret,
      );
}

class InterpretBottom {
  String key;
  String title;
  String description;
  String person;

  InterpretBottom({
    required this.key,
    required this.title,
    required this.description,
    required this.person,
  });

  InterpretBottom copyWith({
    String? key,
    String? title,
    String? description,
    String? person,
  }) =>
      InterpretBottom(
        key: key ?? this.key,
        title: title ?? this.title,
        description: description ?? this.description,
        person: person ?? this.person,
      );
}

class ZodiacBottom {
  String key;
  String china;
  String zodiac;
  String elementEn;
  String element;
  String attribute;

  ZodiacBottom({
    required this.key,
    required this.china,
    required this.zodiac,
    required this.elementEn,
    required this.element,
    required this.attribute,
  });

  ZodiacBottom copyWith({
    String? key,
    String? china,
    String? zodiac,
    String? elementEn,
    String? element,
    String? attribute,
  }) =>
      ZodiacBottom(
        key: key ?? this.key,
        china: china ?? this.china,
        zodiac: zodiac ?? this.zodiac,
        elementEn: elementEn ?? this.elementEn,
        element: element ?? this.element,
        attribute: attribute ?? this.attribute,
      );
}

class Top {
  ElementTop element;
  InterpretTop interpret;

  Top({
    required this.element,
    required this.interpret,
  });

  Top copyWith({
    ElementTop? element,
    InterpretTop? interpret,
  }) =>
      Top(
        element: element ?? this.element,
        interpret: interpret ?? this.interpret,
      );
}

class ElementTop {
  String key;
  String china;
  String zodiac;
  String elementEn;
  String element;
  String attribute;

  ElementTop({
    required this.key,
    required this.china,
    required this.zodiac,
    required this.elementEn,
    required this.element,
    required this.attribute,
  });

  ElementTop copyWith({
    String? key,
    String? china,
    String? zodiac,
    String? elementEn,
    String? element,
    String? attribute,
  }) =>
      ElementTop(
        key: key ?? this.key,
        china: china ?? this.china,
        zodiac: zodiac ?? this.zodiac,
        elementEn: elementEn ?? this.elementEn,
        element: element ?? this.element,
        attribute: attribute ?? this.attribute,
      );
}

class InterpretTop {
  String key;
  String title;
  String description;
  String person;

  InterpretTop({
    required this.key,
    required this.title,
    required this.description,
    required this.person,
  });

  InterpretTop copyWith({
    String? key,
    String? title,
    String? description,
    String? person,
  }) =>
      InterpretTop(
        key: key ?? this.key,
        title: title ?? this.title,
        description: description ?? this.description,
        person: person ?? this.person,
      );
}
