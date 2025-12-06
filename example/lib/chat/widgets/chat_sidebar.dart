import 'package:flutter/widgets.dart';
import 'package:sketchy_design_lang/sketchy_design_lang.dart';

import '../models/mock_data.dart';
import 'channel_tile.dart';
import 'chat_sidebar_section.dart';
import 'user_tile.dart';

/// The header portion of the sidebar (app title).
class ChatSidebarHeader extends StatelessWidget {
  /// Creates a chat sidebar header.
  const ChatSidebarHeader({required this.onSettingsPressed, super.key});

  /// Callback when the settings button is pressed.
  final VoidCallback onSettingsPressed;

  @override
  Widget build(BuildContext context) => SketchyTheme.consumer(
    builder: (context, theme) => Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SketchyText(
                  'Eliza',
                  style: theme.typography.title.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.inkColor,
                  ),
                ),
                SketchyText(
                  'Your Virtual Therapist',
                  style: theme.typography.caption.copyWith(
                    color: theme.inkColor.withValues(alpha: 0.6),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          SketchySymbol(
            symbol: SketchySymbols.bullet,
            size: 12,
            color: theme.primaryColor,
          ),
        ],
      ),
    ),
  );
}

/// The scrollable content portion of the sidebar (topics and therapist info).
class ChatSidebarContent extends StatelessWidget {
  /// Creates a chat sidebar content.
  const ChatSidebarContent({
    required this.selectedChannelId,
    required this.onChannelSelected,
    super.key,
  });

  /// The currently selected channel ID.
  final String selectedChannelId;

  /// Callback when a channel is selected.
  final ValueChanged<String> onChannelSelected;

  @override
  Widget build(BuildContext context) => SketchyTheme.consumer(
    builder: (context, theme) => ColoredBox(
      color: theme.paperColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            // Therapy Channels section
            ChatSidebarSection(
              title: 'Topics',
              children: [
                for (final channel in MockData.channels)
                  ChannelTile(
                    channel: channel,
                    isSelected: channel.id == selectedChannelId,
                    onTap: () => onChannelSelected(channel.id),
                  ),
              ],
            ),

            const SizedBox(height: 16),

            // Eliza info section
            const ChatSidebarSection(
              title: 'Your Therapist',
              children: [
                UserTile(participant: MockData.eliza, mode: UserTileMode.agent),
              ],
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    ),
  );
}

/// The footer portion of the sidebar (current user and settings).
class ChatSidebarFooter extends StatelessWidget {
  /// Creates a chat sidebar footer.
  const ChatSidebarFooter({required this.onSettingsPressed, super.key});

  /// Callback when the settings button is pressed.
  final VoidCallback onSettingsPressed;

  @override
  Widget build(BuildContext context) => SketchyTheme.consumer(
    builder: (context, theme) => Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          const Expanded(
            child: UserTile(
              participant: MockData.currentUser,
              mode: UserTileMode.footer,
            ),
          ),
          SketchyIconButton(
            icon: SketchySymbol(
              symbol: SketchySymbols.gear,
              size: 20,
              color: theme.inkColor.withValues(alpha: 0.6),
            ),
            onPressed: onSettingsPressed,
            iconSize: 32,
          ),
        ],
      ),
    ),
  );
}

/// The complete sidebar for the Eliza Chat app (used in mobile overlay).
class ChatSidebar extends StatelessWidget {
  /// Creates a chat sidebar.
  const ChatSidebar({
    required this.selectedChannelId,
    required this.onChannelSelected,
    required this.onSettingsPressed,
    super.key,
  });

  /// The currently selected channel ID.
  final String selectedChannelId;

  /// Callback when a channel is selected.
  final ValueChanged<String> onChannelSelected;

  /// Callback when the settings button is pressed.
  final VoidCallback onSettingsPressed;

  @override
  Widget build(BuildContext context) => SketchyTheme.consumer(
    builder: (context, theme) => ColoredBox(
      color: theme.paperColor,
      child: Column(
        children: [
          ChatSidebarHeader(onSettingsPressed: onSettingsPressed),
          const SketchyDivider(),
          Expanded(
            child: ChatSidebarContent(
              selectedChannelId: selectedChannelId,
              onChannelSelected: onChannelSelected,
            ),
          ),
          const SketchyDivider(),
          ChatSidebarFooter(onSettingsPressed: onSettingsPressed),
        ],
      ),
    ),
  );
}
