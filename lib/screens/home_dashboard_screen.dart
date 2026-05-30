import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

import 'library_screen.dart';
import 'scanner_screen.dart';

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: const LinearGradient(
                        colors: [Color(0xff0F4C81), Color(0xff00B4D8)],
                      ),
                    ),
                    child: const Icon(
                      Icons.document_scanner_rounded,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "AariBee\nCamScan AI",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Your Pocket Office. Powered by AI.",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Text(
                "Quick Actions",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ScannerScreen()),
                  );
                },
                child: _buildActionCard(
                  icon: Icons.document_scanner_rounded,
                  title: "Scan Document",
                  subtitle: "HD AI Document Scanner",
                  color: AppTheme.primaryBlue,
                ),
              ),

              const SizedBox(height: 18),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LibraryScreen()),
                  );
                },
                child: _buildActionCard(
                  icon: Icons.folder_rounded,
                  title: "Saved Documents",
                  subtitle: "Local Document Library",
                  color: Colors.green,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.auto_awesome, color: AppTheme.primaryBlue),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        "AI Enhancement engine will automatically improve scan quality, remove shadows and recommend the best filter.",
                        style: TextStyle(color: Colors.white.withValues(
                        alpha: 0.7,
                      )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white.withValues(
              alpha: 0.7,
            ),
            ),
            child: Icon(icon, color: color, size: 34),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.white.withValues(
                  alpha: 0.7,
                )),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.white38),
        ],
      ),
    );
  }
}
