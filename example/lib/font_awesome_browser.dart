import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sketchy_design_lang/sketchy_design_lang.dart';

class FontAwesomeBrowserExample extends StatefulWidget {
  const FontAwesomeBrowserExample({super.key});

  static Widget builder(BuildContext context) =>
      const FontAwesomeBrowserExample();

  @override
  State<FontAwesomeBrowserExample> createState() =>
      _FontAwesomeBrowserExampleState();
}

class _FontAwesomeBrowserExampleState extends State<FontAwesomeBrowserExample> {
  double _iconSize = 48;
  String _searchQuery = '';

  // A representative subset of FontAwesome icons for browsing.
  final Map<String, IconData> _icons = {
    'address-book': FontAwesomeIcons.addressBook,
    'address-card': FontAwesomeIcons.addressCard,
    'angry': FontAwesomeIcons.angry,
    'apple': FontAwesomeIcons.apple,
    'arrow-alt-circle-down': FontAwesomeIcons.circleArrowDown,
    'arrow-alt-circle-left': FontAwesomeIcons.circleArrowLeft,
    'arrow-alt-circle-right': FontAwesomeIcons.circleArrowRight,
    'arrow-alt-circle-up': FontAwesomeIcons.circleArrowUp,
    'bell': FontAwesomeIcons.bell,
    'bell-slash': FontAwesomeIcons.bellSlash,
    'bookmark': FontAwesomeIcons.bookmark,
    'building': FontAwesomeIcons.building,
    'calendar': FontAwesomeIcons.calendar,
    'calendar-alt': FontAwesomeIcons.calendarCheck,
    'chart-bar': FontAwesomeIcons.chartBar,
    'check-circle': FontAwesomeIcons.circleCheck,
    'check-square': FontAwesomeIcons.squareCheck,
    'circle': FontAwesomeIcons.circle,
    'clipboard': FontAwesomeIcons.clipboard,
    'clock': FontAwesomeIcons.clock,
    'clone': FontAwesomeIcons.clone,
    'closed-captioning': FontAwesomeIcons.closedCaptioning,
    'comment': FontAwesomeIcons.comment,
    'comment-alt': FontAwesomeIcons.commentDots,
    'comments': FontAwesomeIcons.comments,
    'compass': FontAwesomeIcons.compass,
    'copy': FontAwesomeIcons.copy,
    'copyright': FontAwesomeIcons.copyright,
    'credit-card': FontAwesomeIcons.creditCard,
    'dizzy': FontAwesomeIcons.dizzy,
    'dot-circle': FontAwesomeIcons.circleDot,
    'edit': FontAwesomeIcons.penToSquare,
    'envelope': FontAwesomeIcons.envelope,
    'envelope-open': FontAwesomeIcons.envelopeOpen,
    'eye': FontAwesomeIcons.eye,
    'eye-slash': FontAwesomeIcons.eyeSlash,
    'file': FontAwesomeIcons.file,
    'file-alt': FontAwesomeIcons.fileLines,
    'file-archive': FontAwesomeIcons.fileZipper,
    'file-audio': FontAwesomeIcons.fileAudio,
    'file-code': FontAwesomeIcons.fileCode,
    'file-excel': FontAwesomeIcons.fileExcel,
    'file-image': FontAwesomeIcons.fileImage,
    'file-pdf': FontAwesomeIcons.filePdf,
    'file-powerpoint': FontAwesomeIcons.filePowerpoint,
    'file-video': FontAwesomeIcons.fileVideo,
    'file-word': FontAwesomeIcons.fileWord,
    'flag': FontAwesomeIcons.flag,
    'flushed': FontAwesomeIcons.flushed,
    'folder': FontAwesomeIcons.folder,
    'folder-open': FontAwesomeIcons.folderOpen,
    'frown': FontAwesomeIcons.frown,
    'frown-open': FontAwesomeIcons.faceFrownOpen,
    'futbol': FontAwesomeIcons.futbol,
    'gem': FontAwesomeIcons.gem,
    'grimace': FontAwesomeIcons.grimace,
    'grin': FontAwesomeIcons.grin,
    'grin-alt': FontAwesomeIcons.faceGrinWide,
    'grin-beam': FontAwesomeIcons.grinBeam,
    'grin-beam-sweat': FontAwesomeIcons.grinBeamSweat,
    'grin-hearts': FontAwesomeIcons.grinHearts,
    'grin-squint': FontAwesomeIcons.grinSquint,
    'grin-squint-tears': FontAwesomeIcons.grinSquintTears,
    'grin-stars': FontAwesomeIcons.grinStars,
    'grin-tears': FontAwesomeIcons.grinTears,
    'grin-tongue': FontAwesomeIcons.grinTongue,
    'grin-tongue-squint': FontAwesomeIcons.grinTongueSquint,
    'grin-tongue-wink': FontAwesomeIcons.grinTongueWink,
    'grin-wink': FontAwesomeIcons.grinWink,
    'hand-lizard': FontAwesomeIcons.handLizard,
    'hand-paper': FontAwesomeIcons.hand,
    'hand-peace': FontAwesomeIcons.handPeace,
    'hand-point-down': FontAwesomeIcons.handPointDown,
    'hand-point-left': FontAwesomeIcons.handPointLeft,
    'hand-point-right': FontAwesomeIcons.handPointRight,
    'hand-point-up': FontAwesomeIcons.handPointUp,
    'hand-pointer': FontAwesomeIcons.handPointer,
    'hand-rock': FontAwesomeIcons.handBackFist,
    'hand-scissors': FontAwesomeIcons.handScissors,
    'hand-spock': FontAwesomeIcons.handSpock,
    'handshake': FontAwesomeIcons.handshake,
    'hdd': FontAwesomeIcons.hardDrive,
    'heart': FontAwesomeIcons.heart,
    'hospital': FontAwesomeIcons.hospital,
    'hourglass': FontAwesomeIcons.hourglass,
    'id-badge': FontAwesomeIcons.idBadge,
    'id-card': FontAwesomeIcons.idCard,
    'image': FontAwesomeIcons.image,
    'images': FontAwesomeIcons.images,
    'keyboard': FontAwesomeIcons.keyboard,
    'kiss': FontAwesomeIcons.kiss,
    'kiss-beam': FontAwesomeIcons.kissBeam,
    'kiss-wink-heart': FontAwesomeIcons.kissWinkHeart,
    'laugh': FontAwesomeIcons.laugh,
    'laugh-beam': FontAwesomeIcons.laughBeam,
    'laugh-squint': FontAwesomeIcons.laughSquint,
    'laugh-wink': FontAwesomeIcons.laughWink,
    'lemon': FontAwesomeIcons.lemon,
    'life-ring': FontAwesomeIcons.lifeRing,
    'lightbulb': FontAwesomeIcons.lightbulb,
    'list-alt': FontAwesomeIcons.rectangleList,
    'map': FontAwesomeIcons.map,
    'meh': FontAwesomeIcons.meh,
    'meh-blank': FontAwesomeIcons.faceMehBlank,
    'meh-rolling-eyes': FontAwesomeIcons.mehRollingEyes,
    'minus-square': FontAwesomeIcons.squareMinus,
    'money-bill-alt': FontAwesomeIcons.moneyBill1,
    'moon': FontAwesomeIcons.moon,
    'newspaper': FontAwesomeIcons.newspaper,
    'object-group': FontAwesomeIcons.objectGroup,
    'object-ungroup': FontAwesomeIcons.objectUngroup,
    'paper-plane': FontAwesomeIcons.paperPlane,
    'pause-circle': FontAwesomeIcons.circlePause,
    'play-circle': FontAwesomeIcons.circlePlay,
    'plus-square': FontAwesomeIcons.squarePlus,
    'question-circle': FontAwesomeIcons.circleQuestion,
    'registered': FontAwesomeIcons.registered,
    'sad-cry': FontAwesomeIcons.sadCry,
    'sad-tear': FontAwesomeIcons.sadTear,
    'save': FontAwesomeIcons.floppyDisk,
    'share-square': FontAwesomeIcons.shareFromSquare,
    'smile': FontAwesomeIcons.smile,
    'smile-beam': FontAwesomeIcons.smileBeam,
    'smile-wink': FontAwesomeIcons.smileWink,
    'snowflake': FontAwesomeIcons.snowflake,
    'square': FontAwesomeIcons.square,
    'star': FontAwesomeIcons.star,
    'star-half': FontAwesomeIcons.starHalf,
    'sticky-note': FontAwesomeIcons.noteSticky,
    'stop-circle': FontAwesomeIcons.circleStop,
    'sun': FontAwesomeIcons.sun,
    'surprise': FontAwesomeIcons.surprise,
    'thumbs-down': FontAwesomeIcons.thumbsDown,
    'thumbs-up': FontAwesomeIcons.thumbsUp,
    'times-circle': FontAwesomeIcons.circleXmark,
    'tired': FontAwesomeIcons.tired,
    'trash-alt': FontAwesomeIcons.trashCan,
    'user': FontAwesomeIcons.user,
    'user-circle': FontAwesomeIcons.circleUser,
    'window-close': FontAwesomeIcons.rectangleXmark,
    'window-maximize': FontAwesomeIcons.windowMaximize,
    'window-minimize': FontAwesomeIcons.windowMinimize,
    'window-restore': FontAwesomeIcons.windowRestore,
  };

