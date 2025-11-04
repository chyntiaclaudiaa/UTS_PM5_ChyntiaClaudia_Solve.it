import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'package:uts_pm5_slove_it/screens/splash_screen.dart';
import 'package:uts_pm5_slove_it/screens/welcome_screen.dart';
import 'package:uts_pm5_slove_it/screens/home_screen.dart';
import 'package:uts_pm5_slove_it/screens/quiz_screen.dart';
import 'package:uts_pm5_slove_it/screens/challenge_screen.dart';
import 'package:uts_pm5_slove_it/screens/score_screen.dart';

class AppRouter {

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/home/:userName',
        name: 'home',
        builder: (context, state) {
          final userName = state.pathParameters['userName']!;
          return HomeScreen(userName: userName);
        },
        routes: [
          GoRoute(
            path: 'quiz',
            name: 'quiz',
            builder: (context, state) {
              final userName = state.pathParameters['userName']!;
              return QuizScreen(userName: userName);
            },
          ),
          GoRoute(
            path: 'challenge',
            name: 'challenge',
            builder: (context, state) {
              final userName = state.pathParameters['userName']!;
              return ChallengeScreen(userName: userName);
            },
          ),
          GoRoute(
            path: 'score',
            name: 'score',
            builder: (context, state) {
              final userName = state.pathParameters['userName']!;
              final Map<String, int> scoreData = state.extra as Map<String, int>;
              return ScoreScreen(
                score: scoreData['score']!,
                totalQuestions: scoreData['totalQuestions']!,
                userName: userName,
              );
            },
          ),
        ],
      ),
    ],
  );
}