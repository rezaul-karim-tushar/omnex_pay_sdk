import 'package:flutter/material.dart';

/// Widget to display API response in a formatted, readable way
class ResponseDisplayWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  const ResponseDisplayWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildResponseItems(data, 0),
      ),
    );
  }

  List<Widget> _buildResponseItems(dynamic data, int indentLevel) {
    if (data is Map<String, dynamic>) {
      return data.entries.map((entry) {
        return _buildItem(entry.key, entry.value, indentLevel);
      }).toList();
    } else if (data is List) {
      return data.asMap().entries.map((entry) {
        return _buildItem('[${entry.key}]', entry.value, indentLevel);
      }).toList();
    } else {
      return [
        Padding(
          padding: EdgeInsets.only(left: indentLevel * 16.0),
          child: Text(
            data.toString(),
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ];
    }
  }

  Widget _buildItem(String key, dynamic value, int indentLevel) {
    if (value is Map<String, dynamic>) {
      return Padding(
        padding: EdgeInsets.only(left: indentLevel * 16.0, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$key:', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 4),
            ..._buildResponseItems(value, indentLevel + 1),
          ],
        ),
      );
    } else if (value is List) {
      return Padding(
        padding: EdgeInsets.only(left: indentLevel * 16.0, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$key:', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 4),
            ..._buildResponseItems(value, indentLevel + 1),
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(left: indentLevel * 16.0, bottom: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$key: ', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            Expanded(child: Text(_formatValue(value), style: const TextStyle(fontSize: 14))),
          ],
        ),
      );
    }
  }

  String _formatValue(dynamic value) {
    if (value == null) {
      return 'null';
    } else if (value is String) {
      return value;
    } else if (value is num) {
      return value.toString();
    } else if (value is bool) {
      return value.toString();
    } else {
      return value.toString();
    }
  }
}

