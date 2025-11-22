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
  String _selectedCategory = 'All';

  // Categorized subset of FontAwesome icons.
  final Map<String, Map<String, IconData>> _categories = {
    'Communication': {
      'address-book': FontAwesomeIcons.addressBook,
      'address-card': FontAwesomeIcons.addressCard,
      'bell': FontAwesomeIcons.bell,
      'bell-slash': FontAwesomeIcons.bellSlash,
      'comment': FontAwesomeIcons.comment,
      'comment-alt': FontAwesomeIcons.commentDots,
      'comments': FontAwesomeIcons.comments,
      'envelope': FontAwesomeIcons.envelope,
      'envelope-open': FontAwesomeIcons.envelopeOpen,
      'paper-plane': FontAwesomeIcons.paperPlane,
    },
    'Faces': {
      'angry': FontAwesomeIcons.faceAngry,
      'dizzy': FontAwesomeIcons.faceDizzy,
      'flushed': FontAwesomeIcons.faceFlushed,
      'frown': FontAwesomeIcons.faceFrown,
      'frown-open': FontAwesomeIcons.faceFrownOpen,
      'grimace': FontAwesomeIcons.faceGrimace,
      'grin': FontAwesomeIcons.faceGrin,
      'grin-alt': FontAwesomeIcons.faceGrinWide,
      'grin-beam': FontAwesomeIcons.faceGrinBeam,
      'grin-beam-sweat': FontAwesomeIcons.faceGrinBeamSweat,
      'grin-hearts': FontAwesomeIcons.faceGrinHearts,
      'grin-squint': FontAwesomeIcons.faceGrinSquint,
      'grin-squint-tears': FontAwesomeIcons.faceGrinSquintTears,
      'grin-stars': FontAwesomeIcons.faceGrinStars,
      'grin-tears': FontAwesomeIcons.faceGrinTears,
      'grin-tongue': FontAwesomeIcons.faceGrinTongue,
      'grin-tongue-squint': FontAwesomeIcons.faceGrinTongueSquint,
      'grin-tongue-wink': FontAwesomeIcons.faceGrinTongueWink,
      'grin-wink': FontAwesomeIcons.faceGrinWink,
      'kiss': FontAwesomeIcons.faceKiss,
      'kiss-beam': FontAwesomeIcons.faceKissBeam,
      'kiss-wink-heart': FontAwesomeIcons.faceKissWinkHeart,
      'laugh': FontAwesomeIcons.faceLaugh,
      'laugh-beam': FontAwesomeIcons.faceLaughBeam,
      'laugh-squint': FontAwesomeIcons.faceLaughSquint,
      'laugh-wink': FontAwesomeIcons.faceLaughWink,
      'meh': FontAwesomeIcons.faceMeh,
      'meh-blank': FontAwesomeIcons.faceMehBlank,
      'meh-rolling-eyes': FontAwesomeIcons.faceRollingEyes,
      'sad-cry': FontAwesomeIcons.faceSadCry,
      'sad-tear': FontAwesomeIcons.faceSadTear,
      'smile': FontAwesomeIcons.faceSmile,
      'smile-beam': FontAwesomeIcons.faceSmileBeam,
      'smile-wink': FontAwesomeIcons.faceSmileWink,
      'surprise': FontAwesomeIcons.faceSurprise,
      'tired': FontAwesomeIcons.faceTired,
    },
    'Hands': {
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
      'thumbs-down': FontAwesomeIcons.thumbsDown,
      'thumbs-up': FontAwesomeIcons.thumbsUp,
    },
    'Files': {
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
      'copy': FontAwesomeIcons.copy,
      'clipboard': FontAwesomeIcons.clipboard,
      'folder': FontAwesomeIcons.folder,
      'folder-open': FontAwesomeIcons.folderOpen,
      'save': FontAwesomeIcons.floppyDisk,
      'sticky-note': FontAwesomeIcons.noteSticky,
    },
    'Editor': {
      'edit': FontAwesomeIcons.penToSquare,
      'clone': FontAwesomeIcons.clone,
      'trash-alt': FontAwesomeIcons.trashCan,
      'share-square': FontAwesomeIcons.shareFromSquare,
      'object-group': FontAwesomeIcons.objectGroup,
      'object-ungroup': FontAwesomeIcons.objectUngroup,
      'list-alt': FontAwesomeIcons.rectangleList,
      'image': FontAwesomeIcons.image,
      'images': FontAwesomeIcons.images,
    },
    'Objects': {
      'apple': FontAwesomeIcons.apple,
      'bookmark': FontAwesomeIcons.bookmark,
      'building': FontAwesomeIcons.building,
      'calendar': FontAwesomeIcons.calendar,
      'calendar-alt': FontAwesomeIcons.calendarCheck,
      'chart-bar': FontAwesomeIcons.chartBar,
      'clock': FontAwesomeIcons.clock,
      'compass': FontAwesomeIcons.compass,
      'copyright': FontAwesomeIcons.copyright,
      'credit-card': FontAwesomeIcons.creditCard,
      'flag': FontAwesomeIcons.flag,
      'futbol': FontAwesomeIcons.futbol,
      'gem': FontAwesomeIcons.gem,
      'hdd': FontAwesomeIcons.hardDrive,
      'heart': FontAwesomeIcons.heart,
      'hospital': FontAwesomeIcons.hospital,
      'hourglass': FontAwesomeIcons.hourglass,
      'id-badge': FontAwesomeIcons.idBadge,
      'id-card': FontAwesomeIcons.idCard,
      'keyboard': FontAwesomeIcons.keyboard,
      'lemon': FontAwesomeIcons.lemon,
      'life-ring': FontAwesomeIcons.lifeRing,
      'lightbulb': FontAwesomeIcons.lightbulb,
      'map': FontAwesomeIcons.map,
      'money-bill-alt': FontAwesomeIcons.moneyBill1,
      'moon': FontAwesomeIcons.moon,
      'newspaper': FontAwesomeIcons.newspaper,
      'registered': FontAwesomeIcons.registered,
      'snowflake': FontAwesomeIcons.snowflake,
      'sun': FontAwesomeIcons.sun,
      'user': FontAwesomeIcons.user,
    },
    'Arrows': {
      'arrow-alt-circle-down': FontAwesomeIcons.circleArrowDown,
      'arrow-alt-circle-left': FontAwesomeIcons.circleArrowLeft,
      'arrow-alt-circle-right': FontAwesomeIcons.circleArrowRight,
      'arrow-alt-circle-up': FontAwesomeIcons.circleArrowUp,
    },
    'Shapes': {
      'check-circle': FontAwesomeIcons.circleCheck,
      'check-square': FontAwesomeIcons.squareCheck,
      'circle': FontAwesomeIcons.circle,
      'closed-captioning': FontAwesomeIcons.closedCaptioning,
      'dot-circle': FontAwesomeIcons.circleDot,
      'eye': FontAwesomeIcons.eye,
      'eye-slash': FontAwesomeIcons.eyeSlash,
      'minus-square': FontAwesomeIcons.squareMinus,
      'pause-circle': FontAwesomeIcons.circlePause,
      'play-circle': FontAwesomeIcons.circlePlay,
      'plus-square': FontAwesomeIcons.squarePlus,
      'question-circle': FontAwesomeIcons.circleQuestion,
      'square': FontAwesomeIcons.square,
      'star': FontAwesomeIcons.star,
      'star-half': FontAwesomeIcons.starHalf,
      'stop-circle': FontAwesomeIcons.circleStop,
      'times-circle': FontAwesomeIcons.circleXmark,
      'user-circle': FontAwesomeIcons.circleUser,
      'window-close': FontAwesomeIcons.rectangleXmark,
      'window-maximize': FontAwesomeIcons.windowMaximize,
      'window-minimize': FontAwesomeIcons.windowMinimize,
      'window-restore': FontAwesomeIcons.windowRestore,
    },
  };

  Map<String, IconData> get _filteredIcons {
    final Map<String, IconData> candidates;
    if (_selectedCategory == 'All') {
      candidates = {};
      _categories.values.forEach(candidates.addAll);
    } else {
      candidates = _categories[_selectedCategory] ?? {};
    }

    if (_searchQuery.isEmpty) return candidates;

    return Map.fromEntries(
      candidates.entries.where(
        (e) => e.key.toLowerCase().contains(_searchQuery.toLowerCase()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) =>
      SketchyTheme.consumer(builder: _buildContent);

  Widget _buildContent(BuildContext context, SketchyThemeData theme) {
    final filteredIcons = _filteredIcons.entries.toList();
    final categoryKeys = ['All', ..._categories.keys];

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
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryKeys.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final category = categoryKeys[index];
                    final isSelected = category == _selectedCategory;
                    return SketchyChip.choice(
                      label: category,
                      selected: isSelected,
                      onSelected: () =>
                          setState(() => _selectedCategory = category),
                    );
                  },
                ),
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
