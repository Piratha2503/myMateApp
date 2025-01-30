import 'package:flutter/material.dart';
import '../../MyMateCommonBodies/MyMateApis.dart';
import '../../MyMateThemes.dart';

class ExpectationsWidget extends StatefulWidget {
  final String docId;

  ExpectationsWidget({required this.docId, Key? key}) : super(key: key);

  @override
  _ExpectationsWidgetState createState() => _ExpectationsWidgetState();
}

class _ExpectationsWidgetState extends State<ExpectationsWidget> {
  List<TextEditingController> controllers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getClient();
  }

  Future<void> getClient() async {
    try {
      final data = await fetchUserById(widget.docId);

      if (data.isNotEmpty) {
        setState(() {
          final expectations = data['expectations'] ?? [];
          if (expectations is List<String>) {
            controllers = expectations
                .map((expectation) => TextEditingController(text: expectation))
                .toList();
          } else if (expectations is List) {
            controllers = expectations
                .whereType<String>()
                .map((expectation) => TextEditingController(text: expectation))
                .toList();
          }
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Client data not found!')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Widget _buildExpectations() {
    return Column(
      children: List.generate(
        controllers.length,
            (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Center(
            child: Container(
              height: 34,
              width: 297,
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: MyMateThemes.containerColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  controllers[index].text,
                  style: TextStyle(
                    color: MyMateThemes.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  softWrap: false,
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : _buildExpectations();
  }
}
