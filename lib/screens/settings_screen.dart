import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/language.dart';
import '../models/interest_category.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildLanguageSection(context, provider),
              const SizedBox(height: 24),
              _buildCategoriesSection(context, provider),
              const SizedBox(height: 24),
              _buildNotificationSection(context, provider),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLanguageSection(BuildContext context, AppProvider provider) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.language,
                  color: Colors.blue.shade600,
                ),
                const SizedBox(width: 8),
                Text(
                  'Learning Language',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8.0,
              children: Language.values.map((language) {
                final isSelected = provider.selectedLanguage == language;
                return FilterChip(
                  label: Text(language.displayName),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      provider.setSelectedLanguage(language);
                    }
                  },
                  selectedColor: Colors.blue.shade100,
                  checkmarkColor: Colors.blue.shade600,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesSection(BuildContext context, AppProvider provider) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.interests,
                  color: Colors.green.shade600,
                ),
                const SizedBox(width: 8),
                Text(
                  'Interests',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Select topics you\'re interested in:',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8.0,
              children: InterestCategory.values.map((category) {
                final isSelected = provider.selectedCategories.contains(category);
                return FilterChip(
                  label: Text(category.getLocalizedName('en')),
                  selected: isSelected,
                  onSelected: (selected) {
                    final newCategories = List<InterestCategory>.from(provider.selectedCategories);
                    if (selected) {
                      newCategories.add(category);
                    } else {
                      newCategories.remove(category);
                    }
                    if (newCategories.isNotEmpty) {
                      provider.setSelectedCategories(newCategories);
                    }
                  },
                  selectedColor: Colors.green.shade100,
                  checkmarkColor: Colors.green.shade600,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSection(BuildContext context, AppProvider provider) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.notifications,
                  color: Colors.orange.shade600,
                ),
                const SizedBox(width: 8),
                Text(
                  'Daily Notification',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Time: '),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectTime(context, provider),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${provider.notificationHour.toString().padLeft(2, '0')}:${provider.notificationMinute.toString().padLeft(2, '0')}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _selectTime(context, provider),
                  child: const Text('Change'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context, AppProvider provider) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: provider.notificationHour,
        minute: provider.notificationMinute,
      ),
    );

    if (picked != null) {
      provider.setNotificationTime(picked.hour, picked.minute);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Notification time set to ${picked.format(context)}'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }
}
