import 'package:flutter/material.dart';

import 'portfolio_data.dart';
import 'portfolio_theme.dart';
import 'portfolio_widgets.dart';
import 'project_art.dart';

class NewForm extends StatelessWidget {
  const NewForm({super.key, required this.project});

  final PortfolioItem project;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 700;
    return Scaffold(
      appBar: AppBar(
        title: Text('Project overview', style: PortfolioTheme.display(17)),
        backgroundColor: Palette.paper,
        surfaceTintColor: Palette.paper,
        centerTitle: true,
        leading: IconButton(
          tooltip: 'Back to portfolio',
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ContentWidth(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 36),
              child: SelectionArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Eyebrow(project.category, color: project.color),
                    const SizedBox(height: 14),
                    Text(
                      project.title,
                      style: PortfolioTheme.display(compact ? 36 : 54),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      project.subtitle,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 32),
                    Hero(
                      tag: project.kind,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: ProjectArt(project: project),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Original concept illustration · A visual interpretation of the project',
                      style: TextStyle(fontSize: 11, color: Palette.muted),
                    ),
                    const SizedBox(height: 42),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final overview = Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              project.focus,
                              style: PortfolioTheme.display(28),
                            ),
                            const SizedBox(height: 20),
                            Text(project.description),
                            const SizedBox(height: 25),
                            for (final feature in project.features)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 13),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Icon(
                                        Icons.arrow_right_alt,
                                        size: 20,
                                        color: Palette.blue,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(child: Text(feature)),
                                  ],
                                ),
                              ),
                          ],
                        );
                        final toolkit = Container(
                          padding: const EdgeInsets.all(26),
                          decoration: BoxDecoration(
                            color: Palette.sky,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Eyebrow('Built with'),
                              const SizedBox(height: 20),
                              Wrap(
                                spacing: 8,
                                runSpacing: 10,
                                children: [
                                  for (final tech in project.tech) Tag(tech),
                                ],
                              ),
                              const SizedBox(height: 28),
                              const Text(
                                'Curious about this project?',
                                style: TextStyle(
                                  color: Palette.ink,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 12),
                              FilledButton.icon(
                                onPressed:
                                    () => openContact(
                                      context,
                                      Uri(
                                        scheme: 'mailto',
                                        path: Profile.email,
                                        query:
                                            'subject=${Uri.encodeComponent('Let’s talk about ${project.title}')}',
                                      ).toString(),
                                    ),
                                label: const Text("Let's talk"),
                                icon: const Icon(Icons.north_east, size: 16),
                              ),
                            ],
                          ),
                        );
                        if (constraints.maxWidth < 700) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              overview,
                              const SizedBox(height: 28),
                              toolkit,
                            ],
                          );
                        }
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 6, child: overview),
                            const SizedBox(width: 60),
                            Expanded(flex: 4, child: toolkit),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 45),
                    const Divider(),
                    const SizedBox(height: 20),
                    OutlinedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, size: 17),
                      label: const Text('Back to all projects'),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
