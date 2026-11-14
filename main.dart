import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const StudyRoomsApp());

// ============================================================
// THEME
// ============================================================
const kPink = Color(0xFFFFC2E2);
const kPinkDark = Color(0xFFD26AA5);
const kPinkSoft = Color(0xFFFFE4F3);
const kLilac = Color(0xFFE9B9F5);
const kInk = Color(0xFF6B3A5C);
const kRoomTile = Color(0xFFD28BB8);
const noteColors = [
  Color(0xFFFFD6EC),
  Color(0xFFFFF0B3),
  Color(0xFFD9F7E4),
  Color(0xFFD9E8FF),
];

class StudyRoomsApp extends StatelessWidget {
  const StudyRoomsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Rooms',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: kPinkDark, surface: kPinkSoft),
        scaffoldBackgroundColor: kPinkSoft,
        appBarTheme: const AppBarTheme(
          backgroundColor: kPinkSoft,
          foregroundColor: kInk,
          elevation: 0,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: kPink,
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(fontSize: 12, color: kInk, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      home: const AppShell(),
    );
  }
}

// ============================================================
// MODELS
// ============================================================
enum MethodKind { pomodoro, feynman, activeRecall, spacedRepetition, interleaved, custom }

class StudyMethod {
  const StudyMethod({
    required this.kind,
    required this.name,
    required this.summary,
    required this.details,
    required this.focusMinutes,
    required this.breakMinutes,
    required this.icon,
    required this.color,
  });

  final MethodKind kind;
  final String name;
  final String summary; // short text on the card
  final String details; // full text in the "MORE" sheet
  final int focusMinutes;
  final int breakMinutes;
  final IconData icon;
  final Color color;
}

const studyMethods = <StudyMethod>[
  StudyMethod(
    kind: MethodKind.activeRecall,
    name: 'Active Recall',
    summary: 'Close your notes and pull information from memory, then check what you missed.',
    details:
        'Active recall means closing your notes and pulling information out of your memory. Then you check what you got right and what you missed. The effort of retrieving the answer is what makes the memory stick.',
    focusMinutes: 15,
    breakMinutes: 5,
    icon: Icons.psychology_outlined,
    color: Color(0xFFFFD6EC),
  ),
  StudyMethod(
    kind: MethodKind.spacedRepetition,
    name: 'Spaced Repetition',
    summary: 'Review material at increasing gaps so you revisit it just before you would forget.',
    details:
        'Spaced repetition reviews material at increasing intervals, for example after one day, three days, then a week. Each review lands just before you would forget, which keeps the knowledge in long-term memory with less total effort.',
    focusMinutes: 15,
    breakMinutes: 5,
    icon: Icons.replay,
    color: Color(0xFFFFF0B3),
  ),
  StudyMethod(
    kind: MethodKind.feynman,
    name: 'Feynman',
    summary: 'Explain a topic in simple words, as if teaching a child, then fill the gaps you find.',
    details:
        'The Feynman Technique means explaining a topic in simple words, as if you were teaching a child. Where your explanation gets vague or stuck, that is a gap. Go back to your source, fill it, and try again.',
    focusMinutes: 20,
    breakMinutes: 5,
    icon: Icons.lightbulb_outline,
    color: Color(0xFFD9F7E4),
  ),
  StudyMethod(
    kind: MethodKind.pomodoro,
    name: 'Pomodoro',
    summary:
        'The Pomodoro Technique is a time management method that uses 25-minute focused work intervals followed by short breaks.',
    details:
        'Pick one task and set a timer for 25 minutes. Work without switching tasks until it rings. Then take a 5-minute break. After four rounds, take a longer break of 15 to 30 minutes.',
    focusMinutes: 25,
    breakMinutes: 5,
    icon: Icons.timer_outlined,
    color: Color(0xFFD9E8FF),
  ),
  StudyMethod(
    kind: MethodKind.interleaved,
    name: 'Interleaved Practice',
    summary: 'Mix different topics or problem types in one session so your brain learns to tell them apart.',
    details:
        'Interleaved practice mixes different topics or problem types within one session, instead of doing all of one type at a time. It feels harder, but your brain works harder to tell them apart, which improves long-term recall and problem solving.',
    focusMinutes: 20,
    breakMinutes: 5,
    icon: Icons.shuffle,
    color: Color(0xFFE9B9F5),
  ),
  StudyMethod(
    kind: MethodKind.custom,
    name: 'Custom',
    summary: 'Set your own focus and break lengths.',
    details: 'Make your own rhythm. Choose the focus and break lengths that suit how you work.',
    focusMinutes: 30,
    breakMinutes: 10,
    icon: Icons.tune,
    color: Color(0xFFFFDCC8),
  ),
];

