import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:timetable/blocs/auth_bloc/auth_bloc.dart';
import 'package:timetable/blocs/timetable_cubit/timetable_cubit.dart';
import 'package:timetable/blocs/utils/wait_for_state.dart';
import 'package:timetable/configuration/app_colors.dart';
import 'package:timetable/configuration/configuration.dart';
import 'package:timetable/models/timetable.dart';
import 'package:timetable/models/timetable_color.dart';
import 'package:timetable/router/router.dart';
import 'package:timetable/widgets/timetables/timetable_tile.dart';
import 'package:timetable/utils/extensions/extensions.dart';
import 'package:timetable/screens/add_timetable/add_timetable_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late final QRViewController _qrController;

  @override
  void initState() {
    super.initState();
    context.read<TimetableCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoScaffold(
      body: Scaffold(
        floatingActionButton: const _AddTimetableFloatingButton(),
        backgroundColor: AppColors.greyBackground,
        body: NestedScrollView(
          headerSliverBuilder: (context, _) => [
            CupertinoSliverNavigationBar(
              backgroundColor: AppColors.greyBackground,
              automaticallyImplyLeading: false,
              border: const Border(),
              largeTitle: const Text(
                'Расписания',
              ),
              trailing: GestureDetector(
                onTap: () async {
                  final authBloc = context.read<AuthBloc>();
                  authBloc.add(const AuthLogout());
                  await authBloc.waitFor((state) => !state.isAuthenticated);
                  context.router.replace(const SigninRoute());
                },
                child: const Icon(Icons.logout_outlined),
              ),
            ),
          ],
          body: BlocBuilder<TimetableCubit, TimetableState>(
            builder: (context, state) => _TimetableList(
              timetables: state.timetables,
            ),
          ),
        ),
      ),
    );
  }
}

class _TimetableList extends StatelessWidget {
  final List<Timetable> timetables;

  const _TimetableList({
    Key? key,
    required this.timetables,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: timetables
          .map(
            (timetable) => TimetableTile(
              id: timetable.id,
              title: timetable.title,
              color: timetable.color.materialColor,
              onPressed: () => AutoRouter.of(context).push(
                TimetableRoute(timetableId: timetable.id),
              ),
            ),
          )
          .joinWith(const SizedBox(height: 5)),
    );
  }
}

class _AddTimetableFloatingButton extends StatelessWidget {
  const _AddTimetableFloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400]!,
                blurRadius: 5.0,
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(CupertinoIcons.add),
            onPressed: () => AddTimetablePage.show(context),
          ),
        );
  }
}