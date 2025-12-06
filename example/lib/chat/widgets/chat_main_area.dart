import 'dart:async';

import 'package:eliza_chat/eliza_chat.dart';
import 'package:flutter/widgets.dart';
import 'package:sketchy_design_lang/sketchy_design_lang.dart';

import '../models/chat_models.dart';
import '../models/mock_data.dart';
import 'chat_input.dart';
import 'chat_message_widget.dart';

/// Shared state for Eliza chat across components.
class ElizaChatState extends InheritedWidget {
  /// Creates an Eliza chat state provider.
  const ElizaChatState({
    required this.messages,
    required this.isElizaTyping,
    required this.onSendMessage,
    required this.scrollController,
    required super.child,
    super.key,
  });

  /// Current messages.
  final List<ChatMessage> messages;

  /// Whether Eliza is currently typing.
  final bool isElizaTyping;

  /// Callback to send a message.
  final ValueChanged<String> onSendMessage;

  /// Scroll controller for the message list.
  final ScrollController scrollController;

  /// Gets the nearest ElizaChatState.
  static ElizaChatState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElizaChatState>()!;

  /// Gets the nearest ElizaChatState or null.
  static ElizaChatState? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElizaChatState>();

  @override
  bool updateShouldNotify(ElizaChatState oldWidget) =>
      messages != oldWidget.messages ||
      isElizaTyping != oldWidget.isElizaTyping;
}

/// The header portion of the main area (channel name and description).
class ChatMainAreaHeader extends StatelessWidget {
  /// Creates a chat main area header.
  const ChatMainAreaHeader({
    required this.channel,
    this.onMenuPressed,
    super.key,
  });

  /// The current channel.
  final ChatChannel channel;

  /// Callback when the menu button is pressed (for mobile).
  final VoidCallback? onMenuPressed;