StudyMethod byKind(MethodKind k) => studyMethods.firstWhere((m) => m.kind == k);

class Student {
  Student({
    required this.name,
    required this.age,
    required this.education,
    required this.bio,
    required this.emoji,
    required this.color,
    this.isPublic = true,
  });

  String name;
  int age;
  String education;
  String bio;
  bool isPublic;
  final String emoji; // stands in for a profile picture
  final Color color;
}

final me = Student(
  name: 'You',
  age: 19,
  education: 'Computer Science, 2nd year',
  bio: 'Trying to study smarter, not longer ♡',
  emoji: '🎀',
  color: kLilac,
);

final students = <Student>[
  Student(name: 'Claudette', age: 20, education: 'Biology, 2nd year', bio: 'Pomodoro addict. Plants and pastel notes.', emoji: '🌸', color: const Color(0xFFFFD1E8)),
  Student(name: 'Bumbl3bee', age: 18, education: 'Economics, 1st year', bio: 'Teach-back sessions every Sunday ✿', emoji: '🐝', color: const Color(0xFFFFE8A3)),
  Student(name: 'Sn0ppys', age: 21, education: 'History, final year', bio: 'Flashcards until my hands hurt.', emoji: '🍓', color: const Color(0xFFFFC2C2), isPublic: false),
  Student(name: 'Oakberry', age: 19, education: 'Mathematics', bio: 'Interleave everything.', emoji: '🌿', color: const Color(0xFFCDF5D6)),
  Student(name: 'Amanda', age: 22, education: 'Design', bio: 'Pink everything, cozy study vibes.', emoji: '☁️', color: const Color(0xFFE0C8FF)),
  Student(name: 'Mia', age: 20, education: 'Literature', bio: 'Late-night reading club.', emoji: '⭐', color: const Color(0xFFC8E4FF)),
  Student(name: 'Daneen', age: 19, education: 'Pharmacy', bio: 'Active recall with my cat.', emoji: '🐱', color: const Color(0xFFFFDCC8)),
];

class ChatMessage {
  ChatMessage({required this.sender, required this.text, required this.time});
  final Student sender;
  final String text;
  final DateTime time;
}

class StickyNote {
  StickyNote({required this.author, required this.text, required this.position, required this.color});
  final Student author;
  final String text;
  final Color color;
  Offset position;
}

class StudyServer {
  StudyServer({
    required this.name,
    required this.host,
    required this.method,
    required this.focusMinutes,
    required this.breakMinutes,
    List<Student>? members,
  }) : members = members ?? [host];

  final String name;
  final Student host;
  final StudyMethod method;
  final int focusMinutes;
  final int breakMinutes;
  final List<Student> members;
  final List<ChatMessage> messages = [];
  final List<StickyNote> notes = [];
  Student? sharingBy;
}

// Seeded rooms, matching the "active study rooms" list in your design
final rooms = <StudyServer>[
  StudyServer(name: 'pomodoro technique - science', host: students[0], method: byKind(MethodKind.pomodoro), focusMinutes: 25, breakMinutes: 5, members: students.take(6).toList()),
  StudyServer(name: 'feynman technique - economics', host: students[1], method: byKind(MethodKind.feynman), focusMinutes: 20, breakMinutes: 5, members: students.skip(1).take(3).toList()),
  StudyServer(name: 'active recall - history', host: students[2], method: byKind(MethodKind.activeRecall), focusMinutes: 15, breakMinutes: 5, members: students.skip(2).take(2).toList()),
  StudyServer(name: 'interleaved practice - mathematics', host: students[3], method: byKind(MethodKind.interleaved), focusMinutes: 20, breakMinutes: 5, members: students.skip(3).take(5).toList()),
];

