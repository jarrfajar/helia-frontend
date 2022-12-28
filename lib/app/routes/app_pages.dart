import 'package:get/get.dart';

import '../modules/bookmar/bindings/bookmar_binding.dart';
import '../modules/bookmar/views/bookmar_view.dart';
import '../modules/confirm_reservasi/bindings/confirm_reservasi_binding.dart';
import '../modules/confirm_reservasi/views/confirm_reservasi_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/my_booking/bindings/my_booking_binding.dart';
import '../modules/my_booking/views/my_booking_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/recently/bindings/recently_binding.dart';
import '../modules/recently/views/recently_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/reservasi/bindings/reservasi_binding.dart';
import '../modules/reservasi/views/reservasi_view.dart';
import '../modules/reviews/bindings/reviews_binding.dart';
import '../modules/reviews/views/reviews_view.dart';
import '../modules/room_booking/bindings/room_booking_binding.dart';
import '../modules/room_booking/views/room_booking_view.dart';
import '../modules/room_detail/bindings/room_detail_binding.dart';
import '../modules/room_detail/views/room_detail_view.dart';
import '../modules/searh/bindings/searh_binding.dart';
import '../modules/searh/views/searh_view.dart';
import '../modules/ticket/bindings/ticket_binding.dart';
import '../modules/ticket/views/ticket_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;
  // static const INITIAL = Routes.SEARH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.RECENTLY,
      page: () => const RecentlyView(),
      binding: RecentlyBinding(),
    ),
    GetPage(
      name: _Paths.BOOKMAR,
      page: () => const BookmarView(),
      binding: BookmarBinding(),
    ),
    GetPage(
      name: _Paths.SEARH,
      page: () => SearhView(),
      binding: SearhBinding(),
    ),
    GetPage(
      name: _Paths.ROOM_DETAIL,
      page: () => RoomDetailView(),
      binding: RoomDetailBinding(),
    ),
    GetPage(
      name: _Paths.ROOM_BOOKING,
      page: () => RoomBookingView(),
      binding: RoomBookingBinding(),
    ),
    GetPage(
      name: _Paths.RESERVASI,
      page: () => ReservasiView(),
      binding: ReservasiBinding(),
    ),
    GetPage(
      name: _Paths.CONFIRM_RESERVASI,
      page: () => ConfirmReservasiView(),
      binding: ConfirmReservasiBinding(),
    ),
    GetPage(
      name: _Paths.TICKET,
      page: () => TicketView(),
      binding: TicketBinding(),
    ),
    GetPage(
      name: _Paths.MY_BOOKING,
      page: () => MyBookingView(),
      binding: MyBookingBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.REVIEWS,
      page: () => ReviewsView(),
      binding: ReviewsBinding(),
    ),
  ];
}
