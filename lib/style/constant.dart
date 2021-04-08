import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kai_mobile_app/style/theme.dart' as Style;

final kHintTextStyle = TextStyle(
  color: Color(0xFFc5c8cf),
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Style.Colors.titleColor,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

const String controlInformation =
    "Уважаемые друзья! мы все любим наш Университет и хотим сделать его еще лучше. Данный раздел поможет нам в этом. Если Вы встретились с проблемой, то не оставайтесь равнодушными, - сделайте фото, укажите место, мы передадим информацию администрации вуза.";

/*МАТПОМ - Заявление на материальную помощь
ПСОБ - Положение о стипендиальном обеспечении
ПВРСТУДОБЩ - Положение внутреннего распорядка в общаге*/
const Map<String, String> docUrls = {
  "МАТПОМ":
      "https://kai.ru/documents/10181/1535551/%D0%97%D0%B0%D1%8F%D0%B2%D0%BB%D0%B5%D0%BD%D0%B8%D0%B5+%D0%BD%D0%B0+%D0%BC%D0%B0%D1%82.+%D0%BF%D0%BE%D0%BC%D0%BE%D1%89%D1%8C+%D0%A0%D0%B5%D0%BA%D1%82%D0%BE%D1%80%D1%83+%D0%9A%D0%9D%D0%98%D0%A2%D0%A3-%D0%9A%D0%90%D0%98.doc/7f7c3dd0-00c5-4b59-890a-128735c28716",
  "ПСОБ":
      "https://kai.ru/documents/131969/0/Prilozhenie_2_7284302_v1.pdf/4605a4b2-5864-46f6-bec3-d29bf970d032",
  "ПВРСТУДОБЩ":
      "https://kai.ru/documents/1459798/9692260/%D0%9F.7.5-8.2.2-0604-2019+%D0%9F%D1%80%D0%B0%D0%B2%D0%B8%D0%BB%D0%B0+%D0%B2%D0%BD%D1%83%D1%82%D1%80%D0%B5%D0%BD%D0%BD%D0%B5%D0%B3%D0%BE+%D1%80%D0%B0%D1%81%D0%BF%D0%BE%D1%80%D1%8F%D0%B4%D0%BA%D0%B0+%D0%B4%D0%BB%D1%8F+%D0%BF%D1%80%D0%BE%D0%B6%D0%B8%D0%B2%D0%B0%D1%8E%D1%89%D0%B8%D1%85+%D0%B2+%D0%BE%D0%B1%D1%89%D0%B5%D0%B6%D0%B8%D1%82%D0%B8%D1%8F%D1%85+%D0%9A%D0%9D%D0%98%D0%A2%D0%A3-%D0%9A%D0%90%D0%98.pdf/7687981a-3063-4fc4-9cf2-a8ad38aba3e2",
  "ПВРСТУД":
      "https://kai.ru/web/otdel-menedzmenta-kacestva/obrazovatel-naa-deatel-nost-?p_p_id=110_INSTANCE_oSBcqhc49bxS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_110_INSTANCE_oSBcqhc49bxS_struts_action=%2Fdocument_library_display%2Fview_file_entry&_110_INSTANCE_oSBcqhc49bxS_redirect=https%3A%2F%2Fportal.kai.ru%2Fweb%2Fotdel-menedzmenta-kacestva%2Fobrazovatel-naa-deatel-nost-%2F-%2Fdocument_library_display%2FoSBcqhc49bxS%2Fview%2F1550807%3F_110_INSTANCE_oSBcqhc49bxS_advancedSearch%3Dfalse%26_110_INSTANCE_oSBcqhc49bxS_cur2%3D2%26_110_INSTANCE_oSBcqhc49bxS_keywords%3D%26_110_INSTANCE_oSBcqhc49bxS_topLink%3Dhome%26p_r_p_564233524_resetCur%3Dfalse%26_110_INSTANCE_oSBcqhc49bxS_delta2%3D20%26_110_INSTANCE_oSBcqhc49bxS_andOperator%3Dtrue&_110_INSTANCE_oSBcqhc49bxS_fileEntryId=1460859",
  "УСТАВ": "https://kai.ru/documents/10181/690262/Устав+КНИТУ-КАИ.pdf",
  "АККРЕД":
      "https://kai.ru/documents/10181/690262/Свидетельство+о+государственной+аккредитации+№2940+от14+ноября+2018г.pdf/bf6e5025-df63-475d-a29c-eea3b2066880"
};

final kBoxDecorationStyle = BoxDecoration(
  borderRadius: BorderRadius.circular(10.0),
);
final kProfileTextStyle = TextStyle(
  color: Style.Colors.standardTextColor,
  //fontWeight: FontWeight.normal,
  fontSize: 18,
  fontFamily: 'OpenSans',
);
final kAppBarTextStyle = TextStyle(
  color: Style.Colors.titleColor,
  fontWeight: FontWeight.normal,
  fontSize: 18,
  fontFamily: 'OpenSans',
);
final kAppBarDisableTextStyle = TextStyle(
  color: Style.Colors.standardTextColor,
  fontWeight: FontWeight.normal,
  fontSize: 15,
  fontFamily: 'OpenSans',
);
final kAppBarEnableTextStyle = TextStyle(
  color: Style.Colors.titleColor,
  fontWeight: FontWeight.normal,
  fontSize: 15,
  fontFamily: 'OpenSans',
);

final kDataTextStyle = TextStyle(
  color: Style.Colors.standardTextColor,
  //
  fontSize: 16,
  fontFamily: 'OpenSans',
);

final kExitStyleText = TextStyle(
  color: Colors.red,
  fontSize: 16,
  fontFamily: 'OpenSans',
);

final kSpanTextStyle = TextStyle(
  color: Style.Colors.titleColor,
  fontSize: 12,
  fontFamily: 'OpenSans',
);
final kServiceMenuItemTextStyle = TextStyle(
  color: Style.Colors.titleColor,
  fontSize: 12,
  fontFamily: 'OpenSans',
);

final kBoxImageBackgroundStyle = BoxDecoration(
  color: Colors.white,
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final kLeftButtonBottomRadius = BorderRadius.only(topLeft: Radius.circular(10));
final kRightButtonBottomRadius =
    BorderRadius.only(topRight: Radius.circular(10));
//Color(0xFF6CA8F1)