// ============================================================
// HELPERS
// ============================================================
double _clamp(double v, double lo, double hi) => v < lo ? lo : (v > hi ? hi : v);

Future<String?> promptText(BuildContext context, String title, String hint, {int maxLines = 1}) {
  final c = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: TextField(
        controller: c,
        autofocus: true,
        maxLines: maxLines,
        decoration: InputDecoration(hintText: hint),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        FilledButton(onPressed: () => Navigator.pop(ctx, c.text), child: const Text('Save')),
      ],
    ),
  );
}

// Shows only PUBLIC info. Private profiles show a lock message.
void showProfile(BuildContext context, Student s) {
  showModalBottomSheet(
    context: context,
    showDragHandle: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
    builder: (_) => Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 32, backgroundColor: s.color, child: Text(s.emoji, style: const TextStyle(fontSize: 28))),
              const SizedBox(width: 16),
              Text(s.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: kInk)),
            ],
          ),
          const SizedBox(height: 20),
          if (s.isPublic) ...[
            _infoRow(Icons.cake_outlined, 'Age', '${s.age}'),
            _infoRow(Icons.school_outlined, 'Education', s.education),
            const SizedBox(height: 8),
            Text(s.bio, style: const TextStyle(color: kInk, height: 1.4)),
          ] else
            const Text('This profile is private 🔒', style: TextStyle(color: kInk)),
        ],
      ),
    ),
  );
}

Widget _infoRow(IconData icon, String label, String value) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: kPinkDark),
          const SizedBox(width: 10),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w600, color: kInk)),
          Expanded(child: Text(value, style: const TextStyle(color: kInk))),
        ],
      ),
    );

// ============================================================
// APP SHELL: bottom navigation with the four tabs
// ============================================================
class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int tab = 0;

  static const titles = ['Study Rooms ♡', 'Study methods', 'Active study rooms', 'About'];

  Future<void> createServer({StudyMethod? method}) async {
    final server = await Navigator.push<StudyServer>(
      context,
      MaterialPageRoute(builder: (_) => CreateServerScreen(initialMethod: method)),
    );
    if (server == null) return;
    setState(() => rooms.insert(0, server));
    await openRoom(server);
  }

  Future<void> openRoom(StudyServer s) async {
    if (!s.members.contains(me)) s.members.add(me);
    await Navigator.push(context, MaterialPageRoute(builder: (_) => ServerRoomScreen(server: s)));
    if (mounted) setState(() {});
  }

  Future<void> editProfile() async {
    await Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen()));
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      HomeTab(
        onExplore: () => setState(() => tab = 1),
        onCreate: () => createServer(),
        onJoin: () => setState(() => tab = 2),
      ),
      MethodsTab(onUse: (m) => createServer(method: m)),
      ServersTab(onOpen: openRoom, onCreate: () => createServer()),
      const AboutTab(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[tab]),
        actions: [
          IconButton(tooltip: 'My profile', icon: const Icon(Icons.person_outline), onPressed: editProfile),
        ],
      ),
      body: IndexedStack(index: tab, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (i) => setState(() => tab = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.auto_stories_outlined), selectedIcon: Icon(Icons.auto_stories), label: 'Methods'),
          NavigationDestination(icon: Icon(Icons.groups_outlined), selectedIcon: Icon(Icons.groups), label: 'Servers'),
          NavigationDestination(icon: Icon(Icons.info_outline), selectedIcon: Icon(Icons.info), label: 'About'),
        ],
      ),
    );
  }
}

