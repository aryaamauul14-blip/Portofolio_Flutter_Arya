import 'package:flutter/material.dart';

import 'new_form.dart';
import 'portfolio_data.dart';
import 'portfolio_intro.dart';
import 'portfolio_theme.dart';
import 'portfolio_widgets.dart';
import 'project_art.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final _scrollController = ScrollController();
  final _aboutKey = GlobalKey();
  final _workKey = GlobalKey();
  final _contactKey = GlobalKey();
  String _activeSection = '';
  ProjectKind? _filter;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_trackSection);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _trackSection() {
    var active = '';
    for (final entry in [
      (_workKey, 'Porto'),
      (_aboutKey, 'About Me'),
      (_contactKey, 'Contact'),
    ]) {
      final box = entry.$1.currentContext?.findRenderObject();
      if (box is RenderBox && box.localToGlobal(Offset.zero).dy < 230) {
        active = entry.$2;
      }
    }
    if (active != _activeSection) setState(() => _activeSection = active);
  }

  void _goTo(GlobalKey key) {
    final target = key.currentContext;
    if (target == null) return;
    Scrollable.ensureVisible(
      target,
      duration: motionDuration(context, 650),
      curve: Curves.easeInOutCubic,
    );
  }

  void _goHome() {
    if (MediaQuery.disableAnimationsOf(context)) {
      _scrollController.jumpTo(0);
      return;
    }
    _scrollController.animateTo(
      0,
      duration: motionDuration(context, 650),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final compact =
        MediaQuery.sizeOf(context).width < 900 ||
        MediaQuery.textScalerOf(context).scale(14) > 18;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _navigation(compact),
            Expanded(
              child: SelectionArea(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      ContentWidth(
                        child: Entrance(
                          child: PortfolioIntro(
                            onWork: () => _goTo(_workKey),
                            onContact: () => _goTo(_contactKey),
                          ),
                        ),
                      ),
                      const ToolStrip(),
                      ContentWidth(child: _work()),
                      ContentWidth(child: _about()),
                      ContentWidth(child: _contact()),
                      ContentWidth(child: _footer()),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navigation(bool compact) {
    final links = Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _navLink('About Me', _aboutKey),
        SizedBox(width: compact ? 0 : 12),
        _navLink('Porto', _workKey),
        SizedBox(width: compact ? 0 : 12),
        _navLink('Contact', _contactKey),
      ],
    );
    return Container(
      decoration: const BoxDecoration(
        color: Palette.paper,
        border: Border(bottom: BorderSide(color: Palette.line)),
      ),
      child: ContentWidth(
        child: Column(
          children: [
            SizedBox(
              height: compact ? 66 : 86,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Brand(onTap: _goHome),
                  if (!compact) links,
                  if (compact)
                    IconButton(
                      onPressed: () => _goTo(_contactKey),
                      tooltip: "Let's talk",
                      icon: const Icon(Icons.north_east),
                    )
                  else
                    TextButton.icon(
                      onPressed: () => _goTo(_contactKey),
                      label: const Text("Let's talk"),
                      icon: const Icon(Icons.north_east, size: 16),
                      iconAlignment: IconAlignment.end,
                      style: TextButton.styleFrom(
                        foregroundColor: Palette.blue,
                      ),
                    ),
                ],
              ),
            ),
            if (compact)
              Padding(padding: const EdgeInsets.only(bottom: 8), child: links),
          ],
        ),
      ),
    );
  }

  Widget _navLink(String label, GlobalKey key) => TextButton(
    onPressed: () => _goTo(key),
    style: TextButton.styleFrom(
      backgroundColor: _activeSection == label ? Palette.sky : null,
      foregroundColor: _activeSection == label ? Palette.blue : Palette.muted,
      padding: const EdgeInsets.symmetric(horizontal: 17),
    ),
    child: Text(label),
  );

  Widget _work() {
    final projects =
        portfolioItems
            .where((project) => _filter == null || project.kind == _filter)
            .toList();
    return Padding(
      key: _workKey,
      padding: const EdgeInsets.only(top: 78, bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Eyebrow('Ideas, brought to life'),
          const SizedBox(height: 13),
          LayoutBuilder(
            builder: (context, constraints) {
              final heading = Text(
                'Selected work',
                style: PortfolioTheme.display(
                  constraints.maxWidth < 600 ? 34 : 40,
                ),
              );
              final filters = Wrap(
                spacing: 6,
                runSpacing: 8,
                children: [
                  _filterChip('All work', null),
                  _filterChip('Web', ProjectKind.web),
                  _filterChip('IoT', ProjectKind.iot),
                  _filterChip('Game', ProjectKind.game),
                ],
              );
              if (constraints.maxWidth < 720) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [heading, const SizedBox(height: 24), filters],
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [heading, filters],
              );
            },
          ),
          const SizedBox(height: 12),
          const Text(
            'Different mediums. The same drive to make something useful.',
          ),
          const SizedBox(height: 30),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns =
                  constraints.maxWidth >= 850
                      ? 3
                      : (constraints.maxWidth >= 560 ? 2 : 1);
              final width =
                  (constraints.maxWidth - (columns - 1) * 22) / columns;
              final cards = Align(
                alignment: Alignment.topLeft,
                child: Wrap(
                  spacing: 22,
                  runSpacing: 24,
                  children: [
                    for (final project in projects)
                      SizedBox(
                        width: width,
                        child: _ProjectCard(
                          key: ValueKey(project.kind),
                          project: project,
                          onTap:
                              () => Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder:
                                      (context) => NewForm(project: project),
                                ),
                              ),
                        ),
                      ),
                  ],
                ),
              );
              if (MediaQuery.disableAnimationsOf(context)) return cards;
              return AnimatedSize(
                duration: motionDuration(context, 300),
                alignment: Alignment.topLeft,
                child: cards,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String label, ProjectKind? kind) => ChoiceChip(
    label: Text(label),
    selected: _filter == kind,
    showCheckmark: false,
    onSelected: (_) => setState(() => _filter = kind),
    selectedColor: Palette.ink,
    backgroundColor: Palette.paper,
    side: BorderSide(color: _filter == kind ? Palette.ink : Palette.line),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
    labelStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: _filter == kind ? Palette.white : Palette.muted,
    ),
  );

  Widget _about() => Padding(
    key: _aboutKey,
    padding: const EdgeInsets.only(top: 60, bottom: 86),
    child: LayoutBuilder(
      builder: (context, constraints) {
        final story = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Eyebrow('The person behind the projects'),
            const SizedBox(height: 16),
            Text(
              'A curious mind.\nA builder at heart.',
              style: PortfolioTheme.display(
                constraints.maxWidth < 600 ? 34 : 40,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "I'm Naufal Arya Maulana, an informatics student at Universitas "
              "Paramadina. I like turning a “what if?” into something I can actually build.",
            ),
            const SizedBox(height: 16),
            const Text(
              'From community-focused web apps to connected devices and games, '
              'my projects are how I explore, experiment, and learn. '
              'Away from the screen, you can find me swimming or '
              'getting lost in a good math problem.',
            ),
            const SizedBox(height: 28),
            const Eyebrow('My everyday toolkit'),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 10,
              children: [for (final skill in Profile.skills) Tag(skill)],
            ),
          ],
        );
        final facts = Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Palette.ink,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.fingerprint, color: Palette.water, size: 27),
                  SizedBox(width: 12),
                  Flexible(
                    child: Eyebrow('A little more me', color: Palette.water),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              _fact('BASED IN', 'Jakarta, Indonesia'),
              _fact('STUDYING', 'Teknik Informatika · 2023'),
              _fact('STUDENT ID', '123103124'),
              _fact('HOMETOWN', 'Jakarta Timur'),
              const SizedBox(height: 4),
              const Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Tag('Swimming', dark: true),
                  Tag('Math enthusiast', dark: true),
                  Tag('Vibe coding', dark: true),
                ],
              ),
            ],
          ),
        );
        if (constraints.maxWidth < 720) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [story, const SizedBox(height: 34), facts],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 6, child: story),
            const SizedBox(width: 70),
            Expanded(flex: 5, child: facts),
          ],
        );
      },
    ),
  );

  Widget _fact(String label, String value) => Padding(
    padding: const EdgeInsets.only(bottom: 23),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Palette.water,
            fontSize: 10,
            letterSpacing: 1.3,
          ),
        ),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Palette.white, fontSize: 16)),
      ],
    ),
  );

  Widget _contact() => Padding(
    key: _contactKey,
    padding: const EdgeInsets.only(top: 24),
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.all(MediaQuery.sizeOf(context).width < 600 ? 27 : 52),
      decoration: BoxDecoration(
        color: Palette.sky,
        borderRadius: BorderRadius.circular(26),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final intro = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Eyebrow('Good things start with a conversation'),
              const SizedBox(height: 18),
              Text(
                "Have an idea?\nLet's make it happen.",
                style: PortfolioTheme.display(
                  constraints.maxWidth < 600 ? 32 : 43,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'A project, a collaboration, or just a hello.\n'
                "I'd love to hear from you.",
              ),
              const SizedBox(height: 25),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  FilledButton.icon(
                    onPressed:
                        () => openContact(context, 'mailto:${Profile.email}'),
                    label: const Text('Say hello'),
                    icon: const Icon(Icons.north_east, size: 17),
                    iconAlignment: IconAlignment.end,
                  ),
                  OutlinedButton.icon(
                    onPressed: () => copyContact(context, Profile.email),
                    label: const Text('Copy email'),
                    icon: const Icon(Icons.copy_outlined, size: 16),
                  ),
                ],
              ),
            ],
          );
          final links = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Eyebrow('Find me here'),
              const SizedBox(height: 12),
              _contactLink('GitHub', '@aarz24', Icons.code, Profile.github),
              _contactLink(
                'LinkedIn',
                'Naufal Arya Maulana',
                Icons.work_outline_rounded,
                Profile.linkedIn,
              ),
              _contactLink(
                'Phone',
                Profile.phone,
                Icons.call_outlined,
                'tel:+6281292091767',
              ),
              const SizedBox(height: 14),
              const SelectableText(
                Profile.email,
                style: TextStyle(fontSize: 12, color: Palette.muted),
              ),
            ],
          );
          if (constraints.maxWidth < 730) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [intro, const SizedBox(height: 40), links],
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 6, child: intro),
              const SizedBox(width: 54),
              Expanded(flex: 4, child: links),
            ],
          );
        },
      ),
    ),
  );

  Widget _contactLink(
    String title,
    String subtitle,
    IconData icon,
    String address,
  ) => Container(
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: Palette.line)),
    ),
    child: ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, size: 21, color: Palette.blue),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: const Icon(Icons.north_east, size: 17, color: Palette.ink),
      onTap: () => openContact(context, address),
    ),
  );

  Widget _footer() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 34),
    child: Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 24,
      runSpacing: 12,
      children: [
        Text(
          '© ${DateTime.now().year} Naufal Arya Maulana',
          style: const TextStyle(fontSize: 12),
        ),
        const Text(
          'Made with curiosity & Flutter.',
          style: TextStyle(fontSize: 12),
        ),
        TextButton.icon(
          onPressed: _goHome,
          label: const Text('Back to top', style: TextStyle(fontSize: 12)),
          icon: const Icon(Icons.arrow_upward_rounded, size: 16),
          iconAlignment: IconAlignment.end,
        ),
      ],
    ),
  );
}

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({super.key, required this.project, required this.onTap});
  final PortfolioItem project;
  final VoidCallback onTap;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final active = _hovered || _focused;
    final project = widget.project;
    return AnimatedContainer(
      duration: motionDuration(context),
      transform: Matrix4.translationValues(0, active ? -6 : 0, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: active ? Palette.blue : Palette.line,
          width: 1.5,
        ),
        color: Palette.white,
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Palette.white,
        child: InkWell(
          onTap: widget.onTap,
          onHover: (value) => setState(() => _hovered = value),
          onFocusChange: (value) => setState(() => _focused = value),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(tag: project.kind, child: ProjectArt(project: project)),
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Eyebrow(project.category, color: project.color),
                    const SizedBox(height: 13),
                    ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 55),
                      child: Text(
                        project.title,
                        style: PortfolioTheme.display(21),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      project.subtitle,
                      style: const TextStyle(fontSize: 13),
                    ),
                    const SizedBox(height: 21),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        for (final tech in project.tech.take(2)) Tag(tech),
                        if (project.tech.length > 2)
                          Tag('+${project.tech.length - 2}'),
                      ],
                    ),
                    const SizedBox(height: 21),
                    const Divider(height: 1),
                    const SizedBox(height: 17),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            'View project',
                            style: TextStyle(
                              fontSize: 13,
                              color: Palette.ink,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Icon(Icons.north_east, size: 18, color: Palette.ink),
                      ],
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
}
