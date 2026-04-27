import 'package:flutter/material.dart';

class ServiceHubPage extends StatefulWidget {
  const ServiceHubPage({super.key});

  @override
  State<ServiceHubPage> createState() => _ServiceHubPageState();
}

class _ServiceHubPageState extends State<ServiceHubPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  static const List<_JobRequest> _requests = <_JobRequest>[
    _JobRequest(
      customer: 'Lera',
      title: 'Apartment Renovation',
      snippet: 'Need painting, flooring refresh, and kitchen cabinet updates.',
    ),
    _JobRequest(
      customer: 'Askar',
      title: 'Deep Home Cleaning',
      snippet: 'Move-out cleanup for a 2-bedroom apartment this weekend.',
    ),
    _JobRequest(
      customer: 'Dana',
      title: 'Furniture Assembly',
      snippet: 'Assemble wardrobe, desk, and two side tables.',
    ),
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _postProject() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Project posted successfully.')),
    );
    _titleController.clear();
    _descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Service Hub'),
          bottom: const TabBar(
            tabs: <Tab>[
              Tab(text: 'Post a Job'),
              Tab(text: 'Browse Requests'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Post a New Project',
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Describe your requirements and receive bids from pros.',
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _titleController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Project Title',
                        hintText: 'Kitchen plumbing repair',
                        prefixIcon: Icon(Icons.title),
                      ),
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a project title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: 'Detailed Description',
                        hintText: 'Explain scope, timing, and special requests...',
                        alignLabelWithHint: true,
                      ),
                      validator: (String? value) {
                        if (value == null || value.trim().length < 12) {
                          return 'Please add at least 12 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),
                    FilledButton.icon(
                      onPressed: _postProject,
                      icon: const Icon(Icons.publish_outlined),
                      label: const Text('Post Project'),
                    ),
                  ],
                ),
              ),
            ),
            ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _requests.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (BuildContext context, int index) {
                final _JobRequest request = _requests[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${request.customer}: ${request.title}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: colors.onSurface,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          request.snippet,
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: FilledButton.tonalIcon(
                            onPressed: () {},
                            icon: const Icon(Icons.handshake_outlined),
                            label: const Text('Bid / Apply'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _JobRequest {
  const _JobRequest({
    required this.customer,
    required this.title,
    required this.snippet,
  });

  final String customer;
  final String title;
  final String snippet;
}