// ============================================================
// HOME TAB
// ============================================================
class HomeTab extends StatelessWidget {
  const HomeTab({super.key, required this.onExplore, required this.onCreate, required this.onJoin});
  final VoidCallback onExplore;
  final VoidCallback onCreate;
  final VoidCallback onJoin;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [kPink, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Welcome! ♡', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: kInk)),
              const SizedBox(height: 6),
              const Text(
                'A customizable study website fit for procrastinators!',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: kInk),
              ),
              const SizedBox(height: 8),
              const Text(
                'Discover new methods, learn with friends, and study together with strangers. All in one place.',
                style: TextStyle(fontSize: 13, color: kInk, height: 1.4),
              ),
              const SizedBox(height: 16),
              FilledButton.tonal(
                onPressed: onExplore,
                child: const Text('Explore Study Methods →'),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: onCreate,
                      style: FilledButton.styleFrom(backgroundColor: kPinkDark, foregroundColor: Colors.white),
                      child: const Text('Create Server'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.tonal(
                      onPressed: onJoin,
                      child: const Text('Join Server'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================
// METHODS TAB
// ============================================================
class MethodsTab extends StatelessWidget {
  const MethodsTab({super.key, required this.onUse});
  final ValueChanged<StudyMethod> onUse;

  void _showDetails(BuildContext context, StudyMethod m) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundColor: m.color, child: Icon(m.icon, color: kInk)),
                const SizedBox(width: 12),
                Text(m.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: kInk)),
              ],
            ),
            const SizedBox(height: 16),
            Text(m.details, style: const TextStyle(color: kInk, height: 1.5)),
            const SizedBox(height: 12),
            Text(
              m.kind == MethodKind.custom
                  ? 'You set the timer yourself.'
                  : 'Default timer: ${m.focusMinutes} min focus, ${m.breakMinutes} min break',
              style: TextStyle(color: kInk.withOpacity(.7), fontSize: 12),
            ),
            const SizedBox(height: 20),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: kPinkDark, foregroundColor: Colors.white),
              onPressed: () {
                Navigator.pop(ctx);
                onUse(m);
              },
              child: const Text('Create a server with this method'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Study methods are proven strategies that help you organize, retain, and recall new knowledge. Pick the one that fits how you learn.',
          style: TextStyle(color: kInk, height: 1.4),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.72,
          children: studyMethods.map((m) => _methodCard(context, m)).toList(),
        ),
      ],
    );
  }

  Widget _methodCard(BuildContext context, StudyMethod m) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => _showDetails(context, m),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: m.color,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(m.icon, color: kInk, size: 28),
            const Spacer(),
            Text(m.name, style: const TextStyle(fontWeight: FontWeight.w700, color: kInk)),
            const SizedBox(height: 4),
            Text(
              m.summary,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11, color: kInk, height: 1.3),
            ),
            const SizedBox(height: 6),
            const Text('MORE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: kPinkDark)),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// SERVERS TAB: active study rooms list with search
// ============================================================
class ServersTab extends StatefulWidget {
  const ServersTab({super.key, required this.onOpen, required this.onCreate});
  final ValueChanged<StudyServer> onOpen;
  final VoidCallback onCreate;

  @override
  State<ServersTab> createState() => _ServersTabState();
}

class _ServersTabState extends State<ServersTab> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final q = query.toLowerCase();
    final list = rooms
        .where((r) => r.name.toLowerCase().contains(q) || r.host.name.toLowerCase().contains(q))
        .toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextField(
          onChanged: (v) => setState(() => query = v),
          decoration: InputDecoration(
            hintText: 'Search study rooms',
            prefixIcon: const Icon(Icons.search),
            isDense: true,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Expanded(
              child: Text('Active study rooms',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kPinkDark)),
            ),
            TextButton.icon(
              onPressed: widget.onCreate,
              icon: const Icon(Icons.add, color: kPinkDark),
              label: const Text('New', style: TextStyle(color: kPinkDark)),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ...list.map(_roomTile),
        if (list.isEmpty)
          const Padding(
            padding: EdgeInsets.all(24),
            child: Center(child: Text('No rooms found. Create one!', style: TextStyle(color: kInk))),
          ),
      ],
    );
  }

  Widget _roomTile(StudyServer s) => Card(
        margin: const EdgeInsets.only(bottom: 10),
        color: kRoomTile,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: ListTile(
          onTap: () => widget.onOpen(s),
          leading: Icon(s.method.icon, color: Colors.white),
          title: Text(s.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          subtitle: Text('host: ${s.host.name}', style: const TextStyle(color: Colors.white70, fontSize: 12)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.person_outline, color: Colors.white, size: 18),
              const SizedBox(width: 4),
              Text('${s.members.length}', style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      );
}

// ============================================================
// ABOUT TAB
// ============================================================
class AboutTab extends StatelessWidget {
  const AboutTab({super.key});

  @override
  Widget build(BuildContext context) {
    const steps = [
      ('Pick a method', 'Choose a study method, or make your own timer.'),
      ('Create or join', 'Start a server, or join one that matches your method.'),
      ('Study together', 'Share your screen, chat, and leave notes on the board.'),
      ('Stay focused', 'Your timer runs with the method, so you know when to break.'),
    ];

    final faqs = [
      ('Do I need to be on camera?', 'No. You can join, study, and chat without sharing anything personal.'),
      ('Can I make my profile private?', 'Yes. In My profile, turn off Public profile and only your name will show.'),
      ('Can I change my timer?', 'Yes. Tap the tune icon inside a room to set your own focus and break lengths.'),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('About Study Rooms', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: kInk)),
              SizedBox(height: 8),
              Text(
                'Study Rooms is a place for students to study together. Each room follows a study method that works for its members, so you can focus with people who learn the way you do.',
                style: TextStyle(color: kInk, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text('How it works', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kPinkDark)),
        const SizedBox(height: 8),
        for (var i = 0; i < steps.length; i++)
          Card(
            margin: const EdgeInsets.only(bottom: 8),
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: kPink,
                child: Text('${i + 1}', style: const TextStyle(color: kInk, fontWeight: FontWeight.w700)),
              ),
              title: Text(steps[i].$1, style: const TextStyle(fontWeight: FontWeight.w600, color: kInk)),
              subtitle: Text(steps[i].$2, style: const TextStyle(color: kInk)),
            ),
          ),
        const SizedBox(height: 20),
        const Text('Help', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: kPinkDark)),
        const SizedBox(height: 8),
        for (final f in faqs)
          Card(
            margin: const EdgeInsets.only(bottom: 8),
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ExpansionTile(
              title: Text(f.$1, style: const TextStyle(fontWeight: FontWeight.w600, color: kInk)),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(f.$2, style: const TextStyle(color: kInk, height: 1.4))],
            ),
          ),
      ],
    );
  }
}

