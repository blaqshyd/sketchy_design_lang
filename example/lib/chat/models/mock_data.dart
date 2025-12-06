import 'chat_models.dart';

/// Mock data for the Eliza Chat example.
class MockData {
  MockData._();

  // ---- Participants ----

  /// The current logged-in user (the patient).
  static const currentUser = ChatParticipant(
    id: 'patient',
    name: 'You',
    type: ParticipantType.human,
    role: 'Patient',
    isOnline: true,
  );

  /// Eliza the therapist.
  static const eliza = ChatParticipant(
    id: 'eliza',
    name: 'Eliza',
    type: ParticipantType.agent,
    role: 'Therapist',
    modelString: 'DOCTOR script (1966)',
    isOnline: true,
  );

  /// All participants.
  static List<ChatParticipant> get allParticipants => [currentUser, eliza];

  /// Get a participant by ID.
  static ChatParticipant? getParticipant(String id) {
    for (final p in allParticipants) {
      if (p.id == id) return p;
    }
    return null;
  }

  // ---- Channels ----

  /// All therapy-themed chat channels.
  static const channels = [
    ChatChannel(
      id: 'session',
      name: 'session',
      description: 'Your private therapy session',
      unreadCount: 0,
    ),
    ChatChannel(
      id: 'feelings',
      name: 'feelings',
      description: 'Explore your emotions',
      unreadCount: 0,
    ),
    ChatChannel(
      id: 'relationships',
      name: 'relationships',
      description: 'Family and interpersonal dynamics',
      unreadCount: 0,
    ),
    ChatChannel(
      id: 'dreams',
      name: 'dreams',
      description: 'Dream analysis and interpretation',
      unreadCount: 0,
    ),
  ];

  // ---- Messages ----

  /// Messages for the #session channel - initial therapy session.
  static final sessionMessages = [
    ChatMessage(
      id: 's1',
      channelId: 'session',
      senderId: 'eliza',
      content: 'Hello. How are you feeling today?',
      timestamp: DateTime(2025, 1, 15, 10, 0),
    ),
    ChatMessage(
      id: 's2',
      channelId: 'session',
      senderId: 'patient',
      content: "I'm feeling a bit anxious about work lately.",
      timestamp: DateTime(2025, 1, 15, 10, 1),
    ),
    ChatMessage(
      id: 's3',
      channelId: 'session',
      senderId: 'eliza',
      content: 'Tell me more about your work.',
      timestamp: DateTime(2025, 1, 15, 10, 2),
    ),
    ChatMessage(
      id: 's4',
      channelId: 'session',
      senderId: 'patient',
      content: "There's a lot of pressure to deliver on deadlines.",
      timestamp: DateTime(2025, 1, 15, 10, 3),
    ),
    ChatMessage(
      id: 's5',
      channelId: 'session',
      senderId: 'eliza',
      content: 'How does that make you feel?',
      timestamp: DateTime(2025, 1, 15, 10, 4),
    ),
  ];

  /// Messages for the #feelings channel.
  static final feelingsMessages = [
    ChatMessage(
      id: 'f1',
      channelId: 'feelings',
      senderId: 'eliza',
      content:
          'This is a safe space to explore your emotions. What would you '
          'like to discuss?',
      timestamp: DateTime(2025, 1, 15, 11, 0),
    ),
  ];

  /// Messages for the #relationships channel.
  static final relationshipsMessages = [
    ChatMessage(
      id: 'r1',
      channelId: 'relationships',
      senderId: 'eliza',
      content: 'Tell me about your family.',
      timestamp: DateTime(2025, 1, 15, 12, 0),
    ),
    ChatMessage(
      id: 'r2',
      channelId: 'relationships',
      senderId: 'patient',
      content: 'My mother has always been very critical of me.',
      timestamp: DateTime(2025, 1, 15, 12, 1),
    ),
    ChatMessage(
      id: 'r3',
      channelId: 'relationships',
      senderId: 'eliza',
      content: 'Tell me more about your mother.',
      timestamp: DateTime(2025, 1, 15, 12, 2),
    ),
  ];

  /// Messages for the #dreams channel.
  static final dreamsMessages = [
    ChatMessage(
      id: 'd1',
      channelId: 'dreams',
      senderId: 'eliza',
      content:
          'Dreams can reveal much about our inner world. Have you had any '
          'dreams you would like to explore?',
      timestamp: DateTime(2025, 1, 15, 14, 0),
    ),
  ];

  /// Get messages for a specific channel.
  static List<ChatMessage> getMessagesForChannel(String channelId) {
    switch (channelId) {
      case 'session':
        return sessionMessages;
      case 'feelings':
        return feelingsMessages;
      case 'relationships':
        return relationshipsMessages;
      case 'dreams':
        return dreamsMessages;
      default:
        return [];
    }
  }
}
