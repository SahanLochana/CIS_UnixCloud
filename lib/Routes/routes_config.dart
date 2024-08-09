import 'package:CIS_UnixCloud/Routes/route_constant.dart';
import 'package:CIS_UnixCloud/core_features/presantation/Pages/admin_board.dart';
import 'package:CIS_UnixCloud/core_features/presantation/Pages/auth_page.dart';
import 'package:CIS_UnixCloud/core_features/presantation/Pages/home_page.dart';
import 'package:CIS_UnixCloud/core_features/presantation/Pages/item_page.dart';
import 'package:CIS_UnixCloud/core_features/presantation/Pages/modules_page.dart';
import 'package:CIS_UnixCloud/core_features/presantation/Pages/pdf_view_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyRouteConfig {
  GoRouter routers = GoRouter(
    routes: [
      // auth page
      // when app start show first page
      GoRoute(
        path: "/",
        name: RouterConstants.authRouteName,
        pageBuilder: (context, state) {
          return const MaterialPage(child: AuthPage());
        },
      ),

      // home page
      GoRoute(
        path: "/home",
        name: RouterConstants.homeRouteName,
        pageBuilder: (context, state) {
          return const MaterialPage(child: HomePage());
        },
      ),

      // module page
      GoRoute(
        path: "/modules",
        name: RouterConstants.modulesRouteName,
        pageBuilder: (context, state) {
          return const MaterialPage(child: ModulePage());
        },
      ),

      // item page
      // pass module id
      GoRoute(
        path: "/items/:moduleId",
        name: RouterConstants.itemsRouteName,
        pageBuilder: (context, state) {
          final mId = state.pathParameters["moduleId"];
          return MaterialPage(
              child: ItemsPage(
            moduleId: mId!,
          ));
        },
      ),
      // pdf view page
      // pass pdf url
      GoRoute(
        path: "/view/:url",
        name: RouterConstants.pdfViewRouteName,
        pageBuilder: (context, state) {
          final url = state.pathParameters["url"];
          return MaterialPage(child: PdfViewPage(url: url!));
        },
      ),

      // admin page
      // pass user id
      GoRoute(
        path: "/admin/:uid",
        name: RouterConstants.adminBoardRouteName,
        pageBuilder: (context, state) {
          final uid = state.pathParameters["uid"];
          return MaterialPage(child: AdminBoard(uid: uid!));
        },
      ),
    ],
  );
}
