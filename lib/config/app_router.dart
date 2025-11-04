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
      // Splash Screen
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SplashScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),

      // Welcome Screen
      GoRoute(
        path: '/welcome',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const WelcomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),

      // Home Screen (with nested routes)
      GoRoute(
        path: '/home/:userName',
        name: 'home',
        pageBuilder: (context, state) {
          final userName = state.pathParameters['userName']!;
          return CustomTransitionPage(
            key: state.pageKey,
            child: HomeScreen(userName: userName),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
        routes: [
          // Quiz Screen
          GoRoute(
            path: 'quiz',
            name: 'quiz',
            pageBuilder: (context, state) {
              final userName = state.pathParameters['userName']!;
              return CustomTransitionPage(
                key: state.pageKey,
                child: QuizScreen(userName: userName),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              );
            },
          ),

          // Challenge Screen
          GoRoute(
            path: 'challenge',
            name: 'challenge',
            pageBuilder: (context, state) {
              final userName = state.pathParameters['userName']!;
              return CustomTransitionPage(
                key: state.pageKey,
                child: ChallengeScreen(userName: userName),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              );
            },
          ),

          // Score Screen
          GoRoute(
            path: 'score',
            name: 'score',
            pageBuilder: (context, state) {
              final userName = state.pathParameters['userName']!;
              final Map<String, int> scoreData = state.extra as Map<String, int>;

              return CustomTransitionPage(
                key: state.pageKey,
                child: ScoreScreen(
                  score: scoreData['score']!,
                  totalQuestions: scoreData['totalQuestions']!,
                  userName: userName,
                ),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              );
            },
          ),
        ],
      ),
    ],
  );
}
