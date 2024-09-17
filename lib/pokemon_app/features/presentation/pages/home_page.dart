import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_projects/pokemon_app/core/widgets/background_widget.dart';
import 'package:mini_projects/pokemon_app/features/presentation/pages/game_page.dart';
import 'package:mini_projects/pokemon_app/features/presentation/widgets/home_page/default_home_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundImageWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Pokemon Memory Game"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Choose Game Defficulty",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DefaultHomeTile(
                title: "Easy",
                onTab: () {
                  Navigator.of(context).push(
                    GameScreen.route(
                      context: context,
                      height: 4,
                      width: 5,
                      gameTimer: 60,
                    ),
                  );
                },
              ),
              DefaultHomeTile(
                title: "Medium",
                onTab: () {
                  Navigator.of(context).push(
                    GameScreen.route(
                      context: context,
                      height: 6,
                      width: 5,
                      gameTimer: 75,
                    ),
                  );
                },
              ),
              DefaultHomeTile(
                title: "Hard",
                onTab: () {
                  Navigator.of(context).push(
                    GameScreen.route(
                      context: context,
                      height: 8,
                      width: 5,
                      gameTimer: 90,
                    ),
                  );
                },
              ),
              DefaultHomeTile(
                title: "Exit Game",
                onTab: () async {
                  await ServicesBinding.instance
                      .exitApplication(AppExitType.required);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
