import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkMode = true;
  bool autoEnhance = true;
  String exportQuality = "HD";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Appearance",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          SwitchListTile(
            value: darkMode,
            title: const Text("Dark Mode"),
            subtitle: const Text(
              "Enable premium dark theme",
            ),
            onChanged: (value) {
              setState(() {
                darkMode = value;
              });
            },
          ),

          const Divider(),

          const SizedBox(height: 12),

          const Text(
            "Scanner Settings",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          SwitchListTile(
            value: autoEnhance,
            title: const Text(
              "AI Auto Enhancement",
            ),
            subtitle: const Text(
              "Automatically improve scans",
            ),
            onChanged: (value) {
              setState(() {
                autoEnhance = value;
              });
            },
          ),

          const SizedBox(height: 12),

          ListTile(
            title: const Text(
              "Export Quality",
            ),
            subtitle: Text(
              exportQuality,
            ),
            trailing: DropdownButton<String>(
              value: exportQuality,
              items: ["Low", "Medium", "HD"]
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  exportQuality = value!;
                });
              },
            ),
          ),

          const Divider(),

          const SizedBox(height: 20),

          ListTile(
            leading: const Icon(
              Icons.info_outline,
            ),
            title: const Text(
              "About",
            ),
            subtitle: const Text(
              "About AariBee CamScan AI",
            ),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "AariBee CamScan AI",
                applicationVersion: "1.0.0",
                applicationLegalese:
                    "Developed by Zafar Ali Soomro",
              );
            },
          ),

          ListTile(
            leading: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            title: const Text(
              "Support Development ❤️",
            ),
            subtitle: const Text(
              "Help keep AariBee CamScan AI free",
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Text(
                      "Support Development",
                    ),
                    content: const Text(
                      "BankIslami\n"
                      "03XXXXXXXXXX\n\n"
                      "JazzCash\n"
                      "03XXXXXXXXXX",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Close",
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),

          const Divider(),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xff121A2A),
            ),
            child: const Column(
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: Color(0xff00B4D8),
                  size: 50,
                ),
                SizedBox(height: 12),
                Text(
                  "AariBee CamScan AI",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Version 1.0.0",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}