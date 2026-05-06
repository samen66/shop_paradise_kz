import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/ai_design_provider.dart';
import '../widgets/analyzing_animation.dart';

class AnalyzingScreen extends ConsumerWidget {
  const AnalyzingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AiDesignState state = ref.watch(aiDesignProvider);
    final String? photoPath = state.photo?.path;

    ref.listen<AiDesignState>(aiDesignProvider, (AiDesignState? prev, AiDesignState next) {
      if (next.status == AnalysisStatus.success && context.mounted) {
        context.go('/ai-design/result');
      }
    });

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          if (photoPath != null)
            Positioned.fill(
              child: kIsWeb
                  ? Image.network(photoPath, fit: BoxFit.cover)
                  : Image.file(File(photoPath), fit: BoxFit.cover),
            )
          else
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Color(0xFF1E1E2E),
                      Color(0xFF0F172A),
                      Color(0xFF2A1B3D),
                    ],
                  ),
                ),
              ),
            ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                color: Colors.black.withValues(alpha: 0.60),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AnalyzingAnimation(
                onFinished: () {
                  if (!context.mounted) {
                    return;
                  }
                  if (ref.read(aiDesignProvider).status == AnalysisStatus.success) {
                    context.go('/ai-design/result');
                    return;
                  }
                  context.go('/ai-design/result');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

