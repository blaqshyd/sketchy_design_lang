import 'package:flutter/widgets.dart';
import 'package:sketchy_design_lang/sketchy_design_lang.dart';

import '../models/chat_models.dart';
import '../models/mock_data.dart';
import '../widgets/chat_main_area.dart';
import '../widgets/chat_sidebar.dart';
import '../widgets/settings_drawer.dart';

/// The main chat page with responsive layout.
class ChatPage extends StatefulWidget {
  /// Creates a chat page.
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String _selectedChannelId = 'session';
  ChatParticipant _currentUser = MockData.currentUser;
  final _drawerController = SketchyDrawerController();
  bool _showMobileSidebar = false;

  ChatChannel get _selectedChannel =>
      MockData.channels.firstWhere((c) => c.id == _selectedChannelId);

  void _onChannelSelected(String channelId) {
    setState(() {
      _selectedChannelId = channelId;
      _showMobileSidebar = false;
    });
  }

  void _onSettingsPressed() {
    _drawerController.open();
  }

  void _onUserUpdated(ChatParticipant user) {
    setState(() => _currentUser = user);
  }

  @override
  void dispose() {
    _drawerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SketchyTheme.consumer(
    builder: (context, theme) => LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 768;

        Widget content;
        if (isWide) {
          // Wide layout: unified structure with full-width dividers
          content = ColoredBox(
            color: theme.paperColor,
            child: Column(
              children: [
                // Header row spanning both panels
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        width: 280,
                        child: ChatSidebarHeader(
                          onSettingsPressed: _onSettingsPressed,
                        ),
                      ),
                      _buildVerticalDivider(theme),
                      Expanded(
                        child: ChatMainAreaHeader(channel: _selectedChannel),
                      ),
                    ],
                  ),
                ),
                // Full-width divider
                const SketchyDivider(),
                // Content row
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        width: 280,
                        child: ChatSidebarContent(
                          selectedChannelId: _selectedChannelId,
                          onChannelSelected: _onChannelSelected,
                        ),
                      ),
                      _buildVerticalDivider(theme),
                      Expanded(
                        child: ChatMainAreaContent(
                          key: chatMainAreaContentKey,
                          channel: _selectedChannel,
                        ),
                      ),
                    ],
                  ),
                ),
                // Full-width divider
                const SketchyDivider(),
                // Footer row spanning both panels
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        width: 280,
                        child: ChatSidebarFooter(
                          onSettingsPressed: _onSettingsPressed,
                        ),
                      ),
                      _buildVerticalDivider(theme),
                      Expanded(
                        child: ChatMainAreaFooter(channel: _selectedChannel),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          // Narrow layout: sidebar as overlay
          content = Stack(
            children: [
              ChatMainArea(
                channel: _selectedChannel,
                onMenuPressed: () => setState(() => _showMobileSidebar = true),
              ),
              if (_showMobileSidebar) ...[
                // Scrim
                GestureDetector(
                  onTap: () => setState(() => _showMobileSidebar = false),
                  child: const ColoredBox(
                    color: Color(0x66000000),
                    child: SizedBox.expand(),
                  ),
                ),
                // Sidebar
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  width: 280,
                  child: ChatSidebar(
                    selectedChannelId: _selectedChannelId,
                    onChannelSelected: _onChannelSelected,
                    onSettingsPressed: _onSettingsPressed,
                  ),
                ),
              ],
            ],
          );
        }

        return SketchyDrawer(
          controller: _drawerController,
          position: SketchyDrawerPosition.end,
          drawerWidth: 320,
          drawer: SettingsDrawer(
            currentUser: _currentUser,
            onUserUpdated: _onUserUpdated,
            onClose: _drawerController.close,
          ),
          child: content,
        );
      },
    ),
  );

  Widget _buildVerticalDivider(SketchyThemeData theme) =>
      Container(width: 1, color: theme.inkColor.withValues(alpha: 0.2));
}