// ============================================================
// CREATE SERVER
// ============================================================
class CreateServerScreen extends StatefulWidget {
  const CreateServerScreen({super.key, this.initialMethod});
  final StudyMethod? initialMethod;

  @override
  State<CreateServerScreen> createState() => _CreateServerScreenState();
}

class _CreateServerScreenState extends State<CreateServerScreen> {
  final nameCtrl = TextEditingController();
  late final focusCtrl = TextEditingController();
  late final breakCtrl = TextEditingController();
  late StudyMethod selected;

  @override
  void initState() {
    super.initState();
    selected = widget.initialMethod ?? studyMethods.first;
    _syncTimerFields();
  }

  void _syncTimerFields() {
    focusCtrl.text = '${selected.focusMinutes}';
    breakCtrl.text = '${selected.breakMinutes}';
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    focusCtrl.dispose();
    breakCtrl.dispose();
    super.dispose();
  }

  void create() {
    final name = nameCtrl.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Give your server a name first')));
      return;
    }
    final focus = int.tryParse(focusCtrl.text) ?? selected.focusMinutes;
    final brk = int.tryParse(breakCtrl.text) ?? selected.breakMinutes;
    Navigator.pop(
      context,
      StudyServer(name: name, host: me, method: selected, focusMinutes: focus, breakMinutes: brk),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create a server')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: nameCtrl,
            decoration: const InputDecoration(labelText: 'Server name', hintText: 'e.g. night owls - calculus'),
          ),
          const SizedBox(height: 20),
          const Text('Study method', style: TextStyle(fontWeight: FontWeight.w700, color: kInk)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: studyMethods
                .map((m) => ChoiceChip(
                      label: Text(m.name),
                      avatar: Icon(m.icon, size: 18),
                      selected: selected == m,
                      onSelected: (_) => setState(() {
                        selected = m;
                        _syncTimerFields();
                      }),
                    ))
                .toList(),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Text(selected.details, style: const TextStyle(color: kInk, height: 1.4)),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: focusCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Focus (min)'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: breakCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Break (min)'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          FilledButton(
            onPressed: create,
            style: FilledButton.styleFrom(
              backgroundColor: kPinkDark,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text('Create server'),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SERVER ROOM
// ============================================================
class ServerRoomScreen extends StatefulWidget {
  const ServerRoomScreen({super.key, required this.server});
  final StudyServer server;

  @override
  State<ServerRoomScreen> createState() => _ServerRoomScreenState();
}

class _ServerRoomScreenState extends State<ServerRoomScreen> {
  // Timer is personal: each student can customise their own.
  late int focusMin;
  late int breakMin;
  bool onBreak = false;
  bool running = false;
  int remaining = 0; // seconds
  int completedFocus = 0;
  Timer? ticker;

  final chatCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    focusMin = widget.server.focusMinutes;
    breakMin = widget.server.breakMinutes;
    remaining = focusMin * 60;
  }

  @override
  void dispose() {
    ticker?.cancel();
    chatCtrl.dispose();
    super.dispose();
  }

  int get totalSeconds => (onBreak ? breakMin : focusMin) * 60;

  // ---------- Timer ----------
  void toggleRun() {
    if (running) {
      ticker?.cancel();
      setState(() => running = false);
      return;
    }
    ticker = Timer.periodic(const Duration(seconds: 1), _tick);
    setState(() => running = true);
  }

  void _tick(Timer _) {
    if (!mounted) return;
    if (remaining > 0) {
      setState(() => remaining--);
      return;
    }
    setState(() {
      if (!onBreak) completedFocus++;
      onBreak = !onBreak;
      remaining = totalSeconds;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(onBreak ? 'Focus done! Time for a break ♡' : 'Break over, back to focus!')),
    );
  }

  void resetTimer() {
    ticker?.cancel();
    setState(() {
      running = false;
      onBreak = false;
      remaining = focusMin * 60;
    });
  }

  Future<void> customizeTimer() async {
    final fCtrl = TextEditingController(text: '$focusMin');
    final bCtrl = TextEditingController(text: '$breakMin');
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('My timer'),
        content: Row(
          children: [
            Expanded(
              child: TextField(
                controller: fCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Focus (min)'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: bCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Break (min)'),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Save')),
        ],
      ),
    );
    if (ok != true) return;
    final nf = int.tryParse(fCtrl.text);
    final nb = int.tryParse(bCtrl.text);
    if (nf == null || nf <= 0 || nb == null || nb <= 0) return;
    setState(() {
      focusMin = nf;
      breakMin = nb;
    });
    resetTimer();
  }

  // ---------- Sharing ----------
  void toggleShare() {
    final s = widget.server;
    if (s.sharingBy == null) {
      setState(() => s.sharingBy = me);
    } else if (s.sharingBy == me) {
      setState(() => s.sharingBy = null);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${s.sharingBy!.name} is already sharing their screen')),
      );
    }
  }

  // ---------- Notes ----------
  Future<void> addNote(Offset pos) async {
    final text = await promptText(context, 'New note', 'Write something…', maxLines: 3);
    if (text == null || text.trim().isEmpty) return;
    final notes = widget.server.notes;
    setState(() {
      notes.add(StickyNote(
        author: me,
        text: text.trim(),
        position: pos,
        color: noteColors[notes.length % noteColors.length],
      ));
    });
  }

  void deleteNote(StickyNote n) {
    if (n.author != me) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You can only delete your own notes')));
      return;
    }
    setState(() => widget.server.notes.remove(n));
  }

  // ---------- Chat ----------
  void sendMessage() {
    final t = chatCtrl.text.trim();
    if (t.isEmpty) return;
    setState(() => widget.server.messages.add(ChatMessage(sender: me, text: t, time: DateTime.now())));
    chatCtrl.clear();
  }

  void leave() {
    ticker?.cancel();
    final s = widget.server;
    s.members.remove(me);
    if (s.sharingBy == me) s.sharingBy = null;
    Navigator.pop(context);
  }

  // ---------- UI ----------
  @override
  Widget build(BuildContext context) {
    final s = widget.server;
    final sharing = s.sharingBy;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(s.name, style: const TextStyle(fontSize: 16)),
          actions: [
            IconButton(tooltip: 'My timer', icon: const Icon(Icons.tune), onPressed: customizeTimer),
            IconButton(
              tooltip: sharing == me ? 'Stop sharing' : 'Share screen',
              icon: Icon(sharing == me ? Icons.stop_screen_share : Icons.screen_share_outlined),
              onPressed: toggleShare,
            ),
            IconButton(tooltip: 'Leave', icon: const Icon(Icons.logout), onPressed: leave),
          ],
        ),
        body: Column(
          children: [
            _timerCard(s),
            _participants(s),
            const TabBar(
              labelColor: kInk,
              indicatorColor: kPinkDark,
              tabs: [
                Tab(icon: Icon(Icons.dashboard_outlined), text: 'Screen & notes'),
                Tab(icon: Icon(Icons.chat_bubble_outline), text: 'Chat'),
              ],
            ),
            Expanded(child: TabBarView(children: [_screenBoard(s, sharing), _chat(s)])),
          ],
        ),
      ),
    );
  }

  Widget _timerCard(StudyServer s) {
    final m = remaining ~/ 60;
    final sec = remaining % 60;
    final progress = totalSeconds == 0 ? 0.0 : remaining / totalSeconds;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Column(
        children: [
          Text(
            onBreak ? 'Break time ☕' : 'Focus time ✿',
            style: const TextStyle(fontWeight: FontWeight.w700, color: kPinkDark),
          ),
          const SizedBox(height: 8),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 10,
                  backgroundColor: kPinkSoft,
                  color: onBreak ? kLilac : kPinkDark,
                ),
              ),
              Text(
                '${m.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}',
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: kInk),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            s.method.kind == MethodKind.custom ? 'Custom timer' : s.method.summary,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12, color: kInk.withOpacity(.8)),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton.filled(
                onPressed: toggleRun,
                icon: Icon(running ? Icons.pause : Icons.play_arrow),
              ),
              const SizedBox(width: 8),
              IconButton.outlined(onPressed: resetTimer, icon: const Icon(Icons.refresh)),
            ],
          ),
          Text(
            'Focus $focusMin min · Break $breakMin min · Completed $completedFocus',
            style: TextStyle(fontSize: 11, color: kInk.withOpacity(.7)),
          ),
        ],
      ),
    );
  }

  Widget _participants(StudyServer s) {
    final members = s.members;
    return SizedBox(
      height: 92,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Chip(
              avatar: const Icon(Icons.people_alt_outlined, size: 18),
              label: Text('${members.length} people'),
            ),
          ),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: members.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (_, i) {
                final m = members[i];
                return GestureDetector(
                  onTap: () => showProfile(context, m),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: m.color,
                        child: Text(m.emoji, style: const TextStyle(fontSize: 22)),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: 64,
                        child: Text(
                          m == me ? 'You' : m.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 11, color: kInk),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _screenBoard(StudyServer s, Student? sharing) {
    final banner = sharing == null
        ? 'Nobody is sharing right now. Tap the screen icon above to share.'
        : sharing == me
            ? 'You are sharing your screen'
            : '${sharing.name} is sharing their screen';

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(color: kLilac.withOpacity(.4), borderRadius: BorderRadius.circular(14)),
            child: Text(banner, textAlign: TextAlign.center, style: const TextStyle(color: kInk, fontSize: 12)),
          ),
          const SizedBox(height: 4),
          Text(
            'Tap the board to add a note · drag to move · long-press to delete your own',
            textAlign: TextAlign.center,
            style: TextStyle(color: kInk.withOpacity(.6), fontSize: 11),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LayoutBuilder(
                builder: (ctx, c) {
                  final maxX = c.maxWidth - 120;
                  final maxY = c.maxHeight - 90;
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTapUp: (d) => addNote(d.localPosition),
                    child: Container(
                      color: Colors.white,
                      child: Stack(
                        children: [
                          for (final n in s.notes)
                            Positioned(
                              left: n.position.dx,
                              top: n.position.dy,
                              child: GestureDetector(
                                onPanUpdate: (d) => setState(() {
                                  n.position = Offset(
                                    _clamp(n.position.dx + d.delta.dx, 0, maxX),
                                    _clamp(n.position.dy + d.delta.dy, 0, maxY),
                                  );
                                }),
                                onLongPress: () => deleteNote(n),
                                child: NoteCard(note: n),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chat(StudyServer s) {
    final msgs = s.messages;
    return Column(
      children: [
        Expanded(
          child: msgs.isEmpty
              ? const Center(child: Text('No messages yet, say hi ♡', style: TextStyle(color: kInk)))
              : ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.all(12),
                  itemCount: msgs.length,
                  itemBuilder: (_, i) {
                    final m = msgs[msgs.length - 1 - i];
                    final mine = m.sender == me;
                    return Align(
                      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.7),
                        decoration: BoxDecoration(
                          color: mine ? kPinkDark : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!mine)
                              Text(m.sender.name,
                                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: kPinkDark)),
                            Text(m.text, style: TextStyle(color: mine ? Colors.white : kInk)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: chatCtrl,
                  onSubmitted: (_) => sendMessage(),
                  decoration: InputDecoration(
                    hintText: 'Message the room…',
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                  ),
                ),
              ),
              IconButton(onPressed: sendMessage, icon: const Icon(Icons.send, color: kPinkDark)),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================
// NOTE CARD
// ============================================================
class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.note});
  final StickyNote note;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 90,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: note.color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(2, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            note.author == me ? 'You' : note.author.name,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: kInk),
          ),
          const SizedBox(height: 2),
          Expanded(
            child: Text(
              note.text,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, color: kInk),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// EDIT PROFILE
// ============================================================
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final nameCtrl = TextEditingController(text: me.name);
  late final ageCtrl = TextEditingController(text: '${me.age}');
  late final eduCtrl = TextEditingController(text: me.education);
  late final bioCtrl = TextEditingController(text: me.bio);
  late bool isPublic = me.isPublic;

  @override
  void dispose() {
    nameCtrl.dispose();
    ageCtrl.dispose();
    eduCtrl.dispose();
    bioCtrl.dispose();
    super.dispose();
  }

  void save() {
    final name = nameCtrl.text.trim();
    if (name.isNotEmpty) me.name = name;
    me.age = int.tryParse(ageCtrl.text) ?? me.age;
    me.education = eduCtrl.text.trim();
    me.bio = bioCtrl.text.trim();
    me.isPublic = isPublic;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My profile')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: CircleAvatar(
              radius: 44,
              backgroundColor: me.color,
              child: Text(me.emoji, style: const TextStyle(fontSize: 36)),
            ),
          ),
          const SizedBox(height: 20),
          TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Name')),
          const SizedBox(height: 12),
          TextField(
            controller: ageCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Age'),
          ),
          const SizedBox(height: 12),
          TextField(controller: eduCtrl, decoration: const InputDecoration(labelText: 'Education')),
          const SizedBox(height: 12),
          TextField(
            controller: bioCtrl,
            maxLines: 3,
            decoration: const InputDecoration(labelText: 'General description'),
          ),
          const SizedBox(height: 12),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Public profile'),
            subtitle: const Text('Others in your rooms can see your name, age, education and description'),
            value: isPublic,
            activeColor: kPinkDark,
            onChanged: (v) => setState(() => isPublic = v),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: save,
            style: FilledButton.styleFrom(backgroundColor: kPinkDark, foregroundColor: Colors.white),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