  @override
  Widget build(BuildContext context) => SketchyTheme.consumer(
    builder: (context, theme) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          if (onMenuPressed != null) ...[
            SketchyIconButton(
              icon: SketchySymbol(
                symbol: SketchySymbols.menu,
                size: 20,
                color: theme.inkColor,
              ),
              onPressed: onMenuPressed,
              iconSize: 32,
            ),
            const SizedBox(width: 8),
          ],
          SketchySymbol(
            symbol: SketchySymbols.hash,
            size: 20,
            color: theme.inkColor,
          ),
          const SizedBox(width: 4),
          SketchyText(
            channel.name,
            style: theme.typography.title.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.inkColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: SketchyText(
              channel.description ?? '',
              style: theme.typography.body.copyWith(
                color: theme.inkColor.withValues(alpha: 0.6),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

/// The content portion of the main area (messages list).
class ChatMainAreaContent extends StatefulWidget {
  /// Creates a chat main area content.
  const ChatMainAreaContent({required this.channel, super.key});

  /// The current channel.
  final ChatChannel channel;

  @override
  State<ChatMainAreaContent> createState() => ChatMainAreaContentState();
}

/// State for the chat main area content - exposed for parent access.
class ChatMainAreaContentState extends State<ChatMainAreaContent> {
  final _scrollController = ScrollController();
  final _eliza = Eliza();
  late List<ChatMessage> _messages;
  bool _isElizaTyping = false;

  @override
  void initState() {
    super.initState();
    _loadMessages();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void didUpdateWidget(covariant ChatMainAreaContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.channel.id != widget.channel.id) {
      _loadMessages();
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    }
  }

  void _loadMessages() {
    _messages = List.from(MockData.getMessagesForChannel(widget.channel.id));
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      unawaited(
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        ),
      );
    }
  }

  /// Sends a message and gets Eliza's response.
  void sendMessage(String text) {
    // Add user's message
    final userMessage = ChatMessage(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      channelId: widget.channel.id,
      senderId: MockData.currentUser.id,
      content: text,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages = [..._messages, userMessage];
      _isElizaTyping = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    // Simulate Eliza "thinking" with a small delay
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;

      // Get Eliza's response
      final response = _eliza.processInput(text);

      if (response != null) {
        final elizaMessage = ChatMessage(
          id: 'eliza_${DateTime.now().millisecondsSinceEpoch}',
          channelId: widget.channel.id,
          senderId: MockData.eliza.id,
          content: response,
          timestamp: DateTime.now(),
        );

        setState(() {
          _messages = [..._messages, elizaMessage];
          _isElizaTyping = false;
        });

        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
      } else {
        // Eliza ended the conversation (user said goodbye)
        final farewellMessage = ChatMessage(
          id: 'eliza_${DateTime.now().millisecondsSinceEpoch}',
          channelId: widget.channel.id,
          senderId: MockData.eliza.id,
          content: _eliza.getFinal(),
          timestamp: DateTime.now(),
        );

        setState(() {
          _messages = [..._messages, farewellMessage];
          _isElizaTyping = false;
        });

        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SketchyTheme.consumer(
    builder: (context, theme) => ElizaChatState(
      messages: _messages,
      isElizaTyping: _isElizaTyping,
      onSendMessage: sendMessage,
      scrollController: _scrollController,
      child: ColoredBox(
        color: theme.paperColor,
        child: ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemCount: _messages.length + (_isElizaTyping ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == _messages.length && _isElizaTyping) {
              // Show typing indicator
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    SketchyAvatar(
                      initials: MockData.eliza.initials,
                      radius: 16,
                      showOnlineIndicator: false,
                    ),
                    const SizedBox(width: 8),
                    SketchyText(
                      'Eliza is thinking...',
                      style: theme.typography.body.copyWith(
                        color: theme.inkColor.withValues(alpha: 0.6),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              );
            }

            final message = _messages[index];
            final isCurrentUser = message.senderId == MockData.currentUser.id;
            return ChatMessageWidget(
              message: message,
              isCurrentUser: isCurrentUser,
            );
          },
        ),
      ),
    ),
  );
}

/// Global key for accessing ChatMainAreaContentState.
final chatMainAreaContentKey = GlobalKey<ChatMainAreaContentState>();

/// The footer portion of the main area (input field).
class ChatMainAreaFooter extends StatefulWidget {
  /// Creates a chat main area footer.
  const ChatMainAreaFooter({required this.channel, super.key});

  /// The current channel.
  final ChatChannel channel;

  @override
  State<ChatMainAreaFooter> createState() => _ChatMainAreaFooterState();
}

class _ChatMainAreaFooterState extends State<ChatMainAreaFooter> {
  final _inputController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _onSubmitted(String text) {
    final state = chatMainAreaContentKey.currentState;
    state?.sendMessage(text);
  }

  @override
  Widget build(BuildContext context) => SketchyTheme.consumer(
    builder: (context, theme) => ColoredBox(
      color: theme.paperColor,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ChatInput(
          controller: _inputController,
          hintText: 'Share your thoughts...',
          onSubmitted: _onSubmitted,
          autofocus: true,
        ),
      ),
    ),
  );
}

/// The main chat area showing messages and input for Eliza therapy sessions.
/// This is the complete widget used for mobile layout.
class ChatMainArea extends StatefulWidget {
  /// Creates a chat main area.
  const ChatMainArea({required this.channel, super.key, this.onMenuPressed});

  /// The current channel.
  final ChatChannel channel;

  /// Callback when the menu button is pressed (for mobile).
  final VoidCallback? onMenuPressed;

  @override
  State<ChatMainArea> createState() => _ChatMainAreaState();
}

class _ChatMainAreaState extends State<ChatMainArea> {
  final _scrollController = ScrollController();
  final _inputController = TextEditingController();
  final _eliza = Eliza();
  late List<ChatMessage> _messages;
  bool _isElizaTyping = false;

  @override
  void initState() {
    super.initState();
    _loadMessages();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void didUpdateWidget(covariant ChatMainArea oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.channel.id != widget.channel.id) {
      _loadMessages();
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    }
  }

  void _loadMessages() {
    _messages = List.from(MockData.getMessagesForChannel(widget.channel.id));
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      unawaited(
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        ),
      );
    }
  }

  void _onSendMessage(String text) {
    // Add user's message
    final userMessage = ChatMessage(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      channelId: widget.channel.id,
      senderId: MockData.currentUser.id,
      content: text,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages = [..._messages, userMessage];
      _isElizaTyping = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    // Simulate Eliza "thinking" with a small delay
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;

      // Get Eliza's response
      final response = _eliza.processInput(text);

      if (response != null) {
        final elizaMessage = ChatMessage(
          id: 'eliza_${DateTime.now().millisecondsSinceEpoch}',
          channelId: widget.channel.id,
          senderId: MockData.eliza.id,
          content: response,
          timestamp: DateTime.now(),
        );

        setState(() {
          _messages = [..._messages, elizaMessage];
          _isElizaTyping = false;
        });

        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
      } else {
        // Eliza ended the conversation (user said goodbye)
        final farewellMessage = ChatMessage(
          id: 'eliza_${DateTime.now().millisecondsSinceEpoch}',
          channelId: widget.channel.id,
          senderId: MockData.eliza.id,
          content: _eliza.getFinal(),
          timestamp: DateTime.now(),
        );

        setState(() {
          _messages = [..._messages, farewellMessage];
          _isElizaTyping = false;
        });

        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SketchyTheme.consumer(
    builder: (context, theme) => ColoredBox(
      color: theme.paperColor,
      child: Column(
        children: [
          // Header
          ChatMainAreaHeader(
            channel: widget.channel,
            onMenuPressed: widget.onMenuPressed,
          ),
          const SketchyDivider(),

          // Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: _messages.length + (_isElizaTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isElizaTyping) {
                  // Show typing indicator
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        SketchyAvatar(
                          initials: MockData.eliza.initials,
                          radius: 16,
                          showOnlineIndicator: false,
                        ),
                        const SizedBox(width: 8),
                        SketchyText(
                          'Eliza is thinking...',
                          style: theme.typography.body.copyWith(
                            color: theme.inkColor.withValues(alpha: 0.6),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final message = _messages[index];
                final isCurrentUser =
                    message.senderId == MockData.currentUser.id;
                return ChatMessageWidget(
                  message: message,
                  isCurrentUser: isCurrentUser,
                );
              },
            ),
          ),

          // Input
          const SketchyDivider(),
          Padding(
            padding: const EdgeInsets.all(12),
            child: ChatInput(
              controller: _inputController,
              hintText: 'Share your thoughts...',
              onSubmitted: _onSendMessage,
              autofocus: true,
            ),
          ),
        ],
      ),
    ),
  );
}
