import 'package:flutter/material.dart';
import 'candidates.dart';

class ResultPage extends StatefulWidget {
  final List<Candidate> candidates;

  const ResultPage({required this.candidates, super.key});

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des candidats'),
      ),
      body: ListView.builder(
        itemCount: widget.candidates.length,
        itemBuilder: (context, index) {
          final candidate = widget.candidates[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: candidate.imageUrl.isNotEmpty
                  ? NetworkImage(candidate.imageUrl)
                  : const AssetImage('C:\Users\hp\Pictures\autre') as ImageProvider,
            ),
            title: Text('${candidate.name} ${candidate.surname}'),
            onTap: () {
              _showCandidateDetails(candidate);
            },
          );
        },
      ),
    );
  }

  void _showCandidateDetails(Candidate candidate) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('${candidate.name} ${candidate.surname}'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (candidate.imageUrl.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Image.network(
                    candidate.imageUrl,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              Text('Parti : ${candidate.party}'),
              const SizedBox(height: 8),
              Text('Biographie : ${candidate.bio}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fermer'),
            ),
          ],
        );
      },
    );
  }
}