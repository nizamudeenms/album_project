import 'package:album_project/presentation/screens/album_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/service_locator.dart';
import 'presentation/blocs/album_blocs/album_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Albums',
      home: BlocProvider(
        create: (context) => sl<AlbumBloc>()..add(LoadAlbums()),
        child: const AlbumHomeScreen(),
      ),
    );
  }
}
