
import '../data/model/language_model.dart';
import 'images.dart';

class AppConstants {
  static const String APP_NAME = 'Base ';
  static const String APP_VERSION = "1.0.0";

  static const String BASE_URL = 'http://timesheet.oceantech.com.vn';
  static const String GET_CONTENTS = '/timesheet/api/v1/reports/staff/page';
  static const String LOGIN_URI = '/timesheet/oauth/token';
  static const String GET_PROJECTS = '/timesheet/api/v1/projects/page';
  static const String POST_TRACKING = '/timesheet/api/v1/reports';
  static const String CHECK_TOKEN = '/timesheet/oauth/check_token'; //query token=

  // Shared Key
  static const String THEME = '6ammart_theme';
  static const String TOKEN = '6ammart_token';
  static const String COUNTRY_CODE = '6ammart_country_code';
  static const String LANGUAGE_CODE = '6ammart_language_code';
  static const String CART_LIST = '6ammart_cart_list';
  static const String USER_PASSWORD = '6ammart_user_password';
  static const String USER_ADDRESS = '6ammart_user_address';
  static const String USER_NUMBER = '6ammart_user_number';
  static const String USER_COUNTRY_CODE = '6ammart_user_country_code';
  static const String NOTIFICATION = '6ammart_notification';
  static const String SEARCH_HISTORY = '6ammart_search_history';
  static const String INTRO = '6ammart_intro';
  static const String NOTIFICATION_COUNT = '6ammart_notification_count';

  static const String TOPIC = 'all_zone_customer';
  static const String ZONE_ID = 'zoneId';
  static const String MODULE_ID = 'moduleId';
  static const String LOCALIZATION_KEY = 'X-localization';


  // Shared Key
  static const String CUSTOMER_COUNTRY_CODE =
      'customer_country_code'; //not in project
  static const String SEARCH_ADDRESS = 'search_address';
  static const String CONFIG = 'config';
  static const String CUSTOMER_NAME = 'customer_name';
  static const String CUSTOMER_NUMBER = 'customer_number';
  static const String CUSTOMER_QR_CODE = 'customer_qr_code';
  static const String SEND_MONEY_SUGGEST_LIST = 'send_money_suggest';
  static const String REQUEST_MONEY_SUGGEST_LIST = 'request_money_suggest';
  static const String RECENT_AGENT_LIST = 'recent_agent_list';

  static const String PENDING = 'pending';
  static const String APPROVED = 'approved';
  static const String DENIED = 'denied';
  static const String CASH_IN = 'cash_in';
  static const String CASH_OUT = 'cash_out';
  static const String SEND_MONEY = 'send_money';
  static const String RECEIVED_MONEY = 'received_money';
  static const String ADMIN_CHARGE = 'admin_charge';
  static const String ADD_MONEY = 'add_money';

  static const int BALANCE_INPUT_LEN = 10;


  // Delivery Tips
  static List<int> tips = [5000, 10000, 20000, 50000];
  static List<String> tipsTitle = ['5.000', '10.000', '20.000', '50.000'];

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.vietnam,
        languageName: 'Việt Nam',
        countryCode: 'VN',
        languageCode: 'vi'),
    LanguageModel(
        imageUrl: Images.english,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
  ];
}