  @override
  Widget build(BuildContext context) =>
      SketchyTheme.consumer(builder: _buildContent);

  Widget _buildContent(BuildContext context, SketchyThemeData theme) {
    final filteredIcons = _icons.entries
        .where((e) => e.key.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SketchyCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SketchyTextInput(
                labelText: 'Search Icons',
                hintText: 'filter by name...',
                onChanged: (value) => setState(() => _searchQuery = value),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  SketchyText(
                    'Icon Size: ${_iconSize.toInt()}',
                    style: theme.typography.label,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SketchySlider(
                      min: 16,
                      max: 128,
                      divisions: 112 ~/ 8,
                      value: _iconSize,
                      onChanged: (value) => setState(() => _iconSize = value),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: SketchyCard(
            child: filteredIcons.isEmpty
                ? Center(
                    child: SketchyText(
                      'No icons found.',
                      style: theme.typography.body.copyWith(
                        color: theme.mutedColor,
                      ),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: _iconSize * 3.0,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: filteredIcons.length,
                    itemBuilder: (context, index) {
                      final entry = filteredIcons[index];
                      return _IconItem(
                        name: entry.key,
                        icon: entry.value,
                        size: _iconSize,
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}

class _IconItem extends StatelessWidget {
  const _IconItem({required this.name, required this.icon, required this.size});

  final String name;
  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) => SketchyTheme.consumer(
    builder: (context, theme) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: FaIcon(icon, size: size, color: theme.inkColor),
          ),
        ),
        const SizedBox(height: 8),
        SketchyText(
          name,
          style: theme.typography.caption,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

